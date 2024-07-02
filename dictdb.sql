DROP TABLE IF EXISTS dictionary;

CREATE TABLE IF NOT EXISTS dictionary (
    id SERIAL PRIMARY KEY,
    word TEXT NOT NULL,
    translation TEXT NOT NULL
);