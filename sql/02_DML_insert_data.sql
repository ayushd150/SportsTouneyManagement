-- ============================================================
-- Sports Tournament Management System
-- FILE 2: DML - INSERT SAMPLE DATA (20+ records per main table)
-- Author: Ayush D
-- ============================================================

-- ============================================================
-- INSERT: tournaments (5 tournaments)
-- ============================================================
INSERT INTO tournaments (tournament_name, sport_type, start_date, end_date, location, prize_pool, status) VALUES
('Premier Football League 2026',    'Football', '2026-01-10', '2026-03-30', 'Mumbai',    500000.00, 'Completed'),
('National Cricket Championship',   'Cricket',  '2026-02-01', '2026-04-15', 'Delhi',     750000.00, 'Ongoing'),
('State Basketball Cup',            'Basketball','2026-03-05', '2026-04-20', 'Bangalore', 200000.00, 'Ongoing'),
('Inter-City Kabaddi League',       'Kabaddi',  '2026-04-01', '2026-05-31', 'Kolkata',   150000.00, 'Upcoming'),
('All India Volleyball Tournament', 'Volleyball','2026-05-10', '2026-06-30', 'Chennai',   100000.00, 'Upcoming');

-- ============================================================
-- INSERT: venues (5 venues)
-- ============================================================
INSERT INTO venues (venue_name, city, country, capacity, surface_type) VALUES
('Wankhede Stadium',    'Mumbai',    'India', 33000, 'Grass'),
('Eden Gardens',        'Kolkata',   'India', 68000, 'Grass'),
('M. Chinnaswamy',      'Bangalore', 'India', 40000, 'Grass'),
('Jawaharlal Nehru',    'Delhi',     'India', 75000, 'Artificial Turf'),
('YMCA Ground',         'Chennai',   'India', 10000, 'Clay');

-- ============================================================
-- INSERT: teams (20 teams across tournaments)
-- ============================================================
INSERT INTO teams (team_name, coach_name, home_city, tournament_id, wins, losses, draws) VALUES
('Mumbai Strikers',      'Rajesh Kumar',   'Mumbai',    1, 8, 2, 2),
('Delhi Dynamos',        'Suresh Rao',     'Delhi',     1, 7, 3, 2),
('Bangalore Blasters',   'Mohan Singh',    'Bangalore', 1, 6, 4, 2),
('Kolkata Knights',      'Arjun Das',      'Kolkata',   1, 5, 5, 2),
('Chennai Challengers',  'Priya Nair',     'Chennai',   1, 4, 6, 2),
('Hyderabad Hawks',      'Vikram Sharma',  'Hyderabad', 1, 3, 7, 2),
('Pune Panthers',        'Ankit Joshi',    'Pune',      2, 6, 2, 2),
('Jaipur Jaguars',       'Ravi Mehta',     'Jaipur',    2, 5, 3, 2),
('Lucknow Lions',        'Sanjay Yadav',   'Lucknow',   2, 4, 4, 2),
('Ahmedabad Aces',       'Deepak Patel',   'Ahmedabad', 2, 3, 5, 2),
('Bhopal Bulls',         'Kiran Tiwari',   'Bhopal',    3, 7, 1, 2),
('Nagpur Ninjas',        'Sachin More',    'Nagpur',    3, 6, 2, 2),
('Surat Spartans',       'Rohit Shah',     'Surat',     3, 5, 3, 2),
('Vadodara Vipers',      'Amit Desai',     'Vadodara',  3, 4, 4, 2),
('Indore Invaders',      'Neha Gupta',     'Indore',    4, 0, 0, 0),
('Bhubaneswar Bears',    'Sunil Patnaik',  'Bhubaneswar',4,0, 0, 0),
('Guwahati Giants',      'Pranab Bora',    'Guwahati',  4, 0, 0, 0),
('Coimbatore Cobras',    'Mani Pillai',    'Coimbatore',5, 0, 0, 0),
('Kochi Kings',          'Jose Thomas',    'Kochi',     5, 0, 0, 0),
('Thiruvananthapuram Tigers','Arun Menon', 'Trivandrum',5, 0, 0, 0);

-- ============================================================
-- INSERT: players (20+ players)
-- ============================================================
INSERT INTO players (first_name, last_name, position, jersey_number, date_of_birth, nationality, team_id, goals_scored) VALUES
('Aryan',    'Mehta',    'Forward',    9,  '2000-03-15', 'Indian', 1, 12),
('Rohan',    'Sharma',   'Midfielder', 8,  '1999-07-22', 'Indian', 1, 7),
('Kunal',    'Verma',    'Defender',   5,  '2001-01-10', 'Indian', 1, 1),
('Nikhil',   'Joshi',    'Goalkeeper', 1,  '1998-11-05', 'Indian', 1, 0),
('Aditya',   'Singh',    'Forward',    10, '2002-04-18', 'Indian', 2, 10),
('Rahul',    'Das',      'Midfielder', 7,  '2000-09-30', 'Indian', 2, 5),
('Pradeep',  'Nair',     'Defender',   4,  '1999-06-14', 'Indian', 2, 2),
('Suresh',   'Rao',      'Forward',    11, '2001-12-01', 'Indian', 3, 8),
('Deepak',   'Pillai',   'Midfielder', 6,  '2000-02-25', 'Indian', 3, 4),
('Vivek',    'Reddy',    'Defender',   3,  '1998-08-17', 'Indian', 3, 1),
('Manish',   'Tiwari',   'Forward',    9,  '2002-05-09', 'Indian', 4, 9),
('Gaurav',   'Yadav',    'Midfielder', 8,  '2000-10-20', 'Indian', 4, 6),
('Saurabh',  'Patel',    'Defender',   5,  '1999-03-12', 'Indian', 4, 0),
('Harsh',    'Gupta',    'Goalkeeper', 1,  '2001-07-28', 'Indian', 5, 0),
('Akash',    'Kumar',    'Forward',    10, '2000-01-05', 'Indian', 5, 11),
('Tushar',   'Shah',     'Midfielder', 7,  '1998-04-30', 'Indian', 5, 3),
('Varun',    'Mishra',   'Defender',   4,  '2002-09-22', 'Indian', 6, 1),
('Devesh',   'Bose',     'Forward',    11, '2001-06-15', 'Indian', 6, 7),
('Karan',    'Malhotra', 'Midfielder', 6,  '1999-12-08', 'Indian', 7, 5),
('Rishabh',  'Chauhan',  'Forward',    9,  '2000-08-14', 'Indian', 7, 6),
('Aniket',   'More',     'Defender',   3,  '2001-02-19', 'Indian', 8, 2),
('Shubham',  'Patil',    'Goalkeeper', 1,  '1998-07-07', 'Indian', 8, 0);

-- ============================================================
-- INSERT: matches (20+ matches)
-- ============================================================
INSERT INTO matches (tournament_id, venue_id, team1_id, team2_id, match_date, team1_score, team2_score, match_status, match_round) VALUES
(1, 1, 1, 2, '2026-01-15 15:00:00', 3, 1, 'Completed', 'Group Stage'),
(1, 2, 3, 4, '2026-01-16 17:00:00', 2, 2, 'Completed', 'Group Stage'),
(1, 3, 5, 6, '2026-01-17 14:00:00', 1, 0, 'Completed', 'Group Stage'),
(1, 1, 1, 3, '2026-01-20 15:00:00', 2, 1, 'Completed', 'Group Stage'),
(1, 2, 2, 4, '2026-01-21 17:00:00', 0, 2, 'Completed', 'Group Stage'),
(1, 3, 1, 4, '2026-01-25 15:00:00', 4, 0, 'Completed', 'Quarter Final'),
(1, 1, 2, 3, '2026-01-26 17:00:00', 1, 2, 'Completed', 'Quarter Final'),
(1, 4, 1, 3, '2026-02-01 16:00:00', 2, 0, 'Completed', 'Semi Final'),
(1, 4, 5, 2, '2026-02-02 16:00:00', 1, 3, 'Completed', 'Semi Final'),
(1, 4, 1, 2, '2026-03-30 18:00:00', 3, 2, 'Completed', 'Final'),
(2, 2, 7, 8, '2026-02-05 10:00:00', 0, 0, 'Completed', 'Group Stage'),
(2, 2, 9, 10, '2026-02-06 10:00:00', 0, 0, 'Completed', 'Group Stage'),
(2, 3, 7, 9, '2026-02-10 10:00:00', 0, 0, 'Completed', 'Group Stage'),
(2, 3, 8, 10, '2026-02-12 10:00:00', 0, 0, 'Completed', 'Group Stage'),
(2, 4, 7, 10, '2026-03-01 10:00:00', 0, 0, 'Live',      'Semi Final'),
(3, 3, 11, 12, '2026-03-10 09:00:00', 85, 72, 'Completed', 'Group Stage'),
(3, 3, 13, 14, '2026-03-11 09:00:00', 90, 88, 'Completed', 'Group Stage'),
(3, 5, 11, 13, '2026-03-15 09:00:00', 78, 80, 'Completed', 'Group Stage'),
(3, 5, 12, 14, '2026-03-16 09:00:00', 95, 88, 'Completed', 'Group Stage'),
(3, 3, 11, 14, '2026-04-18 09:00:00', 0,  0,  'Scheduled','Semi Final'),
(3, 5, 12, 13, '2026-04-19 09:00:00', 0,  0,  'Scheduled','Semi Final'),
(4, 2, 15, 16, '2026-04-25 11:00:00', 0,  0,  'Scheduled','Group Stage'),
(4, 2, 17, 15, '2026-04-28 11:00:00', 0,  0,  'Scheduled','Group Stage');

-- ============================================================
-- INSERT: match_stats (performance data)
-- ============================================================
INSERT INTO match_stats (match_id, player_id, goals, assists, yellow_cards, minutes_played) VALUES
(1, 1, 2, 1, 0, 90),
(1, 2, 1, 2, 1, 90),
(1, 3, 0, 0, 0, 90),
(1, 5, 1, 0, 1, 90),
(1, 6, 0, 1, 0, 90),
(2, 8, 1, 1, 0, 90),
(2, 11,1, 0, 1, 90),
(2, 12,0, 1, 0, 90),
(3, 15,1, 0, 0, 90),
(6, 1, 3, 1, 0, 90),
(6, 2, 1, 2, 0, 90),
(7, 5, 0, 1, 1, 90),
(7, 8, 1, 0, 0, 90),
(8, 1, 1, 1, 0, 90),
(8, 2, 1, 1, 0, 90),
(10,1, 2, 1, 0, 90),
(10,2, 1, 0, 1, 90),
(10,5, 1, 0, 0, 90),
(10,15,1, 0, 0, 90),
(16,8, 0, 2, 0, 40),
(17,11,0, 3, 0, 40);

-- ============================================================
-- UPDATE examples
-- ============================================================
-- Update tournament status after completion
UPDATE tournaments SET status = 'Completed' WHERE tournament_id = 1;

-- Update player goals after a match
UPDATE players SET goals_scored = goals_scored + 1 WHERE player_id = 1;

-- Update team wins after final
UPDATE teams SET wins = wins + 1 WHERE team_id = 1;

-- ============================================================
-- DELETE examples 
-- ============================================================
-- Delete a cancelled match (example)
-- DELETE FROM matches WHERE match_id = 22 AND match_status = 'Cancelled';

-- Soft approach: update status instead of hard delete
UPDATE matches SET match_status = 'Cancelled' WHERE match_id = 23 AND match_status = 'Scheduled';
