#!/bin/bash
set -e

# Function to wait for Postgres to be ready
wait_for_db() {
  echo "Waiting for database to be ready..."
  until pg_isready -h "${DB_HOST:-db}" -p "${DB_PORT:-5432}" -U "${POSTGRES_USER:-postgres}" > /dev/null 2>&1; do
    sleep 1
  done
}

# Remove a potentially pre-existing server.pid for Rails
rm -f /app/tmp/pids/server.pid

# Wait for Postgres
wait_for_db

# Run migrations
echo "Running database migrations..."
bin/rails db:migrate

# Then exec the container's main process (what's set as CMD in Dockerfile)
exec "$@"