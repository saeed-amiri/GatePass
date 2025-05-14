/*
Get the nth prime number in a geeky way
*/

DROP FUNCTION IF EXISTS nth_prime(INT);

CREATE FUNCTION nth_prime(n INT)
RETURNS TABLE(candidate INT, count INT) AS $$
DECLARE
    i_count INT := 0;
    i_candidate INT := 1;
    is_prime BOOLEAN;
    i INT;
BEGIN
    IF n < 1 THEN
        RAISE EXCEPTION 'Input must be >= 1';
    END IF;

    WHILE i_count < n LOOP
        i_candidate := i_candidate + 1;
        is_prime := TRUE;
    
        FOR i IN 2..floor(sqrt(i_candidate))::INT LOOP
            IF i_candidate % i = 0 THEN
                is_prime := FALSE;
                EXIT;
            END IF;
        END LOOP;
    
        IF is_prime THEN
            i_count := i_count + 1;
        END IF;
    END LOOP;

    count := i_count;
    candidate := i_candidate;

    RETURN NEXT;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM nth_prime(150);

-- Analyzing the proformance

EXPLAIN ANALYZE SELECT nth_prime(150);
