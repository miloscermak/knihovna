import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'
import Stripe from 'https://esm.sh/stripe@13.11.0?target=deno'

const stripe = new Stripe(Deno.env.get('STRIPE_SECRET_KEY') ?? '', {
  apiVersion: '2023-10-16',
})

const endpointSecret = Deno.env.get('STRIPE_WEBHOOK_SECRET') ?? ''

serve(async (req) => {
  // Webhook endpoints don't need authorization
  if (req.method === 'POST') {
    try {
      const signature = req.headers.get('stripe-signature')
      if (!signature) {
        return new Response(JSON.stringify({ error: 'No stripe signature' }), {
          status: 400,
          headers: { 'Content-Type': 'application/json' },
        })
      }

      const body = await req.text()
      
      let event
      try {
        event = stripe.webhooks.constructEvent(body, signature, endpointSecret)
      } catch (err) {
        console.error(`Webhook signature verification failed.`, err.message)
        return new Response(JSON.stringify({ error: 'Invalid signature' }), {
          status: 400,
          headers: { 'Content-Type': 'application/json' },
        })
      }

      // Initialize Supabase client with service role
      const supabaseUrl = Deno.env.get('SUPABASE_URL') ?? ''
      const supabaseServiceKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
      const supabase = createClient(supabaseUrl, supabaseServiceKey)

      // Handle the event
      switch (event.type) {
        case 'checkout.session.completed': {
          const session = event.data.object as Stripe.Checkout.Session
          
          // Get metadata from session
          const ticketTypeId = session.metadata?.ticketTypeId
          const quantity = parseInt(session.metadata?.quantity || '1')
          
          if (!ticketTypeId) {
            console.error('No ticketTypeId in session metadata')
            break
          }

          // Create tickets with QR codes
          const tickets = []
          for (let i = 0; i < quantity; i++) {
            const ticketId = crypto.randomUUID()
            tickets.push({
              id: ticketId,
              ticket_type_id: parseInt(ticketTypeId),
              stripe_payment_id: session.payment_intent as string,
              email: session.customer_email || '',
              status: 'paid',
              purchase_date: new Date().toISOString(),
              qr_code: ticketId, // QR code contains ticket ID
              metadata: {
                session_id: session.id,
                amount: session.amount_total,
              },
            })
          }

          const { error: ticketError } = await supabase
            .from('tickets')
            .insert(tickets)

          if (ticketError) {
            console.error('Error creating tickets:', ticketError)
            break
          }

          // Update sold quantity
          const { data: ticketType } = await supabase
            .from('ticket_types')
            .select('sold_quantity')
            .eq('id', ticketTypeId)
            .single()

          if (ticketType) {
            await supabase
              .from('ticket_types')
              .update({ sold_quantity: ticketType.sold_quantity + quantity })
              .eq('id', ticketTypeId)
          }

          console.log(`Successfully processed payment for ${quantity} tickets`)
          break
        }
        default:
          console.log(`Unhandled event type ${event.type}`)
      }

      return new Response(JSON.stringify({ received: true }), {
        status: 200,
        headers: { 'Content-Type': 'application/json' },
      })
    } catch (error) {
      console.error('Webhook error:', error)
      return new Response(JSON.stringify({ error: error.message }), {
        status: 500,
        headers: { 'Content-Type': 'application/json' },
      })
    }
  }

  return new Response('Method not allowed', { status: 405 })
})