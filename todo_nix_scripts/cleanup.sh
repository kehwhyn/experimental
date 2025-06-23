#!/usr/bin/env bash

echo "Cleaning up PostgreSQL server..."

if [ -f "$PGDATA/postmaster.pid" ]; then
    echo "Stopping PostgreSQL server..."
    pg_ctl stop -D "$PGDATA" -m fast
    sleep 2  # Give it a moment to stop cleanly
fi

echo "Cleanup complete!"
