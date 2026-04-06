--1) All matches where home team scored more than 3 goals
SELECT gameID, homeTeamID, homeGoals
FROM Games g
join Teams t on t.teamid = g.homeTeamID
WHERE homeGoals > 3;

--2) Select top 5 players by goals scored
SELECT p.name, SUM(a.goals) AS total_goals
FROM Players p
JOIN Appearances a ON p.playerID = a.playerID
GROUP BY p.name
ORDER BY total_goals DESC
LIMIT 5;

--3) Managers who manage teams in a specific league
SELECT m.name AS manager_name, t.name AS team_name, l.name AS league_name
FROM Managers m
JOIN Teams t ON m.teamID = t.teamID
JOIN Games g ON t.teamID = g.homeTeamID
JOIN Leagues l ON g.leagueID = l.leagueID
GROUP BY m.name, t.name, l.name;

--4) Teams who had more than 50 yellow cards in all games
SELECT t.name AS team_name, SUM(yellowCards) AS total_yellow_cards
FROM TeamStats ts
join Teams t ON t.teamID = ts.teamID
GROUP BY t.name
HAVING SUM(yellowCards) > 50
order by total_yellow_cards desc;

--5) Players who have average goal scored more than overall average.
SELECT p.name, ROUND(player_avg.player_goal_avg, 2) AS player_goal_avg
FROM Players p
JOIN (
    SELECT playerID, AVG(goals) AS player_goal_avg
    FROM Appearances
    GROUP BY playerID
    HAVING AVG(goals) > (SELECT AVG(goals) FROM Appearances)
) AS player_avg
ON p.playerID = player_avg.playerID
ORDER BY player_goal_avg DESC;
















