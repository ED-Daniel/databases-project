#!/bin/bash

export PGPASSWORD="$POSTGRES_PASSWORD"

# Ждём запуск PostgreSQL
echo "Ожидание запуска PostgreSQL..."
until pg_isready -h postgres -p 5432 -U test; do
  sleep 2
done

echo "PostgreSQL запущен! Выполняем SQL-скрипты..."

# Выполняем скрипты
psql -h postgres -U test -d bdsm -f /scripts/init.sql
psql -h postgres -U test -d bdsm -f /scripts/permissions.sql

for sql_file in /scripts/functions/*.sql; do
  echo "Выполняем $sql_file..."
  psql -h postgres -U test -d bdsm -f "$sql_file"
done

for sql_file in /scripts/triggers/*.sql; do
  echo "Выполняем $sql_file..."
  psql -h postgres -U test -d bdsm -f "$sql_file"
done

for sql_file in /scripts/procedures/*.sql; do
  echo "Выполняем $sql_file..."
  psql -h postgres -U test -d bdsm -f "$sql_file"
done

for sql_file in /scripts/views/*.sql; do
  echo "Выполняем $sql_file..."
  psql -h postgres -U test -d bdsm -f "$sql_file"
done

for sql_file in /scripts/materialized_views/*.sql; do
  echo "Выполняем $sql_file..."
  psql -h postgres -U test -d bdsm -f "$sql_file"
done

psql -h postgres -U test -d bdsm -f /scripts/import.sql

echo "SQL-скрипты выполнены успешно!"
