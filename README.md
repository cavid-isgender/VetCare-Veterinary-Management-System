
# VetCare — Veterinary Clinic Management System

VetCare is a Flask and PostgreSQL project for managing veterinary clinic data. It demonstrates relational database design, SQL querying, database functions and triggers, and a browser-based interface for interacting with the database.

## Technology Stack

- **Python**
- **Flask** — web application and routes
- **PostgreSQL** — relational database
- **SQLAlchemy / Flask-SQLAlchemy** — database connectivity
- **HTML** — browser-based user interface

## Project Structure

```
VetCare/
├── app.py
├── db.py
├── templates/
│   └── index.html
├── sql/
│   └── [12 SQL scripts]
├── docs/
│   ├── VetCare_Technical_Portfolio_Report.pdf
│   └── screenshots/
├── requirements.txt
└── README.md
```

The names of the SQL scripts are intentionally not listed individually here; keep the original filenames of your 12 scripts in the `sql/` directory.

## Main Features

- Product CRUD operations through the web interface
- Database reports, including a view-based report
- Aggregate query using `GROUP BY` and `HAVING`
- A report that demonstrates `UNION`
- PostgreSQL functions called from the application
- A function demonstrating `RECORD` and `CURSOR`
- Database triggers for order-item validation, product stock updates, order-total updates, and appointment-date validation

## Database

VetCare uses PostgreSQL as its relational database management system.

Create a PostgreSQL database named `vetcare`, unless a different database name is configured in your local environment.

The SQL scripts in the `sql/` directory document the database schema, sample data, and database features. Execute the scripts in the appropriate dependency order when setting up a new database.

## Setup and Installation

#### Prerequisites

- Python 3.10 or later
- PostgreSQL
- pip

#### 1. Create and activate a virtual environment

On Windows PowerShell:

```
py -m venv .venv
.venv\Scripts\Activate.ps1
```

#### 2. Install dependencies

```
python -m pip install --upgrade pip
pip install -r requirements.txt
```

#### 3. Configure database access

The application uses `python-dotenv` to load database configuration from a `.env` file. The `db.py` module reads the `DATABASE_URL` environment variable.

Make sure the existing `.env` file is located in the project root directory and contains a valid PostgreSQL connection string:

```
DATABASE_URL=postgresql://USERNAME:PASSWORD@localhost:5432/vetcare
```

Replace `USERNAME` and `PASSWORD` with your local PostgreSQL credentials. Do not share the real credentials publicly.

**Security:** Never commit `.env`, database passwords, API keys, or other secrets to GitHub. Use a `.env.example` file containing placeholder values if you need to document the required configuration.

#### 4. Start the application

```
python app.py
```

Open the local URL printed by Flask in your browser. The default development address is commonly:

http://127.0.0.1:5000/

## Database Features

The project demonstrates:

- Primary keys, foreign keys, and referential integrity
- `CHECK` and `UNIQUE` constraints
- SQL views and aggregate queries using `HAVING`
- A report demonstrating `UNION`
- PostgreSQL functions called from the Flask application
- A PostgreSQL function using `RECORD` and `CURSOR`
- Database triggers for order-item validation, product stock updates, order-total updates, and appointment-date validation
- Browser-based operations and database reports

## Screenshots

### Application Interface
![VetCare Home](docs/screenshots/home.png)

### Products Page
![Products Page](docs/screenshots/products.png)

### Database Trigger Test
![Trigger Test](docs/screenshots/trigger-test.png)

### SQL Functions
![Sql Functions](docs/screenshots/sql_functions.png)

### Views Page
![Products Page](docs/screenshots/views.png)



## Notes

- The exact environment variables and database initialization steps depend on the current contents of `db.py`; adjust this README if those settings differ.
- The dependency list is a starting point based on the application’s known Flask/PostgreSQL stack. If your source files import additional third-party packages, add them to `requirements.txt`.
- Do not include `.env`, `.venv/`, `venv/`, `__pycache__/`, or IDE-specific folders in the portfolio ZIP.

## Author / Portfolio

This project was prepared as a database and backend development portfolio project. Add your preferred GitHub repository URL here when you publish it.