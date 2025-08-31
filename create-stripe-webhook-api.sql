-- Vytvoření API endpointu pro Stripe webhooky pomocí PostgreSQL funkce
-- Spusťte tento SQL v Supabase SQL editoru

-- 1. Vytvoření funkce pro zpracování webhooků
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
  i int;
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
    
    -- Vytvořit vstupenky
    FOR i IN 1..quantity LOOP
      INSERT INTO public.tickets (
        ticket_type_id,
        stripe_payment_id,
        email,
        status,
        purchase_date,
        metadata
      ) VALUES (
        ticket_type_id,
        payment_intent,
        customer_email,
        'paid',
        NOW(),
        jsonb_build_object(
          'session_id', session_data->>'id',
          'amount', session_data->>'amount_total'
        )
      );
    END LOOP;
    
    -- Aktualizovat počet prodaných vstupenek
    UPDATE public.ticket_types
    SET sold_quantity = sold_quantity + quantity
    WHERE id = ticket_type_id;
    
    RETURN json_build_object(
      'success', true,
      'message', format('Created %s tickets', quantity)
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

-- 2. Povolit funkci pro anonymní přístup
GRANT EXECUTE ON FUNCTION public.handle_stripe_webhook(json) TO anon;
GRANT EXECUTE ON FUNCTION public.handle_stripe_webhook(json) TO authenticated;

-- 3. Otestovat funkci
-- SELECT public.handle_stripe_webhook('{
--   "type": "checkout.session.completed",
--   "data": {
--     "object": {
--       "metadata": {
--         "ticketTypeId": "1",
--         "quantity": "2"
--       },
--       "customer_email": "test@example.com",
--       "payment_intent": "pi_test123",
--       "id": "cs_test123",
--       "amount_total": 20000
--     }
--   }
-- }'::json);