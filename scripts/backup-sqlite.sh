#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$0")/.."

BACKUP_DIR="backups"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

sources=(
  "storage/production.sqlite3"
  "storage/production_cache.sqlite3"
  "storage/production_queue.sqlite3"
  "storage/production_cable.sqlite3"
)

labels=(main cache queue cable)

if ! command -v sqlite3 >/dev/null 2>&1; then
  echo "ERROR: sqlite3 is not installed."
  exit 1
fi

# Check every source before starting
for source in "${sources[@]}"; do
  if [[ ! -f "$source" ]]; then
    echo "ERROR: Database not found: $source"
    exit 1
  fi
done

mkdir -p "$BACKUP_DIR"

# Back up and verify each database
for i in "${!sources[@]}"; do
  source="${sources[$i]}"
  label="${labels[$i]}"

  dest="$BACKUP_DIR/production-${label}-${TIMESTAMP}.sqlite3"
  tmp="$BACKUP_DIR/.production-${label}-${TIMESTAMP}.tmp.sqlite3"

  if ! sqlite3 "$source" ".backup '$tmp'"; then
    rm -f "$tmp"
    echo "ERROR: Backup failed: $source"
    exit 1
  fi

  if ! check_result="$(sqlite3 "$tmp" 'PRAGMA integrity_check;')" \
      || [[ "$check_result" != "ok" ]]; then
    rm -f "$tmp"
    echo "ERROR: Integrity check failed: $source"
    exit 1
  fi

  mv "$tmp" "$dest"
  echo "Backup OK: $dest"
done

# Copy backups to Windows without deleting existing destination files
WINDOWS_BACKUP_DIR="/mnt/c/Users/Public/depot-backups"
mkdir -p "$WINDOWS_BACKUP_DIR"

if ! rsync -a --ignore-existing \
    "$BACKUP_DIR"/production-*.sqlite3 "$WINDOWS_BACKUP_DIR"/; then
  echo "ERROR: Could not sync backups to Windows."
  exit 1
fi

echo "Windows backup sync successful: $WINDOWS_BACKUP_DIR"

# Remove old backups only after all backups pass verification
find "$BACKUP_DIR" -maxdepth 1 -type f \
  -name 'production-*.sqlite3' -mtime +7 -delete

echo
echo "All database backups completed successfully."
ls -lh "$BACKUP_DIR"/production-*.sqlite3
