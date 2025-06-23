# Flask Todo App

A simple Todo application built with Flask and PostgreSQL, running in a Nix development environment.

## Prerequisites

- Nix package manager installed

## Project Structure

```
.
├── app.py            # Flask application
├── db_init.sh        # Database initialization script
├── db_cleanup.sh     # Database cleanup script
├── shell.nix         # Nix development environment
├── .env              # Environment configuration
├── pgdata/           # PostgreSQL data directory (auto-generated)
└── templates/        # HTML templates
    └── index.html    # Main application interface
```

## Setup

1. Enter the Nix development shell:
   ```bash
   nix-shell
   ```
   This will:
   - Set up the Python environment with all required packages
   - Configure PostgreSQL environment variables
   - Initialize and start the PostgreSQL database
   - Create the todo_db database if it doesn't exist
   - Set up automatic cleanup on shell exit

3. Run the application:
   ```bash
   python app.py
   ```

The application will be available at http://localhost:3000

## Development

### Database Management

The database is automatically initialized when entering the nix-shell. The data is stored in the local `pgdata` directory. If you need to reset the database:

1. Exit the nix-shell
2. Remove the pgdata directory:
   ```bash
   rm -rf pgdata
   ```
3. Re-enter the nix-shell:
   ```bash
   nix-shell
   ```

### Environment Variables

#### Database Configuration
- `DATABASE_URL`: PostgreSQL connection URL
- `PGDATA`: PostgreSQL data directory
- `PGHOST`: PostgreSQL host socket directory
- `PGPORT`: PostgreSQL port (default: 5432)
- `PGDATABASE`: Default database name

#### Application Configuration
- `HOST`: Application host (default: 0.0.0.0)
- `PORT`: Application port (default: 3000)

### Database Credentials

The PostgreSQL superuser is created with these default credentials:
- Username: postgres
- Password: postgres@

## Features

- Create new todos
- Mark todos as complete/incomplete
- Delete todos
- Responsive design
- RESTful API endpoints
- Local PostgreSQL database
- Nix-managed development environment
- Automatic database cleanup on exit

## API Endpoints

- `GET /api/todos` - List all todos
- `POST /api/todos` - Create a new todo
  - Body: `{ "title": "Todo title" }`
- `PUT /api/todos/{id}` - Update a todo
  - Body: `{ "title": "New title", "completed": true }`
- `DELETE /api/todos/{id}` - Delete a todo

## Cleanup

The application automatically:
- Stops the PostgreSQL server when exiting the nix-shell
- Cleans up temporary files
- Ensures proper database shutdown

To completely reset the environment:
1. Exit the nix-shell
2. Delete the data directory: `rm -rf pgdata`
