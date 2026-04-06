CREATE OR REPLACE PROCEDURE swap_managers(
    IN team1 INT,
    IN team2 INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    manager1_id INT;
    manager2_id INT;
BEGIN
    -- Fetch current managers
    SELECT managerID INTO manager1_id FROM Managers WHERE teamID = team1;
    SELECT managerID INTO manager2_id FROM Managers WHERE teamID = team2;

    IF manager1_id IS NULL OR manager2_id IS NULL THEN
        RAISE EXCEPTION 'One or both teams do not have managers!';
    END IF;

    -- Swap managers
    UPDATE Managers SET teamID = team2 WHERE managerID = manager1_id;
    UPDATE Managers SET teamID = team1 WHERE managerID = manager2_id;

    RAISE NOTICE 'Swapped managers between teams % and %', team1, team2;
END;
$$;




CALL swap_managers(80, 88);
