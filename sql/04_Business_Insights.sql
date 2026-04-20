-- ============================================================
-- Sports Tournament Management System
-- FILE 4: BUSINESS INSIGHTS & ANALYTICAL QUERIES
-- Author: Ayush D
-- ============================================================

-- ============================================================
-- QUERY 1: Tournament Standings / Points Table
-- Business Insight: Shows current ranking of all teams in a
-- tournament based on wins, draws, losses and points (W=3, D=1).
-- ============================================================
SELECT
    ROW_NUMBER() OVER (PARTITION BY tournament_id ORDER BY points DESC) AS `rank`,
    tournament_name,
    team_name,
    wins,
    draws,
    losses,
    (wins + draws + losses) AS matches_played,
    points
FROM vw_tournament_standings
WHERE tournament_id = 1;

-- ============================================================
-- QUERY 2: Top Goal Scorers (Top 5)
-- Business Insight: Identifies the most valuable attacking
-- players in the tournament — useful for MVP awards.
-- ============================================================
SELECT
    player_name,
    team_name,
    tournament_name,
    goals_scored
FROM vw_top_scorers
LIMIT 5;

-- ============================================================
-- QUERY 3: Head-to-Head Record Between Two Teams
-- Business Insight: Compares performance between two rival
-- teams across all their meetings.
-- ============================================================
SELECT
    home_team,
    away_team,
    match_round,
    match_date,
    CONCAT(team1_score, ' - ', team2_score) AS score,
    CASE
        WHEN team1_score > team2_score THEN home_team
        WHEN team2_score > team1_score THEN away_team
        ELSE 'Draw'
    END AS winner
FROM vw_match_schedule
WHERE (home_team = 'Mumbai Strikers' AND away_team = 'Delhi Dynamos')
   OR (home_team = 'Delhi Dynamos'   AND away_team = 'Mumbai Strikers');

-- ============================================================
-- QUERY 4: Venue Utilization Report
-- Business Insight: Shows how many matches each venue has
-- hosted — helps identify overused or underused venues.
-- ============================================================
SELECT
    v.venue_name,
    v.city,
    v.capacity,
    COUNT(m.match_id)  AS total_matches_hosted,
    SUM(CASE WHEN m.match_status = 'Completed' THEN 1 ELSE 0 END) AS completed,
    SUM(CASE WHEN m.match_status = 'Scheduled' THEN 1 ELSE 0 END) AS upcoming
FROM venues v
LEFT JOIN matches m ON v.venue_id = m.venue_id
GROUP BY v.venue_id, v.venue_name, v.city, v.capacity
ORDER BY total_matches_hosted DESC;

-- ============================================================
-- QUERY 5: Player Discipline Report (Cards Analysis)
-- Business Insight: Helps tournament officials track players
-- at risk of suspension due to yellow/red card accumulation.
-- ============================================================
SELECT
    CONCAT(p.first_name, ' ', p.last_name) AS player_name,
    t.team_name,
    SUM(ms.yellow_cards) AS total_yellow_cards,
    SUM(ms.red_cards)    AS total_red_cards,
    CASE
        WHEN SUM(ms.yellow_cards) >= 3 THEN 'Suspension Risk'
        WHEN SUM(ms.yellow_cards) >= 2 THEN 'Caution'
        ELSE 'Clean'
    END AS discipline_status
FROM players p
JOIN teams t        ON p.team_id = t.team_id
JOIN match_stats ms ON p.player_id = ms.player_id
GROUP BY p.player_id, player_name, t.team_name
HAVING (SUM(ms.yellow_cards) + SUM(ms.red_cards)) > 0
ORDER BY total_yellow_cards DESC, total_red_cards DESC;

-- ============================================================
-- QUERY 6: Monthly Match Count (Trend Analysis)
-- Business Insight: Reveals peak months of tournament activity,
-- helping organizers plan resources and marketing budgets.
-- ============================================================
SELECT
    DATE_FORMAT(match_date, '%Y-%m') AS month,
    COUNT(*)                          AS total_matches,
    SUM(CASE WHEN match_status = 'Completed' THEN 1 ELSE 0 END) AS completed,
    SUM(CASE WHEN match_status = 'Scheduled' THEN 1 ELSE 0 END) AS scheduled,
    SUM(CASE WHEN match_status = 'Live'      THEN 1 ELSE 0 END) AS live
FROM matches
GROUP BY month
ORDER BY month;

-- ============================================================
-- QUERY 7: Teams with Unbeaten Runs
-- Business Insight: Identifies dominant teams for seeding
-- decisions and fan interest / media coverage.
-- ============================================================
SELECT
    t.team_name,
    tn.tournament_name,
    t.wins,
    t.draws,
    t.losses,
    fn_team_points(t.team_id) AS total_points,
    ROUND(t.wins * 100.0 / NULLIF(t.wins + t.draws + t.losses, 0), 1) AS win_percentage
FROM teams t
JOIN tournaments tn ON t.tournament_id = tn.tournament_id
WHERE (t.wins + t.draws + t.losses) > 0
ORDER BY win_percentage DESC, total_points DESC;

-- ============================================================
-- STORED PROCEDURE CALLS (for demonstration)
-- ============================================================

-- Get all matches of tournament 1
CALL sp_get_tournament_matches(1);

-- Record a match result (match 20, score 2-1)
CALL sp_record_match_result(20, 2, 1);

-- Get top 5 scorers of tournament 1
CALL sp_top_scorers(1, 5);

-- Use function to get team points
SELECT fn_team_points(1) AS mumbai_strikers_points;
