# Customer Support and Quality Analysis - MySQL 8+
CREATE DATABASE IF NOT EXISTS support_qa;
USE support_qa;

CREATE TABLE agents(agent_id VARCHAR(10) PRIMARY KEY,agent_name VARCHAR(100),team_lead VARCHAR(100),team VARCHAR(50),location VARCHAR(50));
CREATE TABLE tickets(ticket_id VARCHAR(10) PRIMARY KEY,created_date DATE,agent_id VARCHAR(10),channel VARCHAR(20),issue_type VARCHAR(50),priority VARCHAR(20),resolution_hours DECIMAL(8,1),first_response_minutes INT,csat_score INT,qa_score DECIMAL(5,1),status VARCHAR(20),reopened VARCHAR(3),escalated VARCHAR(3),FOREIGN KEY(agent_id) REFERENCES agents(agent_id));

# Q1. What are the overall support KPIs?
SELECT COUNT(*) total_tickets,ROUND(AVG(csat_score),2) avg_csat,ROUND(AVG(qa_score),2) avg_qa,
ROUND(AVG(resolution_hours),2) avg_resolution_hours FROM tickets;

# Q2. Find ticket volume by channel.
SELECT channel,COUNT(*) total_tickets FROM tickets GROUP BY channel ORDER BY total_tickets DESC;

# Q3. Find average CSAT and QA score by team.
SELECT a.team,COUNT(*) total_tickets,ROUND(AVG(t.csat_score),2) avg_csat,ROUND(AVG(t.qa_score),2) avg_qa
FROM tickets t LEFT JOIN agents a ON a.agent_id=t.agent_id GROUP BY a.team ORDER BY avg_qa DESC;

# Q4. Which issue types receive the most tickets?
SELECT issue_type,COUNT(*) total_tickets FROM tickets GROUP BY issue_type ORDER BY total_tickets DESC;

# Q5. Find SLA breaches using priority targets.
SELECT priority,COUNT(*) total_tickets,
SUM(CASE WHEN resolution_hours>CASE priority WHEN 'Critical' THEN 4 WHEN 'High' THEN 8 WHEN 'Medium' THEN 24 ELSE 48 END THEN 1 ELSE 0 END) sla_breaches
FROM tickets GROUP BY priority;

# Q6. Find agents who require coaching (average QA below 85).
SELECT a.agent_name,a.team,ROUND(AVG(t.qa_score),2) avg_qa,COUNT(*) tickets_handled
FROM tickets t JOIN agents a ON a.agent_id=t.agent_id GROUP BY a.agent_id,a.agent_name,a.team
HAVING AVG(t.qa_score)<85 ORDER BY avg_qa;

# Q7. Find escalation and reopening rates by team.
SELECT a.team,ROUND(100*AVG(CASE WHEN t.escalated='Yes' THEN 1 ELSE 0 END),2) escalation_rate,
ROUND(100*AVG(CASE WHEN t.reopened='Yes' THEN 1 ELSE 0 END),2) reopen_rate
FROM tickets t JOIN agents a ON a.agent_id=t.agent_id GROUP BY a.team;

# Q8. Rank agents by QA score within each team.
WITH agent_quality AS(SELECT a.team,a.agent_name,AVG(t.qa_score) avg_qa FROM tickets t JOIN agents a ON a.agent_id=t.agent_id GROUP BY a.team,a.agent_name)
SELECT team,agent_name,ROUND(avg_qa,2) avg_qa,DENSE_RANK() OVER(PARTITION BY team ORDER BY avg_qa DESC) qa_rank FROM agent_quality;

# Key insight: Use SLA breaches, QA scores, escalations and reopened tickets together to identify coaching and process-improvement opportunities.

