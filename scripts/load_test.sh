#!/bin/bash

url="http://localhost:8080/2" # Nginx 컨테이너의 URL
total_requests=20

echo "Starting load test with $total_requests requests..."
echo # 빈 줄 추가

# 시작 시간 기록
start_time=$(date +%s)

for ((i = 1; i <= total_requests; i++)); do
  delay=$(( ((i - 1) % 4 + 1) * 1000 )) # 순서대로 1초, 2초, 3초, 4초
  echo "Sending request $i with delay ${delay}ms"
  curl -X GET "${url}?requestId=${i}" &
  sleep 0.5 # 0.5초 간격으로 요청
done

echo # 빈 줄 추가
wait # 모든 요청이 완료될 때까지 대기

# 종료 시간 기록
end_time=$(date +%s)

# 총 소요 시간 계산
elapsed_time=$((end_time - start_time))

echo "Load test completed!"
echo # 빈 줄 추가
echo "Total time taken: ${elapsed_time} seconds"
echo # 빈 줄 추가
