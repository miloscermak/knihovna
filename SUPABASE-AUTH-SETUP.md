# Nastavení Supabase Auth pro Knihovnu Čermáka a Staňka

## Přehled změn

Implementoval jsem bezpečnou autentizaci pomocí Supabase Auth, která nahrazuje nebezpečné hardcoded heslo v JavaScriptu.

### Co bylo změněno:

1. **Vytvořen nový soubor `admin-secure.html`** - Bezpečná administrace s Supabase Auth
2. **Odstraněno hardcoded heslo** z `knihovna.html` - Nyní přesměrovává na bezpečnou administraci
3. **Vytvořeny SQL migrace** v `supabase-auth-setup.sql`
4. **Row Level Security (RLS)** politiky pro všechny tabulky

## Instalační kroky

### 1. Nastavení Supabase Auth

1. Přihlaste se do vašeho Supabase dashboardu
2. Jděte do sekce **Authentication** → **Users**
3. Klikněte na **Invite user** nebo **Add user** → **Send invitation**
4. Zadejte email administrátora (např. `admin@knihovnacs.cz`)
5. Uživatel obdrží email s odkazem pro nastavení hesla

### 2. Aplikace SQL migrací

1. V Supabase dashboardu jděte do **SQL Editor**
2. Otevřete soubor `supabase-auth-setup.sql`
3. Zkopírujte celý obsah a vložte do SQL editoru
4. Spusťte SQL příkazy

### 3. Vytvoření admin uživatele (alternativní metoda)

Pokud chcete vytvořit admin uživatele přímo v SQL:

```sql
-- Nejprve povolit pgcrypto extension
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Vytvořit admin uživatele
INSERT INTO auth.users (
  email,
  encrypted_password,
  email_confirmed_at,
  created_at,
  updated_at
) VALUES (
  'admin@knihovnacs.cz',
  crypt('vase-silne-heslo-123', gen_salt('bf')),
  NOW(),
  NOW(),
  NOW()
);
```

### 4. Testování

1. Otevřete `admin-secure.html` ve webovém prohlížeči
2. Přihlaste se pomocí vytvořených přihlašovacích údajů
3. Ověřte, že vidíte administrační dashboard

## Bezpečnostní vylepšení

### Co bylo opraveno:

1. **Žádné heslo v kódu** - Heslo již není viditelné ve zdrojovém kódu
2. **Server-side autentizace** - Ověření probíhá na Supabase serverech
3. **Session management** - Automatické odhlášení po vypršení session
4. **Šifrovaná komunikace** - Všechna komunikace přes HTTPS
5. **Row Level Security** - Data jsou chráněna na úrovni databáze

### RLS politiky:

- **Events**: Veřejné čtení, editace pouze pro přihlášené
- **Settings**: Veřejné čtení, editace pouze pro přihlášené  
- **Subscribers**: Kdokoliv může přidat email, čtení/mazání pouze pro přihlášené

## Migrace ze starého systému

1. **Aktualizujte odkazy**: Změňte všechny odkazy z `admin.html` na `admin-secure.html`
2. **Informujte administrátory**: Pošlete jim nové přihlašovací údaje
3. **Monitorujte přístupy**: Zkontrolujte Auth logy v Supabase

## Troubleshooting

### Problémy s přihlášením:

1. Zkontrolujte, že email je správně zadán
2. Ověřte, že uživatel má potvrzený email
3. Zkontrolujte Auth logy v Supabase dashboardu

### Chyba "Invalid login credentials":

- Resetujte heslo přes Supabase dashboard
- Ověřte, že RLS politiky jsou správně nastaveny

## Další doporučení

1. **Zapněte 2FA** pro admin účty
2. **Nastavte email šablony** pro reset hesla
3. **Monitorujte neúspěšné pokusy** o přihlášení
4. **Pravidelně aktualizujte** Supabase knihovny

## Kontakt pro podporu

Pokud narazíte na problémy, kontaktujte Supabase support nebo se podívejte do jejich dokumentace: https://supabase.com/docs/guides/auth