-- Vytvoření jednoduché webhook funkce v Supabase
-- Spusťte tento SQL v Supabase SQL editoru

-- Vytvoření funkce pro zpracování Stripe webhooků
CREATE OR REPLACE FUNCTION handle_stripe_webhook()
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  payload json;
  event_type text;
  session_data json;
  ticket_type_id int;
  quantity int;
BEGIN
  -- Získat data z požadavku
  payload := current_setting('request.body')::json;
  event_type := payload->>'type';
  
  -- Zpracovat pouze checkout.session.completed události
  IF event_type = 'checkout.session.completed' THEN
    session_data := payload->'data'->'object';
    
    -- Získat metadata
    ticket_type_id := (session_data->'metadata'->>'ticketTypeId')::int;
    quantity := (session_data->'metadata'->>'quantity')::int;
    
    -- Vytvořit vstupenky
    INSERT INTO tickets (
      ticket_type_id,
      stripe_payment_id,
      email,
      status,
      purchase_date,
      metadata
    )
    SELECT 
      ticket_type_id,
      session_data->>'payment_intent',
      session_data->>'customer_email',
      'paid',
      NOW(),
      jsonb_build_object(
        'session_id', session_data->>'id',
        'amount', session_data->>'amount_total'
      )
    FROM generate_series(1, quantity);
    
    -- Aktualizovat počet prodaných vstupenek
    UPDATE ticket_types
    SET sold_quantity = sold_quantity + quantity
    WHERE id = ticket_type_id;
    
    RETURN json_build_object('success', true);
  END IF;
  
  RETURN json_build_object('success', true, 'message', 'Event type not handled');
END;
$$;

-- Vytvořit HTTP endpoint pro webhook
-- Toto vytvoří veřejně přístupný endpoint
CREATE OR REPLACE FUNCTION public.stripe_webhook_handler()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  -- Volat webhook handler
  PERFORM handle_stripe_webhook();
  RETURN NEW;
END;
$$;