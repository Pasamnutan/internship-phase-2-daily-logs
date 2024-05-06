-- Creating new database
create database discussions49;

--using the newly created database
use discussions49;

--1. Basic Data Selection
SELECT Name, Continent, Population FROM country;

--2. Using Aliases for Columns and Tables
SELECT Name AS 'Country Name' FROM country AS c;

--3. Filtering Data with Basic WHERE Clauses
SELECT Name, Population FROM country WHERE Continent = 'Europe' AND Population > 10000000;

--4. Combining Conditions with AND, OR
SELECT Name, CountryCode FROM city WHERE CountryCode = 'POL' OR CountryCode = 'BEL';

--5. Sorting Results with ORDER BY
SELECT Name, LifeExpectancy FROM country WHERE Continent = 'South America' ORDER BY LifeExpectancy DESC;

--6. Limiting Results with LIMIT
SELECT Name, Population FROM city ORDER BY Population DESC LIMIT 5;