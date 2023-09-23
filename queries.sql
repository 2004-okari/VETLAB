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

-- Who was the last animal seen by William Tatcher?
SELECT animals.name 
FROM animals JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id 
WHERE vets.name = 'William Tatcher' 
ORDER BY visits.date_of_visit DESC 
LIMIT 1; 


-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT animals.id)
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, COALESCE(species.name, 'No Specialty')
FROM vets 
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON specializations.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez'
AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name, COUNT(visits.animal_id)
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
GROUP BY (visits.animal_id, animals.name)
ORDER BY COUNT(visits.animal_id) DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name, MIN(visits.date_of_visit)
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
GROUP BY animals.name
ORDER BY MIN(visits.date_of_visit);

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name, vets.name, visits.date_of_visit
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
ORDER BY visits.date_of_visit DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*)
FROM visits
JOIN vets ON visits.vet_id = vets.id
LEFT JOIN specializations ON vets.id = specializations.vet_id
WHERE specializations.species_id IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name, COUNT(*)
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
LEFT JOIN species ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(*) DESC LIMIT 1;