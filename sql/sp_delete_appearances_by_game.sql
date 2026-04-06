CREATE OR REPLACE PROCEDURE delete_appearances_by_game(
    IN gid INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    deleted_count INT;
BEGIN
    DELETE FROM Appearances
    WHERE gameID = gid;

    GET DIAGNOSTICS deleted_count = ROW_COUNT;
    RAISE NOTICE 'Deleted % rows from Appearances for gameID %', deleted_count, gid;
EXCEPTION WHEN OTHERS THEN
    RAISE EXCEPTION 'Failed to delete: %', SQLERRM;
END;
$$;


CALL delete_appearances_by_game(101);
