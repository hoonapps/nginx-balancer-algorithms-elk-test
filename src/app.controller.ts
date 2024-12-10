import { Controller, Get, Query } from '@nestjs/common';

@Controller()
export class AppController {
  // API with fixed delays (Basic API for step-by-step testing)
  @Get('/fixed-delay')
  async fixedDelay(@Query('requestId') requestId: string): Promise<string> {
    // Calculate delay based on the request ID (repeats between 1 second and 4 seconds)
    const id = parseInt(requestId || '0', 10);
    const delayOptions = [1000, 2000, 3000, 4000];
    const delay = delayOptions[(id - 1) % delayOptions.length]; // 1부터 시작하는 순서

    // Hold the connection for the calculated delay duration
    await new Promise((resolve) => setTimeout(resolve, delay));

    return `RequestId: ${requestId} => Processed by ${process.env.APP_NAME || 'API Server'} in ${delay} ms\n`;
  }

  // API with random delays (For irregular load testing)
  @Get('/random-delay')
  async randomDelay(@Query('requestId') requestId: string): Promise<string> {
    // Random delay between 500ms and 5000ms
    const delay = Math.floor(Math.random() * 4500) + 500;

    // Hold the connection for the calculated delay duration
    await new Promise((resolve) => setTimeout(resolve, delay));

    return `RequestId: ${requestId} => Processed by ${process.env.APP_NAME || 'API Server'} in ${delay} ms\n`;
  }

  // API simulating CPU-intensive tasks
  @Get('/cpu-intensive')
  async cpuIntensive(@Query('requestId') requestId: string): Promise<string> {
    const id = parseInt(requestId || '0', 10);
    const delay = ((id % 3) + 1) * 1000; // Task duration between 1 and 3 seconds

    // Simulate CPU-intensive work
    const start = Date.now();
    while (Date.now() - start < delay) {
      // CPU computation
    }

    return `RequestId: ${requestId} => Processed by ${process.env.APP_NAME || 'API Server'} after CPU-intensive task of ${delay} ms\n`;
  }
}
