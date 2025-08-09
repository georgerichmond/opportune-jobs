import { NextResponse } from 'next/server';
import { db, sql } from '@/lib/db';

export async function GET() {
  try {
    // Test basic database connectivity with a simple query
    const result = await db.execute(sql`SELECT 1 as health_check`);
    
    return NextResponse.json({
      status: 'healthy',
      database: 'connected',
      timestamp: new Date().toISOString(),
      result: result[0]
    });
  } catch (error) {
    console.error('Health check failed:', error);
    
    return NextResponse.json(
      {
        status: 'unhealthy',
        database: 'disconnected',
        timestamp: new Date().toISOString(),
        error: error instanceof Error ? error.message : 'Unknown error'
      },
      { status: 500 }
    );
  }
}
