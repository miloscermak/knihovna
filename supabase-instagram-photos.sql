-- Create Instagram photos table for admin-managed Instagram feed
CREATE TABLE IF NOT EXISTS instagram_photos (
    id SERIAL PRIMARY KEY,
    url VARCHAR(500) NOT NULL,
    caption VARCHAR(200),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Add some example photos (optional - can be added via admin panel)
INSERT INTO instagram_photos (url, caption) VALUES 
('https://images.unsplash.com/photo-1540039155733-5bb30b53aa14?w=300&h=300&fit=crop', 'Stand-up večer v Knihovně'),
('https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop', 'Diskuze o literatuře'),
('https://images.unsplash.com/photo-1590086782792-42dd2350140d?w=300&h=300&fit=crop', 'Workshop tvořivého psaní'),
('https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?w=300&h=300&fit=crop', 'Filmový večer v klubu');

-- Enable RLS (Row Level Security) but allow public read access
ALTER TABLE instagram_photos ENABLE ROW LEVEL SECURITY;

-- Policy for public read access
CREATE POLICY "Allow public read access to instagram_photos" ON instagram_photos
    FOR SELECT TO anon
    USING (true);

-- Policy for authenticated users to insert/update/delete (admin functions)
CREATE POLICY "Allow authenticated users full access to instagram_photos" ON instagram_photos
    FOR ALL TO authenticated
    USING (true)
    WITH CHECK (true);