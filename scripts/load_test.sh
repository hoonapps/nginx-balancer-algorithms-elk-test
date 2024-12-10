#!/bin/bash

url="http://localhost:8080/cpu-intensive" # Nginx Container URL
concurrent_requests=(600 700 800 900) 
total_requests=(1200 1400 1600 1800) 
algorithm=LeastConnections # algorithm name (RoundRobin or LeastConnections)

if [[ -z $algorithm ]]; then
  echo "Usage: $0 <Algorithm>"
  echo "Algorithm should be either 'RoundRobin' or 'LeastConnections'"
  exit 1
fi

echo "Starting load test for $algorithm algorithm..."

# check start time
overall_start_time=$(date +%s)

# Step-by-Step Test
for i in "${!concurrent_requests[@]}"; do
  concurrent="${concurrent_requests[$i]}"
  total="${total_requests[$i]}"

  echo "Testing with $total total requests and $concurrent concurrent requests..."
  
  # Perform the test using Apache Benchmark
  ab -n "$total" -c "$concurrent" "$url" > "results_${algorithm}_${total}_${concurrent}.txt"

  echo "Completed test for $total requests and $concurrent concurrent requests."
done

# check end time
overall_end_time=$(date +%s)
overall_elapsed_time=$((overall_end_time - overall_start_time))

echo "Load test completed for $algorithm algorithm!"
echo "Total time taken: ${overall_elapsed_time} seconds"
