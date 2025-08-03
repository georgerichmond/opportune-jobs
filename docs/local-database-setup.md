# Local PostgreSQL Database Setup

This guide explains how to set up and use PostgreSQL 17 locally for development using Docker Compose.

## Prerequisites

- Docker Desktop installed and running
- pnpm package manager
- Port 5432 available on your local machine

## Quick Start

1. **Start the database:**
   ```bash
   pnpm db:up
   ```

2. **Verify the database is running:**
   ```bash
   docker ps
   ```
   You should see `opportune-jobs-postgres` container running.

3. **Database is ready when you see:**
   ```bash
   docker logs opportune-jobs-postgres
   ```
   Look for: "database system is ready to accept connections"

## Database Configuration

### Connection Details

- **Host:** localhost
- **Port:** 5432
- **Database:** opportune_jobs_dev
- **Username:** opportune_dev
- **Password:** password123
- **Connection URL:** `postgres://opportune_dev:password123@localhost:5432/opportune_jobs_dev`

### Environment Variables

Copy `.env.example` to `.env.local` for local development:
```bash
cp .env.example .env.local
```

The `.env.local` file contains the database connection string that your applications will use.

## Available Commands

### Start Database
```bash
pnpm db:up
```
Starts PostgreSQL 17 in a Docker container with:
- Automatic initialization using `init.sql`
- Health checks to ensure database readiness
- Persistent data volume

### Stop Database
```bash
pnpm db:down
```
Stops the PostgreSQL container gracefully.

### Reset Database
```bash
pnpm db:reset
```
⚠️ **Warning:** This will delete all data!
- Stops the container
- Removes the data volume
- Starts a fresh database instance

## Database Management

### Connecting with psql
```bash
docker exec -it opportune-jobs-postgres psql -U opportune_dev -d opportune_jobs_dev
```

### Connecting with GUI Tools
Use any PostgreSQL client (TablePlus, pgAdmin, DBeaver) with:
- Host: localhost
- Port: 5432
- Database: opportune_jobs_dev
- Username: opportune_dev
- Password: password123

### Viewing Logs
```bash
docker logs opportune-jobs-postgres
```

### Health Check
The container includes automatic health checks. You can verify status with:
```bash
docker inspect opportune-jobs-postgres --format='{{.State.Health.Status}}'
```

## Data Persistence

Database data is stored in a named Docker volume: `opportune-jobs-postgres-data`

- Data persists between container restarts
- Use `pnpm db:reset` to completely reset the database
- Backup the volume if needed:
  ```bash
  docker run --rm -v opportune-jobs-postgres-data:/data -v $(pwd):/backup alpine tar czf /backup/postgres-backup.tar.gz -C /data .
  ```

## Troubleshooting

### Port 5432 Already in Use
If you get an error about port 5432 being in use:
```bash
# Find what's using port 5432
lsof -i :5432

# Stop local PostgreSQL if running
brew services stop postgresql@17  # macOS
sudo systemctl stop postgresql    # Linux
```

### Container Won't Start
Check Docker logs:
```bash
docker logs opportune-jobs-postgres
```

### Permission Errors
Ensure Docker Desktop has necessary permissions and is running.

### Connection Refused
1. Verify container is running: `docker ps`
2. Check health status: `docker inspect opportune-jobs-postgres --format='{{.State.Health.Status}}'`
3. Wait for "healthy" status before connecting

## Development Workflow

1. Start the database before running your application
2. The database will be automatically initialized on first run
3. Your application can connect using the DATABASE_URL from `.env.local`
4. Data persists between sessions unless you run `pnpm db:reset`

## Security Notes

- The default credentials are for local development only
- Never use these credentials in production
- Railway will automatically inject secure credentials in production