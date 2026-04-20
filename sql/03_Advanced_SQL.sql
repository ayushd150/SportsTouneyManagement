-- ============================================================
-- Sports Tournament Management System
-- FILE 3: ADVANCED SQL - Views, Indexes, Stored Procedures, Triggers
-- Author: Ayush D
-- ============================================================

-- ============================================================
-- VIEWS
-- ============================================================

-- View 1: Tournament Standings (wins/losses/draws/points)
CREATE OR REPLACE VIEW vw_tournament_standings AS
SELECT
    t.tournament_id,
    tn.tournament_name,
    t.team_name,
    t.wins,
    t.losses,
    t.draws,
    (t.wins * 3 + t.draws * 1) AS points
FROM teams t
JOIN tournaments tn ON t.tournament_id = tn.tournament_id
ORDER BY tn.tournament_id, points DESC;

-- View 2: Top Goal Scorers across all tournaments
CREATE OR REPLACE VIEW vw_top_scorers AS
SELECT
    p.player_id,
    CONCAT(p.first_name, ' ', p.last_name) AS player_name,
    p.position,
    tm.team_name,
    tn.tournament_name,
    p.goals_scored
FROM players p
JOIN teams tm ON p.team_id = tm.team_id
JOIN tournaments tn ON tm.tournament_id = tn.tournament_id
ORDER BY p.goals_scored DESC;

-- View 3: Full Match Schedule with team and venue names
CREATE OR REPLACE VIEW vw_match_schedule AS
SELECT
    m.match_id,
    tn.tournament_name,
    v.venue_name,
    v.city AS venue_city,
    t1.team_name AS home_team,
    t2.team_name AS away_team,
    m.match_date,
    m.team1_score,
    m.team2_score,
    m.match_status,
    m.match_round
FROM matches m
JOIN tournaments tn ON m.tournament_id = tn.tournament_id
JOIN venues v       ON m.venue_id = v.venue_id
JOIN teams t1       ON m.team1_id = t1.team_id
JOIN teams t2       ON m.team2_id = t2.team_id;

-- View 4: Player match performance summary
CREATE OR REPLACE VIEW vw_player_performance AS
SELECT
    p.player_id,
    CONCAT(p.first_name, ' ', p.last_name) AS player_name,
    tm.team_name,
    COUNT(ms.stat_id)       AS matches_played,
    SUM(ms.goals)           AS total_goals,
    SUM(ms.assists)         AS total_assists,
    SUM(ms.yellow_cards)    AS yellow_cards,
    SUM(ms.minutes_played)  AS total_minutes
FROM players p
JOIN teams tm       ON p.team_id = tm.team_id
LEFT JOIN match_stats ms ON p.player_id = ms.player_id
GROUP BY p.player_id, player_name, tm.team_name;

-- ============================================================
-- INDEXES  (for query performance)
-- ============================================================
CREATE INDEX idx_teams_tournament    ON teams(tournament_id);
CREATE INDEX idx_players_team        ON players(team_id);
CREATE INDEX idx_matches_tournament  ON matches(tournament_id);
CREATE INDEX idx_matches_date        ON matches(match_date);
CREATE INDEX idx_match_stats_player  ON match_stats(player_id);
CREATE INDEX idx_match_stats_match   ON match_stats(match_id);

-- ============================================================
-- STORED PROCEDURES
-- ============================================================

DELIMITER $$

-- Procedure 1: Get all matches of a tournament
CREATE PROCEDURE sp_get_tournament_matches(IN p_tournament_id INT)
BEGIN
    SELECT
        m.match_id,
        t1.team_name AS home_team,
        t2.team_name AS away_team,
        v.venue_name,
        m.match_date,
        m.team1_score,
        m.team2_score,
        m.match_status,
        m.match_round
    FROM matches m
    JOIN teams t1  ON m.team1_id = t1.team_id
    JOIN teams t2  ON m.team2_id = t2.team_id
    JOIN venues v  ON m.venue_id = v.venue_id
    WHERE m.tournament_id = p_tournament_id
    ORDER BY m.match_date;
END$$

-- Procedure 2: Record match result and update team stats
CREATE PROCEDURE sp_record_match_result(
    IN p_match_id     INT,
    IN p_team1_score  INT,
    IN p_team2_score  INT
)
BEGIN
    DECLARE v_team1_id INT;
    DECLARE v_team2_id INT;

    -- Get team IDs
    SELECT team1_id, team2_id INTO v_team1_id, v_team2_id
    FROM matches WHERE match_id = p_match_id;

    -- Update match score
    UPDATE matches
    SET team1_score = p_team1_score,
        team2_score = p_team2_score,
        match_status = 'Completed'
    WHERE match_id = p_match_id;

    -- Update team standings
    IF p_team1_score > p_team2_score THEN
        UPDATE teams SET wins   = wins   + 1 WHERE team_id = v_team1_id;
        UPDATE teams SET losses = losses + 1 WHERE team_id = v_team2_id;
    ELSEIF p_team2_score > p_team1_score THEN
        UPDATE teams SET wins   = wins   + 1 WHERE team_id = v_team2_id;
        UPDATE teams SET losses = losses + 1 WHERE team_id = v_team1_id;
    ELSE
        UPDATE teams SET draws = draws + 1 WHERE team_id = v_team1_id;
        UPDATE teams SET draws = draws + 1 WHERE team_id = v_team2_id;
    END IF;

    SELECT 'Match result recorded successfully.' AS message;
END$$

-- Procedure 3: Get top N scorers of a tournament
CREATE PROCEDURE sp_top_scorers(IN p_tournament_id INT, IN p_limit INT)
BEGIN
    SELECT
        CONCAT(p.first_name, ' ', p.last_name) AS player_name,
        t.team_name,
        p.goals_scored
    FROM players p
    JOIN teams t ON p.team_id = t.team_id
    WHERE t.tournament_id = p_tournament_id
    ORDER BY p.goals_scored DESC
    LIMIT p_limit;
END$$

-- Function: Calculate total points of a team
CREATE FUNCTION fn_team_points(p_team_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_wins  INT DEFAULT 0;
    DECLARE v_draws INT DEFAULT 0;
    SELECT wins, draws INTO v_wins, v_draws
    FROM teams WHERE team_id = p_team_id;
    RETURN (v_wins * 3 + v_draws * 1);
END$$

DELIMITER ;

-- ============================================================
-- TRIGGERS 
-- ============================================================

DELIMITER $$

-- Trigger 1: Auto-update player goals_scored when match_stats inserted
CREATE TRIGGER trg_update_player_goals
AFTER INSERT ON match_stats
FOR EACH ROW
BEGIN
    UPDATE players
    SET goals_scored = goals_scored + NEW.goals
    WHERE player_id = NEW.player_id;
END$$

-- Trigger 2: Prevent scheduling a match on an already-used venue/date
CREATE TRIGGER trg_prevent_duplicate_match
BEFORE INSERT ON matches
FOR EACH ROW
BEGIN
    DECLARE match_count INT;
    SELECT COUNT(*) INTO match_count
    FROM matches
    WHERE venue_id = NEW.venue_id
      AND DATE(match_date) = DATE(NEW.match_date)
      AND match_status != 'Cancelled';
    IF match_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Venue is already booked for this date.';
    END IF;
END$$

DELIMITER ;
