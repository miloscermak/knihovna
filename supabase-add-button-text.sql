-- Add button_text column to events table
ALTER TABLE events ADD COLUMN IF NOT EXISTS button_text VARCHAR(100);

-- Add comment to describe the column
COMMENT ON COLUMN events.button_text IS 'Custom text for event button when shop_link is empty (e.g. "Vstup zdarma", "Vyprodáno")';