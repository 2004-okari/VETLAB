/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES 
  ('Agumon', '2020-02-03', 0, true, 10.23),
  ('Gabumon', '2018-11-15', 2, true, 8.00),
  ('Pikachu', '2021-01-07', 1, false, 15.04),
  ('Devimon', '2017-05-02', 5, true, 11.00),
  ('Charmander', '2020-02-08', 0, false, 11.00),
  ('Plantmon', '2021-11-15', 2, true, 5.70),
  ('Squirtle', '1993-04-02', 3, false, 12.13),
  ('Angemon', '2005-06-12', 1, true, 45.00),
  ('Boarmon', '2005-06-07', 7, true, 24.00),
  ('Blossom', '1998-10-13', 3, true, 17.00),
  ('Ditto', '2022-05-14', 4, true, 22.00);

INSERT INTO owners (full_name, age)
VALUES 
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

INSERT INTO species (name)
VALUES 
  ('Pokemon'),
  ('Digimon');

UPDATE animals
SET owner_id = CASE
    WHEN name = 'Agumon' THEN 1
    WHEN name IN ('Gabumon', 'Pikachu') THEN 2
    WHEN name IN ('Devimon', 'Plantmon') THEN 3
    WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN 4
    WHEN name IN ('Angemon', 'Boarmon') THEN 5
END;

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

INSERT INTO vets (name, age, date_of_graduation) 
VALUES 
  ('William Tatcher', 45, '2000-04-23'),
  ('Maisy Smith', 26, '2019-01-17'),
  ('Stephanie Mendez', 64, '1981-05-04'),
  ('Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations (vet_id, species_id) 
VALUES
  (1,1),
  (3,1),
  (3,2),
  (4,2);

INSERT INTO visits (animal_id, vet_id, date_of_visit) 
VALUES 
  (1, 1, '2020-05-24'),
  (1, 3, '2020-07-22'),
  (2, 4, '2021-02-02'),
  (3, 2, '2020-01-05'),
  (3, 2, '2020-03-08'),
  (3, 2, '2020-05-14'),
  (4, 3, '2021-05-04'),
  (6, 4, '2021-02-24'),
  (7, 2, '2013-12-21'),
  (7, 1, '202-08-10'),
  (7, 2, '2021-04-07'),
  (8, 3, '2019-09-29'),
  (9, 4, '2020-10-03'),
  (9, 4, '2020-11-04'),
  (10, 2, '2019-01-24'),
  (10, 2, '2019-05-15'),
  (10, 2, '2020-07-27'),
  (10, 2, '2020-03-03'),
  (11, 3, '2020-05-24'),
  (11, 1, '2021-01-11');