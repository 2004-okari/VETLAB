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