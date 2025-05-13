/*
Test user defined functions and usages in SQL
e.g.
CREATE FUNCTION function_name (param1 type, param2 type)
RETURNS return_type AS $$
BEGIN
    -- Function logic here
    RETURN result;
END;
$$ LANGUAGE plpgsql;

*/
DROP FUNCTION IF EXISTS add_numbers(a INT, b INT);
DROP FUNCTION IF EXISTS avg_numbers(a DOUBLE PRECISION, b DOUBLE PRECISION);
DROP FUNCTION IF EXISTS divide_checker(a DOUBLE PRECISION, b DOUBLE PRECISION);
DROP FUNCTION IF EXISTS divide_checker1(a DOUBLE PRECISION, b DOUBLE PRECISION);
DROP FUNCTION IF EXISTS divide_checker2(a DOUBLE PRECISION, b DOUBLE PRECISION);


-- Example of a function that returns the sum of two numbers
CREATE FUNCTION add_numbers(a INT, b INT)
RETURNS INT AS $$
BEGIN
    RETURN a + b;
END;
$$ LANGUAGE plpgsql;


SELECT add_numbers(5, 10); -- This will return 15

-- Exmaple of a function that returns the average two numbers
CREATE FUNCTION avg_numbers(a DOUBLE PRECISION, b DOUBLE PRECISION)
RETURNS DOUBLE PRECISION AS $$
BEGIN
    RETURN (a + b) / 2.0;
END;
$$ LANGUAGE plpgsql;

SELECT avg_numbers(5.0, -10.0); -- Will return -2.5

-- Example of dividing by eachother with check for 0
CREATE FUNCTION divide_checker(a DOUBLE PRECISION, b DOUBLE PRECISION)
RETURNS DOUBLE PRECISION AS $$
BEGIN
    IF b = 0 THEN
        RAISE EXCEPTION 'Division by zero: cannot divide % by %', a, b
            USING ERRCODE = '22012';
    END IF;

    RETURN a / b;
END;
$$ LANGUAGE plpgsql;

SELECT divide_checker(5, 2.0);
SELECT divide_checker(5, 0.0);
SELECT divide_checker(0, 2.0);

-- Second version of the divider: retuen as text
CREATE FUNCTION divide_checker1(a DOUBLE PRECISION, b DOUBLE PRECISION)
RETURNS TEXT AS $$
BEGIN
    IF b = 0 THEN
        RETURN 'Error: Division by zero!';
    ELSE
        RETURN (a / b)::TEXT;
    END IF;
END;
$$ LANGUAGE plpgsql;

SELECT divide_checker1(5, 2.0);
SELECT divide_checker1(5, 0.0);
SELECT divide_checker1(0, 2.0);

-- Third verson of divider, return both result and status
CREATE FUNCTION divide_checker2(a DOUBLE PRECISION, b DOUBLE PRECISION)
RETURNS TABLE(result DOUBLE PRECISION, messages TEXT) AS $$
BEGIN
    IF b = 0 THEN
        result := NULL;
        messages := 'Error: Division by zero';
    ELSE
        result := a / b;
        messages := 'Success';
    END IF;

    RETURN NEXT;
END;
$$ LANGUAGE plpgsql;

SELECT result FROM divide_checker2(10, 2);
SELECT * FROM divide_checker2(10, 0);
