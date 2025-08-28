# Stripe Payment System Implementation Instructions

## Project Context
This is a cultural club website for "Knihovna Čermáka a Staňka" built with vanilla HTML/CSS/JS, Supabase backend, and GitHub Pages hosting. We need to add direct ticket purchasing functionality using Stripe.

## Backend Status (Already Completed)
- ✅ Supabase Edge Functions deployed:
  - `stripe-webhook`: https://eyfgtagudbvzorrdntdf.supabase.co/functions/v1/stripe-webhook
  - `create-checkout-session`: https://eyfgtagudbvzorrdntdf.supabase.co/functions/v1/create-checkout-session
- ✅ Database tables created: `ticket_types`, `tickets`
- ✅ Environment variables set in Supabase
- ✅ Stripe webhook configured

## Frontend Implementation Required

### 1. Add Stripe SDK to knihovna.html
Add before closing `</head>` tag:
```html
<!-- Stripe JavaScript SDK -->
<script src="https://js.stripe.com/v3/"></script>
```

### 2. Initialize Stripe in JavaScript section
Add after existing JavaScript:
```javascript
// Initialize Stripe (replace with actual publishable key)
const stripe = Stripe('pk_test_YOUR_PUBLISHABLE_KEY_HERE');
```

### 3. Modify Event Detail Display
Extend the `createEventDetailHTML` function or add new function to include ticket purchasing section:

```html
<!-- Add this section to event detail template -->
<div class="p-6 border-t border-gray-200" id="ticket-section-${event.id}">
  <h3 class="text-xl font-bold text-gray-900 mb-4">🎫 Vstupenky</h3>
  <div id="ticket-types-${event.id}" class="space-y-3">
    <!-- Dynamically loaded ticket types -->
  </div>
</div>
```

### 4. Add Ticket Management Functions
Add these JavaScript functions:

```javascript
// Load ticket types for an event
async function loadTicketTypes(eventId) {
  try {
    const { data: ticketTypes, error } = await supabase
      .from('ticket_types')
      .select('*')
      .eq('event_id', eventId)
      .eq('is_active', true)
      .order('price', { ascending: true });

    if (error) throw error;

    const container = document.getElementById(`ticket-types-${eventId}`);
    if (!container || !ticketTypes.length) {
      container.innerHTML = '<p class="text-gray-600">Vstupenky nejsou v prodeji</p>';
      return;
    }

    container.innerHTML = ticketTypes.map(ticketType => {
      const available = ticketType.max_quantity - ticketType.sold_quantity;
      const priceKc = (ticketType.price / 100).toFixed(0);
      
      return `
        <div class="border border-gray-200 rounded-lg p-4 flex justify-between items-center">
          <div>
            <h4 class="font-semibold text-gray-900">${ticketType.name}</h4>
            <p class="text-sm text-gray-600">${ticketType.description || ''}</p>
            <p class="text-lg font-bold text-red-600">${priceKc} Kč</p>
            <p class="text-xs text-gray-500">Zbývá: ${available} ks</p>
          </div>
          <div class="flex items-center space-x-2">
            <select id="quantity-${ticketType.id}" class="border border-gray-300 rounded px-2 py-1 w-16">
              ${Array.from({length: Math.min(available, 10)}, (_, i) => 
                `<option value="${i+1}">${i+1}</option>`
              ).join('')}
            </select>
            <button 
              onclick="purchaseTicket('${eventId}', '${ticketType.id}')"
              class="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded-lg font-semibold transition-colors ${available === 0 ? 'opacity-50 cursor-not-allowed' : ''}"
              ${available === 0 ? 'disabled' : ''}
            >
              ${available === 0 ? 'Vyprodáno' : 'Koupit'}
            </button>
          </div>
        </div>
      `;
    }).join('');

  } catch (error) {
    console.error('Chyba při načítání vstupenek:', error);
  }
}

// Purchase ticket function
async function purchaseTicket(eventId, ticketTypeId) {
  const quantitySelect = document.getElementById(`quantity-${ticketTypeId}`);
  const quantity = parseInt(quantitySelect.value);

  try {
    // Show loading state
    const button = event.target;
    button.innerHTML = 'Zpracovává se...';
    button.disabled = true;

    // Get event and ticket type details
    const [eventResponse, ticketTypeResponse] = await Promise.all([
      supabase.from('events').select('*').eq('id', eventId).single(),
      supabase.from('ticket_types').select('*').eq('id', ticketTypeId).single()
    ]);

    if (eventResponse.error || ticketTypeResponse.error) {
      throw new Error('Chyba při načítání dat');
    }

    const event = eventResponse.data;
    const ticketType = ticketTypeResponse.data;

    // Create Stripe Checkout session
    const response = await fetch('https://eyfgtagudbvzorrdntdf.supabase.co/functions/v1/create-checkout-session', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${supabaseKey}` // Use your anon key
      },
      body: JSON.stringify({
        eventId: eventId,
        ticketTypeId: ticketTypeId,
        quantity: quantity,
        eventName: event.title,
        ticketTypeName: ticketType.name,
        unitPrice: ticketType.price,
        totalAmount: ticketType.price * quantity
      })
    });

    if (!response.ok) {
      throw new Error('Chyba při vytváření platby');
    }

    const session = await response.json();

    // Redirect to Stripe Checkout
    const result = await stripe.redirectToCheckout({
      sessionId: session.sessionId
    });

    if (result.error) {
      throw new Error(result.error.message);
    }

  } catch (error) {
    alert('Chyba při nákupu: ' + error.message);
    // Reset button
    button.innerHTML = 'Koupit';
    button.disabled = false;
  }
}

// Handle payment result
document.addEventListener('DOMContentLoaded', function() {
  // Load ticket types for all displayed events
  document.querySelectorAll('[id^="ticket-section-"]').forEach(section => {
    const eventId = section.id.replace('ticket-section-', '');
    loadTicketTypes(eventId);
  });

  // Handle payment result
  const urlParams = new URLSearchParams(window.location.search);
  if (urlParams.get('payment') === 'success') {
    showPaymentSuccess();
  } else if (urlParams.get('payment') === 'cancelled') {
    showPaymentCancelled();
  }
});

function showPaymentSuccess() {
  const modal = document.createElement('div');
  modal.innerHTML = `
    <div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
      <div class="bg-white p-6 rounded-lg max-w-md">
        <h3 class="text-lg font-bold text-green-600 mb-3">✅ Platba úspěšná!</h3>
        <p>Vstupenka byla zakoupena. Detaily najdete v emailu.</p>
        <button onclick="this.closest('.fixed').remove()" class="mt-4 bg-green-600 text-white px-4 py-2 rounded">
          OK
        </button>
      </div>
    </div>
  `;
  document.body.appendChild(modal);
}

function showPaymentCancelled() {
  alert('Platba byla zrušena.');
}
```

### 5. Admin Panel Extensions
Add ticket type management to admin.html:

```javascript
// Add ticket type form to event management
function createTicketTypeForm(eventId) {
  return `
    <div class="mb-6 p-4 border border-gray-200 rounded-lg">
      <h4 class="font-bold mb-3">Nový typ vstupenky</h4>
      <div class="grid grid-cols-2 gap-4">
        <input type="text" id="ticket-name" placeholder="Název (např. Standardní)" class="border border-gray-300 rounded px-3 py-2">
        <input type="number" id="ticket-price" placeholder="Cena v Kč" class="border border-gray-300 rounded px-3 py-2">
        <input type="number" id="ticket-max" placeholder="Max. počet" class="border border-gray-300 rounded px-3 py-2">
        <input type="text" id="ticket-desc" placeholder="Popis (volitelné)" class="border border-gray-300 rounded px-3 py-2">
      </div>
      <button onclick="addTicketType('${eventId}')" class="mt-3 bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700">
        Přidat typ vstupenky
      </button>
    </div>
  `;
}

async function addTicketType(eventId) {
  const name = document.getElementById('ticket-name').value;
  const price = parseInt(document.getElementById('ticket-price').value) * 100; // convert to cents
  const maxQuantity = parseInt(document.getElementById('ticket-max').value);
  const description = document.getElementById('ticket-desc').value;

  if (!name || !price || !maxQuantity) {
    alert('Vyplňte všechna povinná pole');
    return;
  }

  try {
    const { error } = await supabase
      .from('ticket_types')
      .insert({
        event_id: eventId,
        name,
        price,
        description,
        max_quantity: maxQuantity
      });

    if (error) throw error;
    
    alert('Typ vstupenky byl přidán');
    location.reload();
  } catch (error) {
    alert('Chyba: ' + error.message);
  }
}
```

## Configuration Required

### Replace placeholder values:
1. `pk_test_YOUR_PUBLISHABLE_KEY_HERE` - Your Stripe publishable key
2. `supabaseKey` - Your Supabase anon key
3. Verify the Supabase project URL in Edge Function calls

## Testing Instructions

1. **Admin panel**: Add ticket types to existing events
2. **Frontend**: Verify ticket types load on event detail pages
3. **Purchase flow**: Test complete purchase process with Stripe test cards:
   - Success: 4242 4242 4242 4242
   - Declined: 4000 0000 0000 0002

## Files to Modify
- `knihovna.html` - Main website file
- `admin.html` - Admin panel file

## Expected Behavior
- Events display ticket purchase options when ticket types exist
- Clicking "Koupit" redirects to Stripe Checkout
- Successful payments redirect back with confirmation
- Admin panel allows creating ticket types with different price levels
- Inventory management prevents overselling