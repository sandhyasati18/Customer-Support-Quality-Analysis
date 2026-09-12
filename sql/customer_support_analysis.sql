-- Customer Support and Quality Analysis
-- MySQL 8+
-- Existing database: ecc
-- Tables used: ecc.agents and ecc.tickets

-- =========================================================
-- Q1. What are the overall support KPIs?
-- =========================================================
SELECT
    COUNT(*) AS total_tickets,
    ROUND(AVG(csat_score), 2) AS avg_csat,
    ROUND(AVG(qa_score), 2) AS avg_qa,
    ROUND(AVG(resolution_hours), 2) AS avg_resolution_hours
FROM ecc.tickets;

-- =========================================================
-- Q2. Find ticket volume by channel.
-- =========================================================
SELECT
    channel,
    COUNT(*) AS total_tickets
FROM ecc.tickets
GROUP BY channel
ORDER BY total_tickets DESC;

-- =========================================================
-- Q3. Find average CSAT and QA score by team.
-- =========================================================
SELECT
    a.team,
    COUNT(*) AS total_tickets,
    ROUND(AVG(t.csat_score), 2) AS avg_csat,
    ROUND(AVG(t.qa_score), 2) AS avg_qa
FROM ecc.tickets t
LEFT JOIN ecc.agents a
    ON a.agent_id = t.agent_id
GROUP BY a.team
ORDER BY avg_qa DESC;

-- =========================================================
-- Q4. Which issue types receive the most tickets?
-- =========================================================
SELECT
    issue_type,
    COUNT(*) AS total_tickets
FROM ecc.tickets
GROUP BY issue_type
ORDER BY total_tickets DESC;

-- =========================================================
-- Q5. Find SLA breaches using priority targets.
-- Critical = 4 hrs, High = 8 hrs, Medium = 24 hrs, Low = 48 hrs
-- =========================================================
SELECT
    priority,
    COUNT(*) AS total_tickets,
    SUM(
        CASE
            WHEN resolution_hours >
         CASE priority
            WHEN 'Critical' THEN 4
            WHEN 'High' THEN 8
            WHEN 'Medium' THEN 24
            WHEN 'Low' THEN 48
            END
            THEN 1
            ELSE 0
        END
    ) AS sla_breaches
FROM ecc.tickets
GROUP BY priority;

-- =========================================================
-- Q6. Find agents who require coaching (average QA below 85).
-- =========================================================
SELECT
    a.agent_name,
    a.team,
    ROUND(AVG(t.qa_score), 2) AS avg_qa,
    COUNT(*) AS tickets_handled
FROM ecc.tickets t
JOIN ecc.agents a
    ON a.agent_id = t.agent_id
GROUP BY a.agent_id, a.agent_name, a.team
HAVING AVG(t.qa_score) < 85
ORDER BY avg_qa;

-- =========================================================
-- Q7. Find escalation and reopening rates by team.
-- =========================================================
SELECT
    a.team,
    ROUND(
        100 * AVG(CASE WHEN t.escalated = 'Yes' THEN 1 ELSE 0 END),
        2
    ) AS escalation_rate,
    ROUND(
        100 * AVG(CASE WHEN t.reopened = 'Yes' THEN 1 ELSE 0 END),
        2
    ) AS reopen_rate
FROM ecc.tickets t
JOIN ecc.agents a
    ON a.agent_id = t.agent_id
GROUP BY a.team;

-- =========================================================
-- Q8. Rank agents by QA score within each team.
-- =========================================================
WITH agent_quality AS (
    SELECT
        a.team,
        a.agent_name,
        AVG(t.qa_score) AS avg_qa
    FROM ecc.tickets t
    JOIN ecc.agents a
        ON a.agent_id = t.agent_id
    GROUP BY a.team, a.agent_name
)
SELECT
    team,
    agent_name,
    ROUND(avg_qa, 2) AS avg_qa,
    DENSE_RANK() OVER (
        PARTITION BY team
        ORDER BY avg_qa DESC
    ) AS qa_rank
FROM agent_quality;

-- Key insight:
-- Use SLA breaches, QA scores, escalations and reopened tickets together
-- to identify coaching and process-improvement opportunities.
