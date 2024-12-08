#!/bin/bash

url="http://localhost:8080/2" # Nginx 컨테이너의 URL
total_requests=100
concurrent_requests=10

echo "Starting load test with $total_requests requests..."

# 시작 시간 기록
start_time=$(date +%s)

for i in $(seq 1 $total_requests); do
  delay=$(( (i % 4 + 1) * 1000 )) # 순서대로 1초, 2초, 3초, 4초
  echo "Sending request $i with delay ${delay}ms"
  curl -X GET "${url}?requestId=${i}" &

  # 동시 요청 수 제한
  if (( i % concurrent_requests == 0 )); then
    wait
  fi
done

wait

# 종료 시간 기록
end_time=$(date +%s)

# 총 소요 시간 계산
elapsed_time=$((end_time - start_time))

echo "Load test completed!"
echo "Total time taken: ${elapsed_time} seconds"
