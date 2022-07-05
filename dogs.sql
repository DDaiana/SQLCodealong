DROP TABLE IF EXISTS dogs;
CREATE TABLE dogs (
    id SERIAL PRIMARY KEY,
    name VARCHAR ( 20 ),
    age INT,
    breed_id INT
);
COPY dogs
FROM $str$/code/data/dogs.csv$str$ -- /code is used by the docker so it's needed
DELIMITER ',' CSV HEADER;
