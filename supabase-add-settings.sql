-- Přidání dalších nastavitelných textů do settings tabulky
-- Spusťte v SQL editoru Supabase

INSERT INTO settings (key, value) VALUES 
('about_description', 'Pořádáme autorská čtení, diskuze, workshopy tvůrčího psaní a filmové projekce. Náš prostor je otevřený všem, kdo hledají inspiraci, klid na čtení nebo společnost podobně naladěných lidí.'),
('opening_hours', 'Po–Pá: 10:00–21:00<br>So–Ne: 11:00–19:00'),
('contact_address', 'Nerudova 47<br>118 00 Praha 1'),
('contact_email', 'info@knihovnacs.cz'),
('contact_phone', '+420 123 456 789')
ON CONFLICT (key) DO UPDATE SET value = EXCLUDED.value;