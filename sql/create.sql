
-- DROP TABLES IF THEY EXIST
DROP TABLE IF EXISTS Shots, Appearances, PlayerPosition, TeamStats, TeamLocations, Managers,
             Games, Players, Teams, Leagues, TransactionLog, TransactionEvents CASCADE;

-- Leagues
CREATE TABLE Leagues (
    leagueID INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    notation VARCHAR(10) UNIQUE NOT NULL
);

-- Teams
CREATE TABLE Teams (
    teamID INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Managers
CREATE TABLE Managers (
    managerID INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    teamID INT NOT NULL,
    FOREIGN KEY (teamID) REFERENCES Teams(teamID) ON DELETE CASCADE
);

-- Players
CREATE TABLE Players (
    playerID INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Games
CREATE TABLE Games (
    gameID INT PRIMARY KEY,
    leagueID INT NOT NULL,
    season VARCHAR(20) NOT NULL,
    date TIMESTAMP NOT NULL,
    homeTeamID INT NOT NULL,
    awayTeamID INT NOT NULL,
    homeGoals INT DEFAULT 0,
    awayGoals INT DEFAULT 0,
    homeProbability FLOAT DEFAULT NULL,
    drawProbability FLOAT DEFAULT NULL,
    awayProbability FLOAT DEFAULT NULL,
    homeGoalsHalfTime INT DEFAULT 0,
    awayGoalsHalfTime INT DEFAULT 0,
    FOREIGN KEY (leagueID) REFERENCES Leagues(leagueID) ON DELETE CASCADE,
    FOREIGN KEY (homeTeamID) REFERENCES Teams(teamID) ON DELETE CASCADE,
    FOREIGN KEY (awayTeamID) REFERENCES Teams(teamID) ON DELETE CASCADE
);

-- PlayerPosition
CREATE TABLE PlayerPosition (
    playerID INT PRIMARY KEY,
    position VARCHAR(50),
    positionOrder INT,
    FOREIGN KEY (playerID) REFERENCES Players(playerID) ON DELETE CASCADE
);

-- Appearances
CREATE TABLE Appearances (
    gameID INT NOT NULL,
    playerID INT NOT NULL,
    goals INT DEFAULT 0,
    ownGoals INT DEFAULT 0,
    shots INT DEFAULT 0,
    assists INT DEFAULT 0,
    keyPasses INT DEFAULT 0,
    yellowCard INT DEFAULT 0,
    redCard INT DEFAULT 0,
    time INT DEFAULT NULL,
    substituteIn INT DEFAULT NULL,
    substituteOut INT DEFAULT NULL,
    PRIMARY KEY (gameID, playerID),
    FOREIGN KEY (gameID) REFERENCES Games(gameID) ON DELETE CASCADE,
    FOREIGN KEY (playerID) REFERENCES Players(playerID) ON DELETE CASCADE
);

-- TeamLocations
CREATE TABLE TeamLocations (
    gameID INT NOT NULL,
    location VARCHAR(255) NOT NULL,
    teamID INT NOT NULL,
    PRIMARY KEY (gameID, location),
    FOREIGN KEY (gameID) REFERENCES Games(gameID) ON DELETE CASCADE,
    FOREIGN KEY (teamID) REFERENCES Teams(teamID) ON DELETE CASCADE
);

-- TeamStats
CREATE TABLE TeamStats (
    gameID INT NOT NULL,
    teamID INT NOT NULL,
    goals INT DEFAULT 0,
    shots INT DEFAULT 0,
    shotsOnTarget INT DEFAULT 0,
    fouls INT DEFAULT 0,
    corners INT DEFAULT 0,
    yellowCards INT DEFAULT 0,
    redCards INT DEFAULT 0,
    result VARCHAR(10) NOT NULL,
    PRIMARY KEY (gameID, teamID),
    FOREIGN KEY (gameID) REFERENCES Games(gameID) ON DELETE CASCADE,
    FOREIGN KEY (teamID) REFERENCES Teams(teamID) ON DELETE CASCADE
);

-- Shots
CREATE TABLE Shots (
    gameID INT NOT NULL,
    minute INT NOT NULL,
    shooterID INT NOT NULL,
    positionX FLOAT NOT NULL,
    positionY FLOAT NOT NULL,
    assisterID INT DEFAULT NULL,
    situation VARCHAR(50) NOT NULL,
    lastAction VARCHAR(50) NOT NULL,
    shotType VARCHAR(50) NOT NULL,
    shotResult VARCHAR(50) NOT NULL,
    xGoal FLOAT NOT NULL,
    PRIMARY KEY (gameID, minute, shooterID, positionX, positionY),
    FOREIGN KEY (gameID) REFERENCES Games(gameID) ON DELETE CASCADE,
    FOREIGN KEY (shooterID) REFERENCES Players(playerID) ON DELETE CASCADE,
    FOREIGN KEY (assisterID) REFERENCES Players(playerID) ON DELETE SET NULL
);

-- Transaction logging (used by trigger.sql and transaction demo scripts)
CREATE TABLE TransactionEvents (
    event_id SERIAL PRIMARY KEY,
    event_type VARCHAR(20) NOT NULL,
    event_description TEXT,
    event_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE TransactionLog (
    log_id SERIAL PRIMARY KEY,
    error_message TEXT,
    logged_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
