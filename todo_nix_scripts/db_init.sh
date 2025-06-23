#!/usr/bin/env bash

echo "Initializing database environment..."

# Local variables
LOCALE="POSIX"
PGSUPERUSER="postgres"

# PostgreSQL setup
export PGDATA="$PWD/pgdata"
export PGHOST="$PGDATA"
export PGPORT=5432
export PGDATABASE="todo_db"

# If the PostgreSQL server is already running, stop it
source cleanup.sh

# Create socket directory if it doesn't exist
mkdir -p "$PGDATA"

if [ ! -d "$PGDATA/base" ]; then
    echo "Initializing PostgreSQL database..."
    initdb -D "$PGDATA" --auth=trust --username="$PGSUPERUSER" --locale="$LOCALE"
fi

echo "Starting PostgreSQL..."
pg_ctl start -D "$PGDATA" -l "$PGDATA/postgresql.log" -o "--unix_socket_directories='$PGDATA'"

# Wait for PostgreSQL to start
for i in {1..30}; do
    if pg_isready -h "$PGHOST" -p "$PGPORT"; then
        echo "PostgreSQL is ready!"
        break
    fi
    echo "Waiting for PostgreSQL to start..."
    sleep 1
done

if ! psql -U "$PGSUPERUSER" -lqt | cut -d \| -f 1 | grep -qw todo_db; then
    echo "Creating todo_db database..."
    createdb -U "$PGSUPERUSER" todo_db
fi
