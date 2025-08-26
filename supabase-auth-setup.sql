-- Supabase Auth Setup pro Knihovna Čermáka a Staňka
-- ================================================

-- 1. Povolit Row Level Security (RLS) na všech tabulkách
ALTER TABLE events ENABLE ROW LEVEL SECURITY;
ALTER TABLE settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE subscribers ENABLE ROW LEVEL SECURITY;

-- 2. Vytvořit admin uživatele (spustit v Supabase SQL editoru)
-- Poznámka: Nahraďte 'admin@knihovnacs.cz' a 'vase-bezpecne-heslo' vašimi údaji
/*
INSERT INTO auth.users (
  instance_id,
  id,
  aud,
  role,
  email,
  encrypted_password,
  email_confirmed_at,
  raw_app_meta_data,
  raw_user_meta_data,
  created_at,
  updated_at
) VALUES (
  '00000000-0000-0000-0000-000000000000',
  gen_random_uuid(),
  'authenticated',
  'authenticated',
  'admin@knihovnacs.cz',
  crypt('vase-bezpecne-heslo', gen_salt('bf')),
  NOW(),
  '{"provider":"email","providers":["email"]}',
  '{"is_admin": true}',
  NOW(),
  NOW()
);
*/

-- 3. Vytvořit RLS politiky pro events tabulku
-- Čtení: všichni můžou číst
CREATE POLICY "Events jsou veřejně čitelné" ON events
  FOR SELECT USING (true);

-- Vkládání, úprava, mazání: pouze přihlášení uživatelé
CREATE POLICY "Pouze přihlášení uživatelé mohou vkládat události" ON events
  FOR INSERT WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Pouze přihlášení uživatelé mohou upravovat události" ON events
  FOR UPDATE USING (auth.role() = 'authenticated');

CREATE POLICY "Pouze přihlášení uživatelé mohou mazat události" ON events
  FOR DELETE USING (auth.role() = 'authenticated');

-- 4. Vytvořit RLS politiky pro settings tabulku
-- Čtení: všichni můžou číst
CREATE POLICY "Nastavení jsou veřejně čitelná" ON settings
  FOR SELECT USING (true);

-- Vkládání, úprava: pouze přihlášení uživatelé
CREATE POLICY "Pouze přihlášení uživatelé mohou měnit nastavení" ON settings
  FOR ALL USING (auth.role() = 'authenticated');

-- 5. Vytvořit RLS politiky pro subscribers tabulku
-- Vkládání: kdokoliv může přidat email (pro newsletter)
CREATE POLICY "Kdokoliv může přidat odběratele" ON subscribers
  FOR INSERT WITH CHECK (true);

-- Čtení, mazání: pouze přihlášení uživatelé
CREATE POLICY "Pouze přihlášení uživatelé mohou číst odběratele" ON subscribers
  FOR SELECT USING (auth.role() = 'authenticated');

CREATE POLICY "Pouze přihlášení uživatelé mohou mazat odběratele" ON subscribers
  FOR DELETE USING (auth.role() = 'authenticated');

-- 6. Vytvořit helper funkci pro kontrolu admin práv
CREATE OR REPLACE FUNCTION is_admin()
RETURNS boolean AS $$
BEGIN
  RETURN auth.jwt() ->> 'is_admin' = 'true';
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 7. Vytvořit funkci pro bezpečné přihlášení
CREATE OR REPLACE FUNCTION authenticate_user(user_email text, user_password text)
RETURNS json AS $$
DECLARE
  authenticated boolean;
  user_id uuid;
BEGIN
  -- Ověřit uživatele
  SELECT id INTO user_id 
  FROM auth.users 
  WHERE email = user_email 
    AND encrypted_password = crypt(user_password, encrypted_password);
  
  IF user_id IS NOT NULL THEN
    RETURN json_build_object(
      'success', true,
      'user_id', user_id,
      'message', 'Přihlášení úspěšné'
    );
  ELSE
    RETURN json_build_object(
      'success', false,
      'message', 'Nesprávné přihlašovací údaje'
    );
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;