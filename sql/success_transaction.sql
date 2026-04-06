DO $$
DECLARE
    err_msg TEXT;
BEGIN
    BEGIN
        INSERT INTO Players (playerID, name) VALUES (9999, 'Parth Sahastrabuddhe');

        -- Log SUCCESS
        INSERT INTO TransactionEvents (event_type, event_description)
        VALUES ('SUCCESS', 'INSERT INTO Players (playerID, name) VALUES (9999, ''Parth Sahastrabuddhe'')');

    EXCEPTION
        WHEN OTHERS THEN
            -- If failure (unlikely here), catch error
            err_msg := SQLERRM;

            -- Log ERROR
            INSERT INTO TransactionEvents (event_type, event_description)
            VALUES ('ERROR', 'INSERT INTO Players (playerID, name) VALUES (9999, ''Parth Sahastrabuddhe'')' || err_msg);
    END;
END $$;









select * from TransactionEvents order by event_time desc;
select * from TransactionLog order by logged_time desc;