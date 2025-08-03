-- PostgreSQL initialization script for opportune_jobs development database
-- This script runs automatically when the Docker container is first created

-- Create the development user
CREATE USER opportune_dev WITH PASSWORD 'password123';

-- Create the development database with the new user as owner
CREATE DATABASE opportune_jobs_dev OWNER opportune_dev;

-- Grant all privileges to the development user
GRANT ALL PRIVILEGES ON DATABASE opportune_jobs_dev TO opportune_dev;

-- Connect to the new database to set up the schema
\c opportune_jobs_dev;

-- Grant schema privileges
GRANT ALL ON SCHEMA public TO opportune_dev;

-- Set default privileges for future objects
ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT ALL ON TABLES TO opportune_dev;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT ALL ON SEQUENCES TO opportune_dev;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT ALL ON FUNCTIONS TO opportune_dev;

-- Log successful initialization
DO $$
BEGIN
    RAISE NOTICE 'Database opportune_jobs_dev initialized successfully with user opportune_dev';
END $$;