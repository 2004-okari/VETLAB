/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id serial PRIMARY KEY,
    name varchar(100),
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg decimal,
    species_id integer,
    owner_id integer
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
ADD COLUMN species_id INTEGER
FOREIGN KEY (species_id)
REFERENCES species(id);

-- Addiing owners_id
ALTER TABLE animals
ADD COLUMN owner_id INTEGER,
ADD CONSTRAINT fk_owner
FOREIGN KEY (owner_id)
REFERENCES owners(id);

-- Create table vets
CREATE TABLE vets (
    id serial PRIMARY KEY,
    name varchar(255),
    age INTEGER,
    date_of_graduation DATE
);


CREATE TABLE specializations (
    species_id INT,
    vet_id INT,
    PRIMARY KEY (species_id, vet_id),
    FOREIGN KEY (species_id)
    REFERENCES species(id),
    FOREIGN KEY (vet_id)
    REFERENCES vets(id)
);

-- Create the visits table
CREATE TABLE visits (
    animal_id INTEGER,
    vet_id INTEGER,
    date_of_visit DATE,
    FOREIGN KEY (animal_id) REFERENCES animals(id),
    FOREIGN KEY (vet_id) REFERENCES vets(id)
);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX idx_visits_animal_id ON visits(animal_id);
CREATE INDEX idx_vet_id ON visits(vet_id);
CREATE INDEX idx_email ON owners(email);
