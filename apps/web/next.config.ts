import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  env: {
    DATABASE_URL: process.env.DATABASE_URL,
  },
  // Enable experimental features for better performance
  experimental: {
    // Optionally enable other experimental features here
  },
};

export default nextConfig;
