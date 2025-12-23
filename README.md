# Stock Market Financial Health Analysis - NIFTY 50
End-to-end data analytics project analyzing financial health of Nifty 50 companies using Excel, MySQL, Python, and Power BI.

## Project Context

In financial analysis, companies are often evaluated using **profit alone**, which can hide serious financial risks. A company may appear profitable while struggling with weak cash flows or excessive debt.

This project was built to answer a practical business question:

> **How can we objectively identify financially resilient companies and detect hidden financial risk among Nifty 50 stocks using real financial data?**

The analysis focuses on **cash flow quality, debt pressure, capital strength, and profit–cash flow alignment**, rather than profit in isolation.

## Business Objective

* Evaluate the **true financial health** of Nifty 50 companies
* Identify companies that are **financially resilient** over time
* Detect **high-risk companies** despite reported profitability
* Compare financial stability across **years and sectors**
* Convert raw financial statements into **decision-ready insights**

## Data Sources & Scope

* **NSE Website** – Sector classification
* **Screener.in** – Company financial statements

Scope of analysis:

* 50 Nifty 50 companies
* 51 raw datasets merged into a single analytical dataset
* Financial years covered: **2019–2025**

Only the **final cleaned and engineered dataset** is included in this repository.

## Data Analytics Pipeline

1. **Data Collection & Initial Cleaning (Excel)**

   * Standardized formats
   * Removed inconsistencies
   * Merged 50 individual company files

2. **Feature Engineering & Validation (Python)**

   * Data type validation
   * Missing value handling
   * Creation of financial risk indicators

3. **Structured Analysis (MySQL)**

   * Business-driven queries
   * Risk classification logic
   * Creation of analytical views

4. **Visualization & Modeling (Power BI)**

   * Financial health KPIs
   * Sector and company-level insights
   * Interactive dashboard for decision support


## Key Engineered Features (Python)

The following features were created to enable risk-focused analysis:

* **debt_pressure** – Measures leverage risk
* **capital_base** – Indicates long-term financial strength
* **profit_margin & ocf_margin** – Profitability vs real cash generation
* **profit_cash_divergence** – Flags profit–cash mismatch
* **positive_ocf_flag** – Indicates sustainable operating cash flow
* **high_debt_low_reserves_flag** – Identifies financial stress conditions

These features form the foundation for MySQL analysis and Power BI reporting.


## MySQL Business Analysis (Core Logic)

Using MySQL, the project answers **real financial questions**, including:

* How often do companies report profit without operating cash flow?
* Which companies repeatedly show profit–cash divergence?
* Which companies maintain consistent operating cash flow over time?
* Which companies carry high debt combined with weak cash generation?
* How does financial strength vary by sector?

Companies were classified into:

* **Financially Resilient**
* **High Risk**
* **Neutral**

based on cash flow consistency, debt pressure, and divergence behavior.

## Key Insights & Results

* **Profit alone is misleading**
  Multiple companies showed positive profits while generating negative operating cash flow.

* **Cash flow consistency is critical**
  Overall operating cash flow stability was approximately **86%**, but varied significantly by company and sector.

* **Debt amplifies risk**
  Companies with high debt pressure and weak cash flow emerged as the most financially vulnerable.

* **Sector-level patterns exist**
  Certain sectors demonstrated stronger financial consistency, while others showed structural risk.


## Power BI Dashboard

The Power BI dashboard presents:

* Financial health KPIs
* Year-wise cash flow trends
* Sector-wise stability comparison
* Company-level risk identification

Designed to support **investment analysis and financial risk assessment**.

## Outcome

This project demonstrates how **data analytics can improve financial decision-making** by moving beyond surface-level profit analysis and focusing on cash flow quality and financial resilience.


## Tools Used

* Excel
* Python (Pandas, NumPy)
* MySQL
* Power BI


## Notes

Only the final cleaned dataset is shared due to size and data-source considerations.
