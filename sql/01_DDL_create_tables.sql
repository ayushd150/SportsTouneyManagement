-- ============================================================
-- Sports Tournament Management System
-- FILE 1: DDL - CREATE TABLES
-- Author: Ayush D
-- ============================================================

-- Drop tables if they already exist (in correct order to avoid FK errors)
DROP TABLE IF EXISTS match_stats;
DROP TABLE IF EXISTS matches;
DROP TABLE IF EXISTS players;
DROP TABLE IF EXISTS teams;
DROP TABLE IF EXISTS venues;
DROP TABLE IF EXISTS tournaments;

-- ============================================================
-- TABLE 1: tournaments
-- ============================================================
CREATE TABLE tournaments (
    tournament_id   INT PRIMARY KEY AUTO_INCREMENT,
    tournament_name VARCHAR(100) NOT NULL,
    sport_type      VARCHAR(50)  NOT NULL,
    start_date      DATE         NOT NULL,
    end_date        DATE         NOT NULL,
    location        VARCHAR(100),
    prize_pool      DECIMAL(12,2) DEFAULT 0.00,
    status          ENUM('Upcoming','Ongoing','Completed') DEFAULT 'Upcoming',
    CONSTRAINT chk_dates CHECK (end_date >= start_date)
);

-- ============================================================
-- TABLE 2: venues
-- ============================================================
CREATE TABLE venues (
    venue_id        INT PRIMARY KEY AUTO_INCREMENT,
    venue_name      VARCHAR(100) NOT NULL,
    city            VARCHAR(60)  NOT NULL,
    country         VARCHAR(60)  NOT NULL DEFAULT 'India',
    capacity        INT,
    CONSTRAINT chk_capacity CHECK (capacity > 0)
);

-- ============================================================
-- TABLE 3: teams
-- ============================================================
CREATE TABLE teams (
    team_id         INT PRIMARY KEY AUTO_INCREMENT,
    team_name       VARCHAR(100) NOT NULL,
    coach_name      VARCHAR(100),
    home_city       VARCHAR(60),
    tournament_id   INT NOT NULL,
    wins            INT DEFAULT 0,
    losses          INT DEFAULT 0,
    draws           INT DEFAULT 0,
    CONSTRAINT fk_team_tournament FOREIGN KEY (tournament_id)
        REFERENCES tournaments(tournament_id)
        ON DELETE CASCADE
);

-- ============================================================
-- TABLE 4: players
-- ============================================================
CREATE TABLE players (
    player_id       INT PRIMARY KEY AUTO_INCREMENT,
    first_name      VARCHAR(60)  NOT NULL,
    last_name       VARCHAR(60)  NOT NULL,
    position        VARCHAR(50),
    jersey_number   INT,
    date_of_birth   DATE,
    nationality     VARCHAR(60)  DEFAULT 'Indian',
    team_id         INT NOT NULL,
    goals_scored    INT DEFAULT 0,
    is_active       BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_player_team FOREIGN KEY (team_id)
        REFERENCES teams(team_id)
        ON DELETE CASCADE,
    CONSTRAINT chk_jersey CHECK (jersey_number > 0 AND jersey_number <= 99)
);

-- ============================================================
-- TABLE 5: matches
-- ============================================================
CREATE TABLE matches (
    match_id        INT PRIMARY KEY AUTO_INCREMENT,
    tournament_id   INT NOT NULL,
    venue_id        INT NOT NULL,
    team1_id        INT NOT NULL,
    team2_id        INT NOT NULL,
    match_date      DATETIME     NOT NULL,
    team1_score     INT DEFAULT 0,
    team2_score     INT DEFAULT 0,
    match_status    ENUM('Scheduled','Live','Completed','Cancelled') DEFAULT 'Scheduled',
    match_round     VARCHAR(30),
    CONSTRAINT fk_match_tournament FOREIGN KEY (tournament_id)
        REFERENCES tournaments(tournament_id),
    CONSTRAINT fk_match_venue FOREIGN KEY (venue_id)
        REFERENCES venues(venue_id),
    CONSTRAINT fk_match_team1 FOREIGN KEY (team1_id)
        REFERENCES teams(team_id),
    CONSTRAINT fk_match_team2 FOREIGN KEY (team2_id)
        REFERENCES teams(team_id),
    CONSTRAINT chk_diff_teams CHECK (team1_id <> team2_id)
);

-- ============================================================
-- TABLE 6: match_stats (player performance per match)
-- ============================================================
CREATE TABLE match_stats (
    stat_id         INT PRIMARY KEY AUTO_INCREMENT,
    match_id        INT NOT NULL,
    player_id       INT NOT NULL,
    goals           INT DEFAULT 0,
    assists         INT DEFAULT 0,
    yellow_cards    INT DEFAULT 0,
    red_cards       INT DEFAULT 0,
    minutes_played  INT DEFAULT 0,
    CONSTRAINT fk_stat_match FOREIGN KEY (match_id)
        REFERENCES matches(match_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_stat_player FOREIGN KEY (player_id)
        REFERENCES players(player_id)
        ON DELETE CASCADE
);

-- ============================================================
-- ALTER TABLE examples 
-- ============================================================
ALTER TABLE tournaments ADD COLUMN organizer VARCHAR(100) DEFAULT 'Sports Board of India';
ALTER TABLE players ADD COLUMN email VARCHAR(100);
ALTER TABLE venues ADD COLUMN surface_type VARCHAR(30) DEFAULT 'Grass';
