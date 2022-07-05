# SQL (60 mins)

## Objectives

-   Use SQL database technologies

## Relational Databases (5 mins)

**❓ What is a relational database?**<br>
**A: A type of database that stores and provides access to data points that are related to one another through a unique identifier, designed with use of columns and records.**

## SQL (5 mins)

-   [ ] 🗣 Tell students in order to access data inside a relational database we have to use another language called SQL (Structured Query Language).

-   [ ] 🗣 Tell students that some of the SQL commands we’ll cover today may vary with different technical implementations, but the basics will be the same.

-   [ ] ❔ Ask students what they should do if they need to look up an SQL command? (Answer: Google it!)

## Defining Data Structure (5 mins)

-   [ ] 🗣 Tell students the three commands we can use to manipulate the actual structure of the database itself:

    -   Create
    -   Alter
    -   Drop

-   [ ] 🗣 Tell students about each of these commands.

## Manipulating Data (5 mins)

-   [ ] 🗣 Tell students about the following commands that we can use to manipulate and access our data:

    -   Select
    -   Insert
    -   Update
    -   Delete

## Selecting Data (5 mins)

-   [ ] 💻 Show students the following syntax in order to select some data

```sql
SELECT product_name
FROM product;
```

-   [ ] 💻 Show students how to place a restriction on this data

```sql
SELECT product_name
FROM product
WHERE price > 5;
```

-   [ ] 🗣 Tell students they can do more than just one comparison, but that we will leave them to explore the specifics of this!

## Aggregate Functions (5 mins)

-   [ ] 🗣 Tell students that there is the option to retrieve more information about select results by aggregating them.

-   [ ] 🗣 Tell students about aggregate functions:

    -   COUNT
    -   COUNT DISTINCT
    -   SUM
    -   AVG
    -   MAX
    -   MIN

## Grouping (5 mins)

-   [ ] 🗣 Tell students we can also group results together which means that our results are ordered by a specific column.

```sql
SELECT product_name
FROM product
WHERE price > 5
GROUP BY region;
```

## Join (5 mins)

-   [ ] 🗣 Tell students that sometimes we will want to get results from multiple tables and place them in results together we do this by joining tables together.

```sql
SELECT column_list
FROM table1, table2....
WHERE table1.column_name = table2.column_name;
```

-   [ ] 🗣 Tell students about the different types of joins (inner, outer, left and right)

## Running SQL on Our Computers (5 mins)

-   [ ] 🗣 Tell students that now we understand how to manipulate data using SQL, it makes sense that we need to learn how to use it on our machines.

-   [ ] 🗣 Tell students that there are plenty of different SQL implementations we could choose.

-   [ ] 💻 Show students a few of these implementations (PostgreSQL, SQLite)

-   [ ] 🗣 Tell students all of these need to be downloaded to our machines.

-   [ ] 🗣 Tell students that typically beginner programmers will work with SQLite as it’s the smallest and easiest to download, but there are plenty of reasons for using the other implementations too.

## Demo (15 mins)

:computer: Download the lecture's repo into your machine, cd there and install the below lines once in there. 

-   [ ] 💻 Show students how to setup an SQL database.
    - `docker run --name shelter-db --mount type=bind,source="$(pwd)",dst="/code" -e POSTGRES_PASSWORD=password -d postgres`
    - `docker exec -it shelter-db psql -U postgres`

- [ ] 💻 Show students the help commands.
    - `\h`
    - `\h <option>`

- [ ] 💻 Show students how to manually create a new table.

```sql
CREATE TABLE cats (
	id serial PRIMARY KEY,
	name VARCHAR ( 20 ) NOT NULL,
	age INT
);
```

- [ ] 💻 Show students how to view tables.
    - `\dt`

- [ ] 💻 Show students how to delete a table.

```sql
DROP TABLE cats;
```

- [ ] 💻 Show students how to create a `.sql` file.

```sql
-- setup.sql

DROP TABLE IF EXISTS cats;
CREATE TABLE cats (
	id serial PRIMARY KEY,
	name VARCHAR ( 20 ),
	age INT NOT NULL
);
```

- [ ] 💻 Show students how to run a `.sql` file.
    - `\i code/setup.sql`

- [ ] 💻 Show students how to manually add rows.

```sql
INSERT INTO cats (name, age)
VALUES 
    ('Zelda', 3),
    ('Tigerlily', 9),
    ('Sam', 10),
    ('Albus', 9),
    (null, 1);
```

- [ ] 💻 Show students how to read data.

```sql
SELECT * FROM cats;

SELECT name FROM cats;

SELECT name FROM cats WHERE age > 7;

SELECT * FROM cats WHERE name = 'Zelda';

SELECT * FROM cats WHERE name IS NOT NULL;

SELECT DISTINCT age FROM cats ORDER BY age DESC;

SELECT max(age) FROM cats;

SELECT name FROM cats WHERE age = (SELECT max(age) FROM cats);

SELECT * FROM cats WHERE (age > 5) AND (name LIKE 'T%');
```

- [ ] 💻 Show students how to update data.

```sql
UPDATE cats SET age = 4 WHERE name = 'Zelda';
```

- [ ] 💻 Show students how to delete data.

```sql
DELETE FROM cats WHERE name = `Zelda`;

DELETE FROM cats;
```

- [ ] 💻 Show students how to use aggregation functions.

```sql
SELECT COUNT(name) FROM cats;

SELECT COUNT(DISTINCT age) FROM cats;

SELECT SUM(age) FROM cats;

SELECT AVG(age) FROM cats;

SELECT MAX(age) FROM cats;

SELECT MIN(age) FROM cats;
```

- [ ] 💻 Show students how to add data from csv files.

```sql
-- setup.sql

DROP TABLE IF EXISTS cats;
CREATE TABLE cats (
    id SERIAL PRIMARY KEY,
    name VARCHAR ( 20 ),
    age INT,
    breed_id INT
);
COPY cats
FROM $str$/code/data/cats.csv$str$
DELIMITER ',' CSV HEADER;


DROP TABLE IF EXISTS breeds;
CREATE TABLE breeds (
    id SERIAL PRIMARY KEY,
    name VARCHAR ( 20 )
);
COPY breeds
FROM $str$/code/data/breeds.csv$str$
DELIMITER ',' CSV HEADER;


DROP TABLE IF EXISTS owners;
CREATE TABLE owners (
    id serial PRIMARY KEY,
    name VARCHAR ( 50 ) NOT NULL,
    location VARCHAR ( 20 )
);
COPY owners
FROM $str$/code/data/owners.csv$str$
DELIMITER ',' CSV HEADER;
```

- [ ] 💻 Discuss the [PostgreSQL documentation](https://www.postgresql.org/docs/9.2/sql-copy.html)

- [ ] 💻 Show students how to group results together.

```sql
SELECT COUNT(id), location 
FROM owners
GROUP BY location;
```

- [ ] 💻 Show students how to perform joins.

```sql
SELECT cats.name, breeds.name
FROM cats
INNER JOIN breeds
ON cats.breed_id = breeds.id;

SELECT cats.name, breeds.name
FROM cats
LEFT JOIN breeds
ON cats.breed_id = breeds.id;

SELECT cats.name, breeds.name
FROM cats
RIGHT JOIN breeds
ON cats.breed_id = breeds.id;

SELECT cats.name, breeds.name
FROM cats
FULL JOIN breeds
ON cats.breed_id = breeds.id;
```

- [ ] 💻 Show students how we can create tables which join other tables together.

```sql
CREATE TABLE adoptions (
	id serial PRIMARY KEY,
    cat_id INT REFERENCES cats (id) NOT NULL,
    owner_id INT REFERENCES owners (id) NOT NULL,
    adoption_date TIMESTAMP DEFAULT NOW()
);

INSERT INTO adoptions (cat_id, owner_id) VALUES (1, 1), (3, 2);

SELECT owners.name AS owner, cats.name AS cat
FROM ((adoptions
INNER JOIN owners ON adoptions.owner_id = owners.id)
INNER JOIN cats ON adoptions.cat_id = cats.id);
```

- 💻 [ ] Show students if we now want to delete cats or owners we must use `CASCADE`.

```sql
DROP TABLE cats CASCADE
```

## Questions (5 mins)
