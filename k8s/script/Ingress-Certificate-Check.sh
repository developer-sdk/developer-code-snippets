#!/bin/bash
# k8s에 등록된 인그레스의 인증서를 확인해서 
# 만료 일자가 30일 미만이면 알람 출력 

# Get all hosts from Ingress resources
hosts=$(kubectl get ingress -o jsonpath='{.items[*].spec.rules[*].host}' -A)

# Check certificate expiry for each host
for host in $hosts; do
  echo "Checking certificate for $host"
  
  # Fetch the certificate expiry date
  expiry_date=$(echo | \
                openssl s_client -connect "$host:443" -servername "$host" 2>/dev/null | \
                openssl x509 -noout -dates | grep "notAfter" | cut -d= -f2)

  if [ -z "$expiry_date" ]; then
    echo "Failed to fetch certificate for $host"
    continue
  fi

  echo "Host: $host, Certificate expires on: $expiry_date"

  # Convert expiry date to seconds since epoch
  expiry_timestamp=$(date -d "$expiry_date" +%s)
  current_timestamp=$(date +%s)

  # Calculate the remaining days
  remaining_days=$(( (expiry_timestamp - current_timestamp) / 86400 ))

  # 30 day 
  if [ $remaining_days -le 30 ]; then
    echo "ALERT: Host $host, Certificate expires in $remaining_days days on $expiry_date"
  fi
done
