/*Queries that provide answers to the questions from all projects.*/

SELECT name 
from animals 
WHERE name LIKE '%mon';

SELECT name 
from animals 
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT name 
from animals 
WHERE neutered = true AND escape_attempts < 3;

SELECT date_of_birth 
from animals 
WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts 
from animals 
WHERE weight_kg > 10.5;

SELECT * 
from animals 
WHERE neutered = true;

SELECT * 
from animals 
WHERE NOT name = 'Gabumon';

SELECT * 
from animals 
WHERE weight_kg BETWEEN 10.4 AND 17.3;

SELECT COUNT(*)
FROM animals;

SELECT COUNT(*)
FROM animals
WHERE escape_attempts = 0;

SELECT AVG(weight_kg)
FROM animals;

SELECT neutered, MAX(escape_attempts)
FROM animals 
GROUP BY neutered;

SELECT species, MIN(weight_kg), MAX(weight_kg)
FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts) 
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

-- transaction 1
BEGIN;
UPDATE animals SET species = 'unspecified' ;
SELECT * FROM animals ;
ROLLBACK;
SELECT * FROM animals ;

-- transaction 2
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals ;
COMMIT;
SELECT * FROM animals ;

-- transaction 3
BEGIN;
DELETE FROM animals;
SELECT * FROM animals ;
ROLLBACK;
SELECT * FROM animals ;

-- transaction 3
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT weight_update_savepoint;
SELECT * FROM animals ;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT weight_update_savepoint;
SELECT * FROM animals ;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals ;

-- What animals belong to Melody Pond?
SELECT name 
FROM animals 
INNER JOIN owners ON animals.owner_id = owners.id 
WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name
FROM animals
INNER JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

-- List all owners and their animals, including those who don't own any animals.
SELECT owners.full_name, COALESCE(animals.name, 'No animal')
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

-- How many animals are there per species?
SELECT species.name, COUNT(*)
FROM animals
INNER JOIN species ON animals.species_id = species.id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name
FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
INNER JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name
FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT owners.full_name, COUNT(animals.owner_id)
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY COUNT(animals.owner_id) DESC
LIMIT 1;