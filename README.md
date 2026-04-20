# 🏆 Sports Tournament Management System

A complete **Database Management System** built using MySQL for managing sports tournaments — including teams, players, matches, venues, and analytics.

---

## 📌 Project Overview

Managing sports tournaments manually leads to scheduling errors, lost records, and poor analytics. This system provides a structured relational database solution to handle:

- Multiple concurrent tournaments (Football, Cricket, Basketball, etc.)
- Team and player registration
- Match scheduling and result tracking
- Venue management
- Real-time standings and business analytics

---

## 🗃️ Database Schema

| Table | Description |
|---|---|
| `tournaments` | Tournament details (name, sport, dates, prize pool) |
| `venues` | Venue info (name, city, capacity) |
| `teams` | Teams registered per tournament |
| `players` | Players linked to teams |
| `matches` | Match schedule and results |
| `match_stats` | Per-player performance data per match |

---

## 📁 File Structure

```
SportsTournamentManagement/
│
├── sql/
│   ├── 01_DDL_create_tables.sql       # CREATE, ALTER, DROP
│   ├── 02_DML_insert_data.sql         # INSERT, UPDATE, DELETE (20+ records)
│   ├── 03_Advanced_SQL.sql            # Views, Indexes, Procedures, Functions, Triggers
│   └── 04_Business_Insights.sql       # 7 Analytical Queries
│
└── README.md
```

---

## 🚀 How to Run

1. Install **MySQL** (v8.0+) or use **MySQL Workbench**
2. Open MySQL and run files **in order**:
   ```sql
   SOURCE sql/01_DDL_create_tables.sql;
   SOURCE sql/02_DML_insert_data.sql;
   SOURCE sql/03_Advanced_SQL.sql;
   SOURCE sql/04_Business_Insights.sql;
   ```
3. Explore Views and call Stored Procedures as needed

---

## ⚙️ Tech Stack

- **Database**: MySQL 8.0
- **Language**: SQL (DDL, DML, Advanced SQL)
- **Tools**: MySQL Workbench

---

## 📊 Key Features

- ✅ Normalized schema (3NF) with proper Primary & Foreign Keys
- ✅ ER Diagram with 6 entities and defined cardinality
- ✅ 20+ records per main table
- ✅ Advanced SQL: 4 Views, 6 Indexes, 3 Stored Procedures, 1 Function, 2 Triggers
- ✅ 7 Business Insight queries with real-world interpretations

---

## 📈 Business Insights Covered

1. Tournament Standings / Points Table
2. Top Goal Scorers
3. Head-to-Head Team Records
4. Venue Utilization Report
5. Player Discipline (Cards) Report
6. Monthly Match Trend Analysis
7. Team Win Percentage Ranking

---

## 👤 Author

**Ayush D** | Data Engineering Capstone Project | 2026
