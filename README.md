# 📚 EdTech Platform: Critical User Drop-off Analysis

## 🎯 Project Overview

This project analyzes a major activation issue on an EdTech platform using an end-to-end analytics workflow:

**CSV → PostgreSQL → Power BI**

The investigation revealed a **critical 90% user drop-off rate**, driven primarily by:

1. **New users failing onboarding (97.73% drop-off)**
2. **iOS-specific performance failure (97.67% drop-off)**

These results moved the analysis from informational → diagnostic → actionable.

---

## 📊 KPI Summary

| KPI                     | Value      | Business Impact                          |
| ----------------------- | ---------- | ---------------------------------------- |
| **Overall Drop-off**    | **90.00%** | 🚨 Losing 9 out of 10 new users          |
| **New User Drop-off**   | **97.73%** | Onboarding is fundamentally broken       |
| **iOS Device Drop-off** | **97.67%** | Indicates a severe platform-specific bug |

---

## 💡 Business Insights

### Insight 1 – The Core Product Works

* Power users have ~0% drop-off and strong retention.
* The failure is at **activation**, not product value.
* Focus should be on onboarding, not reworking core features.

### Insight 2 – The iOS Issue Is the Root Cause

* 97.67% iOS drop-off suggests a bug (crash, UI failure, login loop).
* Since most new users enter via mobile, **iOS failure drives the platform-wide 90% drop-off**.

---

## 📝 Strategic Recommendations

### 1. 🚨 Immediate Engineering Response (Highest Priority)

* Fix the iOS onboarding bug ASAP (Level 1 priority).
* Daily dropout monitoring in Power BI.
* Target: reduce iOS drop-off below **50% within 7 days**.

### 2. 📚 Onboarding Redesign

* Implement frictionless onboarding (“zero-step activation”).
* Give instant access to:

  * free sample lesson
  * course preview
  * guest mode experience

### 3. 📈 Data Collection Improvements

* Add **event-level tracking** to measure funnel drop-off:

  ```
  Landing → Sign-Up → Profile → First Lesson
  ```

---

## 🛠 Technical Methodology

**Pipeline:**
CSV → PostgreSQL (Diagnosis) → Power BI (Visualization)

| Stage                | Tool       | Purpose                             |
| -------------------- | ---------- | ----------------------------------- |
| Data Source          | CSV        | Raw sessions & metadata             |
| Storage & Processing | PostgreSQL | Segmentation & KPI computation      |
| Visualization        | Power BI   | KPI monitoring, breakdowns & alerts |

---

## 🧠 SQL Diagnostics (PostgreSQL)

### A. Drop-off by Segment

```sql
SELECT
    user_segment,
    COUNT(*) AS total_sessions,
    SUM(is_high_dropoff_risk) AS total_dropoffs,
    (CAST(SUM(is_high_dropoff_risk) AS NUMERIC) * 100 / COUNT(*)) AS dropoff_rate_percent
FROM
    users
GROUP BY
    user_segment
ORDER BY
    dropoff_rate_percent DESC;
```

### B. Drop-off by Device

```sql
SELECT
    device_type,
    COUNT(*) AS total_sessions,
    SUM(is_high_dropoff_risk) AS total_dropoffs,
    (CAST(SUM(is_high_dropoff_risk) AS NUMERIC) * 100 / COUNT(*)) AS dropoff_rate_percent
FROM
    users
GROUP BY
    device_type
ORDER BY
    dropoff_rate_percent DESC;
```

---

## 📊 Power BI Dashboard

Designed to highlight the **90% failure rate** and pinpoint root causes.

**Key Components**

* KPI Cards (Overall & segment-level drop-off)
* Segmented bar charts (User segment / Device type)
* Conditional formatting for alert thresholds
* Drill-down filters for device & session type

<img width="1680" height="1050" alt="Screenshot (858)" src="https://github.com/user-attachments/assets/82a82593-0292-4a96-bac7-bec8533c8d62" />

---



