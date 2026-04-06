-- Bulk load from CSV files.
-- Run psql from the repository root so these paths resolve, e.g.:
--   psql -U postgres -d your_db -f sql/load.sql

\COPY Leagues FROM 'data/leagues.csv' DELIMITER ',' CSV HEADER;
\COPY Teams FROM 'data/teams.csv' DELIMITER ',' CSV HEADER;
\COPY Managers FROM 'data/final_managers.csv' DELIMITER ',' CSV HEADER;
\COPY Players FROM 'data/players.csv' DELIMITER ',' CSV HEADER;
\COPY Games FROM 'data/games.csv' DELIMITER ',' CSV HEADER;
\COPY PlayerPosition FROM 'data/final_playerposition_clean.csv' DELIMITER ',' CSV HEADER;
\COPY Appearances FROM 'data/final_appearances.csv' DELIMITER ',' CSV HEADER;
\COPY TeamLocations FROM 'data/final_teamlocations.csv' DELIMITER ',' CSV HEADER;
\COPY TeamStats FROM 'data/final_teamstats_clean.csv' DELIMITER ',' CSV HEADER;
\COPY Shots FROM 'data/shots_final_no_duplicates.csv' DELIMITER ',' CSV HEADER NULL '';
