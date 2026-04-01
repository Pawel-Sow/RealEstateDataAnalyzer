🏡 Real Estate ETL & Analytics Dashboard

This project is a demo ETL pipeline and analytics system for real estate data.
It demonstrates how to collect, transform, and visualize external data using a modern data-driven architecture.

🚀 Overview

The solution consists of three main components:

DataCollectorService (Web Service)
Responsible for fetching data from an external API or local cache
SQL Server Database
Stores raw JSON data and transforms it into structured analytical tables
Dashboard Web Application (ASP.NET Razor Pages)
Visualizes the processed data using charts and KPI metrics
📡 Data Source

Data is fetched from the external API:
https://rapidapi.com/vibapidev/api/realfin-us

A free API key can be obtained (limited to 110 requests)
The application supports offline mode using cached data
💾 Data Collection

By default, the system reads data from local cache files.

This behavior can be configured in:

appsettings.json
"GetFromFileCache": true

Cached data includes 4 regions:

New York
Los Angeles
Hudson
Chicago
🗄️ Database

The database is responsible for:

storing raw API responses (JSON)
transforming data into structured format
providing analytical views for reporting
📌 Setup

To create the full database schema:

Open SQL Server Management Studio (SSMS)
Enable SQLCMD Mode
Run:
Database/Init/99_RunAll.sql

For more details, see the README in the /Database directory.

⚙️ Configuration

Make sure to configure the connection string in:

DataCollectorService
Dashboard Web Application
📊 Dashboard

The dashboard is built using ASP.NET Razor Pages and presents:

KPI metrics (average price, median price, etc.)
price distribution (histograms)
comparisons by:
region
property type
year built

Charts are implemented using Chart.js.

🎯 Project Goals

This project demonstrates:

ETL pipeline design
working with external APIs
SQL-based data transformation
building analytical views
data visualization in a web application
🧠 Notes
The system is designed to be resilient to API changes (e.g. unknown property types)
Data transformations are handled in SQL (views & stored procedures)
The application can run fully offline using cached data
🛠️ Tech Stack
.NET (BackgroundService, Razor Pages)
Entity Framework Core
SQL Server
Chart.js
