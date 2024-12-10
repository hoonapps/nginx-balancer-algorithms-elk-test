import { Controller, Get, Query } from '@nestjs/common';

@Controller()
export class AppController {
  @Get('/1')
  performTask1(): string {
    return `Processed by ${process.env.APP_NAME || 'API Server'}`;
  }

  @Get('/2')
  async performTask2(@Query('requestId') requestId: string): Promise<string> {
    // 요청 ID를 기반으로 딜레이 계산 (1초, 2초, 3초, 4초 반복)
    const id = parseInt(requestId || '0', 10);
    const delayOptions = [1000, 2000, 3000, 4000];
    const delay = delayOptions[id % delayOptions.length];

    // 처리 시간만큼 연결 유지
    await new Promise((resolve) => setTimeout(resolve, delay));

    return `Processed by ${process.env.APP_NAME || 'API Server'} in ${delay} ms\n`;
  }
}
