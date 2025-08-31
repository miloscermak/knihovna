-- SQL pro vytvoření email systému s QR kódy vstupenek
-- Spusťte v Supabase SQL editoru

-- 1. Přidat email template tabulku
CREATE TABLE IF NOT EXISTS public.email_templates (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    subject TEXT NOT NULL,
    html_content TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Vložit template pro vstupenky
INSERT INTO email_templates (name, subject, html_content) VALUES (
    'ticket_confirmation',
    'Vaše vstupenka - {{event_name}}',
    '<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <style>
        body { font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; }
        .ticket { border: 2px solid #c9a961; border-radius: 10px; padding: 20px; margin: 20px 0; background: #f9f9f9; }
        .qr-code { text-align: center; margin: 20px 0; }
        .details { background: white; padding: 15px; border-radius: 5px; margin: 10px 0; }
        .footer { font-size: 12px; color: #666; margin-top: 30px; }
    </style>
</head>
<body>
    <h1>🎫 Vaše vstupenka</h1>
    
    <div class="ticket">
        <h2>{{event_name}}</h2>
        <div class="details">
            <p><strong>Datum:</strong> {{event_date}}</p>
            <p><strong>Čas:</strong> {{event_time}}</p>
            <p><strong>Typ vstupenky:</strong> {{ticket_type}}</p>
            <p><strong>Počet:</strong> {{quantity}}x</p>
            <p><strong>Celková cena:</strong> {{total_price}} Kč</p>
        </div>
        
        <div class="qr-code">
            <img src="https://api.qrserver.com/v1/create-qr-code/?size=200x200&data={{qr_data}}" alt="QR kód vstupenky">
            <p><small>ID vstupenky: {{ticket_id}}</small></p>
        </div>
    </div>
    
    <p>Tuto vstupenku si prosím uložte nebo vytiskněte. QR kód předložte při vstupu na akci.</p>
    
    <div class="footer">
        <p>Knihovna Čermáka a Staňka<br>
        V Přístavu 6, Praha 7<br>
        knihovna.cas@gmail.com</p>
    </div>
</body>
</html>'
) ON CONFLICT (name) DO UPDATE SET 
    subject = EXCLUDED.subject,
    html_content = EXCLUDED.html_content;

-- 3. Aktualizovat webhook funkci pro posílání emailů
CREATE OR REPLACE FUNCTION public.handle_stripe_webhook(payload json)
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  event_type text;
  session_data json;
  ticket_type_id int;
  quantity int;
  customer_email text;
  payment_intent text;
  ticket_ids text[];
  event_record record;
  ticket_type_record record;
  qr_data text;
  email_content text;
  email_subject text;
  i int;
  new_ticket_id text;
BEGIN
  -- Získat typ události
  event_type := payload->>'type';
  
  -- Zpracovat pouze checkout.session.completed
  IF event_type = 'checkout.session.completed' THEN
    session_data := payload->'data'->'object';
    
    -- Získat data ze session
    ticket_type_id := (session_data->'metadata'->>'ticketTypeId')::int;
    quantity := COALESCE((session_data->'metadata'->>'quantity')::int, 1);
    customer_email := session_data->>'customer_email';
    payment_intent := session_data->>'payment_intent';
    
    -- Získat informace o události a typu vstupenky
    SELECT * INTO event_record FROM public.events WHERE id = (session_data->'metadata'->>'eventId')::int;
    SELECT * INTO ticket_type_record FROM public.ticket_types WHERE id = ticket_type_id;
    
    -- Vytvořit vstupenky a získat jejich ID
    ticket_ids := ARRAY[]::text[];
    FOR i IN 1..quantity LOOP
      new_ticket_id := gen_random_uuid()::text;
      
      INSERT INTO public.tickets (
        id,
        ticket_type_id,
        stripe_payment_id,
        email,
        status,
        purchase_date,
        qr_code,
        metadata
      ) VALUES (
        new_ticket_id::uuid,
        ticket_type_id,
        payment_intent,
        customer_email,
        'paid',
        NOW(),
        new_ticket_id, -- QR kód bude obsahovat ID vstupenky
        jsonb_build_object(
          'session_id', session_data->>'id',
          'amount', session_data->>'amount_total'
        )
      );
      
      ticket_ids := array_append(ticket_ids, new_ticket_id);
    END LOOP;
    
    -- Aktualizovat počet prodaných vstupenek
    UPDATE public.ticket_types
    SET sold_quantity = sold_quantity + quantity
    WHERE id = ticket_type_id;
    
    -- Připravit email s QR kódem
    qr_data := 'TICKET:' || ticket_ids[1] || ':EVENT:' || event_record.id || ':TYPE:' || ticket_type_record.id;
    
    -- Získat email template
    SELECT subject, html_content INTO email_subject, email_content 
    FROM email_templates WHERE name = 'ticket_confirmation';
    
    -- Nahradit placeholdery v emailu
    email_subject := replace(email_subject, '{{event_name}}', event_record.title);
    email_content := replace(email_content, '{{event_name}}', event_record.title);
    email_content := replace(email_content, '{{event_date}}', to_char(event_record.date, 'DD.MM.YYYY'));
    email_content := replace(email_content, '{{event_time}}', event_record.time);
    email_content := replace(email_content, '{{ticket_type}}', ticket_type_record.name);
    email_content := replace(email_content, '{{quantity}}', quantity::text);
    email_content := replace(email_content, '{{total_price}}', (ticket_type_record.price * quantity / 100)::text);
    email_content := replace(email_content, '{{qr_data}}', qr_data);
    email_content := replace(email_content, '{{ticket_id}}', ticket_ids[1]);
    
    -- Uložit email do fronty (Supabase má integrované posílání emailů)
    INSERT INTO public.email_queue (
      to_email,
      subject,
      html_content,
      ticket_ids,
      created_at,
      status
    ) VALUES (
      customer_email,
      email_subject,
      email_content,
      ticket_ids,
      NOW(),
      'pending'
    );
    
    RETURN json_build_object(
      'success', true,
      'tickets_created', quantity,
      'ticket_ids', ticket_ids
    );
  END IF;
  
  RETURN json_build_object(
    'success', true,
    'message', format('Ignored event type: %s', event_type)
  );
EXCEPTION
  WHEN OTHERS THEN
    RETURN json_build_object(
      'success', false,
      'error', SQLERRM
    );
END;
$$;

-- 4. Vytvořit tabulku pro email frontu
CREATE TABLE IF NOT EXISTS public.email_queue (
    id SERIAL PRIMARY KEY,
    to_email VARCHAR(255) NOT NULL,
    subject TEXT NOT NULL,
    html_content TEXT NOT NULL,
    ticket_ids text[],
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    sent_at TIMESTAMP WITH TIME ZONE,
    status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'sent', 'failed'))
);

-- 5. Přidat qr_code sloupec do tickets pokud neexistuje
ALTER TABLE public.tickets ADD COLUMN IF NOT EXISTS qr_code TEXT;

-- 6. RLS politiky
ALTER TABLE public.email_queue ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.email_templates ENABLE ROW LEVEL SECURITY;

-- Povolit čtení pro authenticated uživatele
CREATE POLICY "Enable read for authenticated users" ON public.email_queue
    FOR SELECT USING (auth.role() = 'authenticated');

CREATE POLICY "Enable read for authenticated users" ON public.email_templates
    FOR SELECT USING (auth.role() = 'authenticated');