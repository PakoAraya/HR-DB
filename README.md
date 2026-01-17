# 🗄️ HR-DB: Oracle Human Resources Schema for MySQL
### Ported & Enhanced by [PaKo Araya](https://github.com/PakoAraya)

![Database Schema Preview](https://raw.githubusercontent.com/oracle/dotnet-db-samples/master/schemas/hr/hr_schema.png) 
*Note: It is recommended to replace this with your own ER Diagram generated from MySQL Workbench.*

[![MySQL Version](https://img.shields.io/badge/MySQL-8.0+-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)
[![GitLab Mirroring](https://img.shields.io/badge/Mirroring-GitLab_to_GitHub-orange?style=for-the-badge&logo=gitlab)](https://gitlab.com)

This project is a modern and optimized recreation of the classic **Human Resources (HR)** schema from Oracle Database. It is initially adapted for **MySQL**, with a **PostgreSQL** version currently in development.

## ✨ Key Features

- 🏛️ **Classic Structure:** Includes all 7 original tables (`EMPLOYEES`, `DEPARTMENTS`, `JOBS`, etc.).
- 🛠️ **MySQL Optimized:** Adjusted data types (e.g., `AUTO_INCREMENT`, `TINYINT` for regions).
- ⚙️ **Business Logic:** Dedicated scripts for Stored Procedures, Triggers, and Functions.
- 📂 **Sample Data:** Full dataset population for immediate testing and querying.
- 🔄 **Automation:** Automated mirroring configured from GitLab to GitHub via SSH.

## 🚀 Quick Start (MySQL)

```bash
# 1. Clone the repository
git clone [https://github.com/PakoAraya/HR-DB.git](https://github.com/PakoAraya/HR-DB.git)

# 2. Navigate to the script directory
cd HR-DB/database/mysql

# 3. Import the schema and sample data
# Replace 'your_user' with your MySQL username
mysql -u your_user -p < ../schema/create_tables.sql
mysql -u your_user -p < ../data/insert_data.sql
```
## 🛠️ Tech Stack

| Component | Tool |
| :--- | :--- |
| **Database Engine** | ![MySQL](https://img.shields.io/badge/MySQL-005C84?style=flat-square&logo=mysql&logoColor=white)  8.0.35|
| **Language** | ![SQL](https://img.shields.io/badge/SQL-CC2927?style=flat-square&logo=sqlite&logoColor=white) |
| **Versioning** | ![GitLab](https://img.shields.io/badge/GitLab-FC6D26?style=flat-square&logo=gitlab&logoColor=white) ↔ ![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=github&logoColor=white) |
| **GitLab Version** |![GitLab Release](https://img.shields.io/gitlab/v/release/PakoAraya/HR-DB?gitlab_url=https%3A%2F%2Fgitlab.com&style=flat-square&logo=gitlab&label=Version)|
| **Last Commit** |![GitLab Last Commit](https://img.shields.io/gitlab/last-commit/PakoAraya/HR-DB?gitlab_url=https%3A%2F%2Fgitlab.com&style=flat-square&logo=gitlab&label=Last%20Update)|


## 📂 Project Structure

```bash
hr-db/
├── database/
│   ├── data/
│   │   ├── queries/        # SQL test queries and reports
│   │   └── seeds/          # Sample data and population scripts
│   ├── functions/          # Custom SQL functions
│   ├── migrations/         # Version control for database changes
│   ├── procedures/         # Stored procedures for business logic
│   ├── schema/             # Core database structure
│   │   ├── indexes/        # Performance optimization scripts
│   │   ├── schema/         # DDL (Table definitions)
│   │   └── views/          # Virtual tables and complex joins
│   └── triggers/           # Automation and audit logs
├── .gitignore
└── README.md
```
  
## 🗺️ Schema Entities

The project recreates the full organizational hierarchy:

1. **REGIONS & COUNTRIES**: Geographical structure.
2. **LOCATIONS & DEPARTMENTS**: Physical sites and business units.
3. **JOBS & JOB_HISTORY**: Salary definitions and role transitions.
4. **EMPLOYEES**: Master data, salary management, and reporting lines.

## 📊 Repository Stats

![GitHub Repo Size](https://img.shields.io/github/repo-size/PakoAraya/HR-DB?style=for-the-badge&color=blue)
![GitHub Last Commit](https://img.shields.io/github/last-commit/PakoAraya/HR-DB?style=for-the-badge&color=green)
![Static License](https://img.shields.io/badge/license-MIT-yellow?style=for-the-badge)
![GitHub Issues](https://img.shields.io/github/issues/PakoAraya/HR-DB?style=for-the-badge&color=orange)
![GitHub Pull Requests](https://img.shields.io/github/issues-pr/PakoAraya/HR-DB?style=for-the-badge&color=brightgreen)

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📝 Acknowledgements

* 🙏 Special thanks to [Oracle](https://www.oracle.com/) for providing the original data and schema.
* 🙏 Special thanks to [GitLab](https://gitlab.com/) for providing the GitLab mirroring service.