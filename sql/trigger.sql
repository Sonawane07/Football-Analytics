CREATE OR REPLACE FUNCTION trigger_log_on_error()
RETURNS TRIGGER AS $$
BEGIN
	-- Only if event type is 'ERROR', log it
    IF NEW.event_type = 'ERROR' THEN
        INSERT INTO TransactionLog(error_message)
        VALUES (NEW.event_description);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS after_event_insert ON TransactionEvents;

CREATE TRIGGER after_event_insert
AFTER INSERT ON TransactionEvents
FOR EACH ROW
EXECUTE PROCEDURE trigger_log_on_error();
