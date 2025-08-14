-- Supabase Database Schema for Knihovna Čermáka a Staňka
-- Spusťte tyto příkazy v SQL editoru vašeho Supabase projektu

-- 1. Events table - události/program
CREATE TABLE events (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    type VARCHAR(20) NOT NULL CHECK (type IN ('cteni', 'diskuze', 'workshop', 'film')),
    date DATE NOT NULL,
    time TIME NOT NULL,
    description TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Subscribers table - newsletter přihlášení
CREATE TABLE subscribers (
    id BIGSERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    subscribed_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. Settings table - nastavení webu (text O nás, atd.)
CREATE TABLE settings (
    key VARCHAR(50) PRIMARY KEY,
    value TEXT NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. Insert default settings
INSERT INTO settings (key, value) VALUES 
('about_text', 'Knihovna Čermáka a Staňka je nezávislý kulturní prostor v srdci města, který spojuje milovníky literatury, umění a dobrých rozhovorů. Vznikli jsme s vizí vytvořit místo, kde se prolíná tradiční knihovnická atmosféra s živou současnou kulturou.');

-- 5. Row Level Security policies

-- Enable RLS on all tables
ALTER TABLE events ENABLE ROW LEVEL SECURITY;
ALTER TABLE subscribers ENABLE ROW LEVEL SECURITY;
ALTER TABLE settings ENABLE ROW LEVEL SECURITY;

-- Events policies
CREATE POLICY "Events are viewable by everyone" ON events FOR SELECT USING (true);
CREATE POLICY "Events are insertable by authenticated users" ON events FOR INSERT WITH CHECK (auth.role() = 'authenticated');
CREATE POLICY "Events are updatable by authenticated users" ON events FOR UPDATE USING (auth.role() = 'authenticated');
CREATE POLICY "Events are deletable by authenticated users" ON events FOR DELETE USING (auth.role() = 'authenticated');

-- Subscribers policies  
CREATE POLICY "Subscribers are viewable by authenticated users" ON subscribers FOR SELECT USING (auth.role() = 'authenticated');
CREATE POLICY "Subscribers are insertable by everyone" ON subscribers FOR INSERT WITH CHECK (true);
CREATE POLICY "Subscribers are deletable by authenticated users" ON subscribers FOR DELETE USING (auth.role() = 'authenticated');

-- Settings policies
CREATE POLICY "Settings are viewable by everyone" ON settings FOR SELECT USING (true);
CREATE POLICY "Settings are updatable by authenticated users" ON settings FOR UPDATE USING (auth.role() = 'authenticated');

-- 6. Sample data (optional)
INSERT INTO events (title, type, date, time, description) VALUES 
('Setkání s Petrem Novákem', 'cteni', '2024-02-15', '19:00', 'Autorské čtení z nové sbírky poezie "Městské světla". Součástí večera bude i diskuze s autorem.'),
('Workshop tvůrčího psaní', 'workshop', '2024-02-18', '10:00', 'Celodenní workshop zaměřený na techniky vyprávění krátkých příběhů. Lektor: Marie Svobodová.'),
('Diskuze: Budoucnost knihoven', 'diskuze', '2024-02-20', '18:00', 'Panelová diskuze o roli knihoven v digitální době. Hosté z České republiky i zahraničí.'),
('Projekce: Paterson', 'film', '2024-02-22', '20:00', 'Film Jima Jarmusche o básníkovi řidiči autobusu. Po projekci následuje diskuze o poezii v každodenním životě.');

-- 7. Function to update timestamps
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Apply timestamp trigger to events
CREATE TRIGGER update_events_updated_at BEFORE UPDATE ON events FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Apply timestamp trigger to settings  
CREATE TRIGGER update_settings_updated_at BEFORE UPDATE ON settings FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();