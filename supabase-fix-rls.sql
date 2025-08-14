-- Fix Row Level Security policies for admin operations
-- Spusťte tyto příkazy v SQL editoru Supabase

-- Option 1: Allow anonymous users to perform admin operations
-- (jednodušší, ale méně bezpečné - spoléháme na frontend autentizaci)

-- Drop existing restrictive policies
DROP POLICY IF EXISTS "Events are insertable by authenticated users" ON events;
DROP POLICY IF EXISTS "Events are updatable by authenticated users" ON events;
DROP POLICY IF EXISTS "Events are deletable by authenticated users" ON events;
DROP POLICY IF EXISTS "Subscribers are deletable by authenticated users" ON subscribers;
DROP POLICY IF EXISTS "Settings are updatable by authenticated users" ON settings;

-- Create new policies that allow anonymous access (controlled by frontend auth)
CREATE POLICY "Events are insertable by everyone" ON events FOR INSERT WITH CHECK (true);
CREATE POLICY "Events are updatable by everyone" ON events FOR UPDATE USING (true);
CREATE POLICY "Events are deletable by everyone" ON events FOR DELETE USING (true);
CREATE POLICY "Subscribers are deletable by everyone" ON subscribers FOR DELETE USING (true);
CREATE POLICY "Settings are updatable by everyone" ON settings FOR UPDATE USING (true);

-- Alternative Option 2: Disable RLS entirely (nejjednodušší pro testování)
-- Uncomment these lines if you prefer to disable RLS completely:

-- ALTER TABLE events DISABLE ROW LEVEL SECURITY;
-- ALTER TABLE subscribers DISABLE ROW LEVEL SECURITY;
-- ALTER TABLE settings DISABLE ROW LEVEL SECURITY;