/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id serial PRIMARY KEY,
    name varchar(100),
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg decimal,
    species_id integer
);

-- Alter to add new column
ALTER TABLE animals
ADD COLUMN species varchar(255);

-- owners table
CREATE TABLE owners (
    id serial PRIMARY KEY,
    full_name varchar(255),
    age integer
);

-- species table
CREATE TABLE species (
    id serial PRIMARY KEY,
    name varchar(255)
);

-- Removing species column
ALTER TABLE animals
DROP COLUMN species;

-- Adding species_id column
ALTER TABLE animals
ADD COLUMN species_id varchar(255)
FOREIGN KEY (species_id)
REFERENCES species(id);

-- Addiing owners_id
ALTER TABLE animals
ADD COLUMN owner_id INTEGER,
ADD CONSTRAINT fk_owner
FOREIGN KEY (owner_id)
REFERENCES owners(id);

-- add species_id
UPDATE animals
SET species_id = (
    CASE
        WHEN name LIKE '%mon' THEN
            (SELECT id FROM species WHERE name = 'Digimon')
        ELSE
            (SELECT id FROM species WHERE name = 'Pokemon')
    END
);

--