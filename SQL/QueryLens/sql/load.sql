-- Load the files
COPY movies FROM '/home/santiago/Documents/MyScripts/GatePass/SQL/QueryLens/data/movies.csv' DELIMITER ',' CSV HEADER;
COPY ratings FROM '/home/santiago/Documents/MyScripts/GatePass/SQL/QueryLens/data/ratings.csv' DELIMITER ',' CSV HEADER;
COPY links FROM '/home/santiago/Documents/MyScripts/GatePass/SQL/QueryLens/data/links.csv' DELIMITER ',' CSV HEADER;
COPY tags FROM '/home/santiago/Documents/MyScripts/GatePass/SQL/QueryLens/data/tags.csv' DELIMITER ',' CSV HEADER;



