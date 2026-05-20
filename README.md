# 🗄️ Global Layoffs SQL Analysis

> Exploring worldwide tech layoff trends through data cleaning, transformation, and exploratory analysis — all in SQL.

![SQL](https://img.shields.io/badge/SQL-4479A1?style=flat&logo=mysql&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-005C84?style=flat&logo=mysql&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-green?style=flat)

---

## 📌 Overview

Between 2020 and 2024, thousands of companies worldwide laid off hundreds of thousands of workers. This project digs into that data using SQL to answer key questions:

- Which industries and companies were hit hardest?
- How did layoffs evolve over time?
- What geographic regions saw the most impact?
- Which funding stages were most affected?

The focus is on demonstrating **real-world SQL skills** — from messy raw data to clean, insightful analysis.

---

## 🎯 Project Goals

- Practice **data cleaning and transformation** in SQL
- Perform **exploratory data analysis (EDA)** without external tools
- Uncover **meaningful patterns** in a real-world dataset
- Build a portfolio piece that showcases end-to-end SQL thinking

---

## 🗂️ Project Structure

```
Layoffs_Project_SQL/
│
├── data_cleaning.sql        # Raw → clean: deduplication, nulls, formatting
├── exploratory_analysis.sql # EDA queries and trend analysis
├── data/
│   └── layoffs.csv          # Raw dataset
└── README.md
```

---

## 🧹 Part 1 — Data Cleaning

Raw data is rarely analysis-ready. This stage covers:

- ✅ Removing duplicate records
- ✅ Standardising inconsistent values (company names, industries, countries)
- ✅ Handling NULL and blank values
- ✅ Fixing date formats for time-series analysis
- ✅ Dropping irrelevant or unreliable columns

---

## 📊 Part 2 — Exploratory Data Analysis

Key questions explored through SQL queries:

| Question | Approach |
|---|---|
| Which companies had the largest single layoffs? | `ORDER BY total_laid_off DESC` |
| Which industries were hit hardest overall? | `GROUP BY industry` |
| How did layoffs trend month over month? | Rolling sum with `OVER()` window functions |
| Which countries saw the most layoffs? | `GROUP BY country` |
| Which funding stages were most affected? | `GROUP BY stage` |
| Top 5 companies by layoffs per year | `DENSE_RANK()` window function |

---

## 💡 Key Findings

- **Consumer and Retail** industries saw some of the highest total layoffs
- Layoff peaks aligned with major market downturns and post-pandemic corrections
- Several companies laid off **100% of their workforce**, signalling full shutdowns
- **Later-stage funded companies** (Post-IPO) accounted for a large share of total layoffs
- Layoffs were heavily concentrated in the **United States**

---

## 🛠️ SQL Concepts Used

| Concept | Used For |
|---|---|
| `CTEs` | Multi-step cleaning logic |
| `ROW_NUMBER()` | Deduplication |
| `DENSE_RANK()` | Yearly company rankings |
| Window functions `OVER()` | Rolling totals over time |
| `GROUP BY` + `ORDER BY` | Aggregated trend analysis |
| `CASE WHEN` | Conditional transformations |
| String functions | Standardising messy text fields |

---

## 🚀 How to Run

### 1. Clone the repo
```bash
git clone https://github.com/gail-mar/Layoffs_Project_SQL.git
cd Layoffs_Project_SQL
```

### 2. Set up the database
Import the dataset into your SQL environment (MySQL recommended):
```sql
CREATE DATABASE layoffs_db;
USE layoffs_db;
-- then import layoffs.csv via your SQL client
```

### 3. Run the scripts in order
```
1. data_cleaning.sql
2. exploratory_analysis.sql
```

---

## 📁 Dataset

The dataset contains real-world layoff records including:
- Company name, industry, and location
- Total employees laid off & percentage laid off
- Date of layoffs
- Company stage and funds raised

> Source: [Layoffs.fyi](https://layoffs.fyi) — a crowd-sourced tracker of tech layoffs.

---

## 👩‍💻 Author

**Gail Marechal** — Data Science & AI  
[![GitHub](https://img.shields.io/badge/GitHub-gail--mar-181717?style=flat&logo=github)](https://github.com/gail-mar)

---

*Part of a data analytics portfolio showcasing SQL, Power BI, and AI projects.*
