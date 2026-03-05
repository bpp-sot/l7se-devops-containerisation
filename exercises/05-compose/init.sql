-- init.sql — run automatically when the database container first starts
CREATE TABLE IF NOT EXISTS messages (
    id      SERIAL PRIMARY KEY,
    content TEXT NOT NULL,
    created TIMESTAMPTZ DEFAULT NOW()
);

INSERT INTO messages (content) VALUES
    ('Hello from the database!'),
    ('The Compose stack is working.');
