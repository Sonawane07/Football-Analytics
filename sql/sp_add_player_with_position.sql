CREATE OR REPLACE PROCEDURE add_player_with_position(
    IN pid INT,
    IN pname VARCHAR,
    IN pos VARCHAR,
    IN pos_order INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Check if player exists
    IF NOT EXISTS (SELECT 1 FROM Players WHERE playerID = pid) THEN
        INSERT INTO Players (playerID, name) VALUES (pid, pname);
    END IF;

    -- Always update PlayerPosition
    INSERT INTO PlayerPosition (playerID, position, positionOrder)
    VALUES (pid, pos, pos_order)
    ON CONFLICT (playerID) DO UPDATE
    SET position = EXCLUDED.position, positionOrder = EXCLUDED.positionOrder;
END;
$$;


CALL add_player_with_position(20000, 'Luis Silva', 'Midfielder', 2);