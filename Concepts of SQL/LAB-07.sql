-- Create a simple table for practicing PL/pgSQL blocks

CREATE TABLE film (
    film_id SERIAL PRIMARY KEY,
    title VARCHAR(100),
    release_year INTEGER,
    rental_rate NUMERIC(5,2),
    length INTEGER,
    category VARCHAR(50)
);

-- Insert sample data

INSERT INTO film (title, release_year, rental_rate, length, category)
VALUES
('Inception', 2010, 4.99, 148, 'Sci-Fi'),
('Titanic', 1997, 3.99, 195, 'Romance'),
('The Dark Knight', 2008, 5.99, 152, 'Action'),
('Interstellar', 2014, 6.50, 169, 'Sci-Fi'),
('Avengers: Endgame', 2019, 7.99, 181, 'Action'),
('Frozen', 2013, 2.99, 102, 'Animation'),
('Joker', 2019, 5.49, 122, 'Drama'),
('The Lion King', 1994, 3.50, 88, 'Animation'),
('Parasite', 2019, 4.75, 132, 'Thriller'),
('Gladiator', 2000, 4.25, 155, 'Historical');

DO $$
<<FILMS>>
DECLARE 
FILM_COUNT INTEGER := 0;
BEGIN 
	SELECT COUNT(*) INTO FILM_COUNT FROM FILM;
	RAISE NOTICE 'THE NUMBER OF FILMS ARE %', FILM_COUNT;
	-- CONDITIONAL STATEMENTS:
	IF FILM_COUNT>10 THEN
		RAISE NOTICE 'COUNT GREATER THAN 10';
	ELSIF FILM_COUNT<10 THEN
		RAISE NOTICE 'COUNT LESS THAN 10';
	ELSE 
		RAISE NOTICE 'COUNT EQUAL TO 10';
	END IF;

	-- CASE STATEMENTS:
	CASE FILM_COUNT 
		WHEN 10 THEN 
			RAISE NOTICE 'EQUAL TO 10';
		WHEN 11 THEN 
			RAISE NOTICE 'EQUAL TO 11';
		ELSE 
			RAISE NOTICE 'EMPTY DB!';
	END CASE;
	
END FILMS $$;


-- WHILE LOOP:
DO $$ 
<<WHILELOOP>>
DECLARE 
COUNTER INTEGER := 0;
BEGIN
	WHILE COUNTER<=5 LOOP
		RAISE NOTICE 'COUNTER = %', COUNTER;
		COUNTER:=COUNTER+1;
	END LOOP;
END WHILELOOP $$;



	

