#!/bin/bash
# Test the Agentic SOC pipeline with a simulated alert
# Usage: bash test-pipeline.sh
# Requires: curl, running n8n instance on localhost:5678

N8N_URL="http://localhost:5678/webhook/wazuh-alerts"

echo "========================================="
echo " Agentic SOC Pipeline Test"
echo "========================================="
echo "Sending SSH brute force alert from known malicious IP..."
echo ""

curl -X POST "$N8N_URL" \
  -H "Content-Type: application/json" \
  -d "{
    \"rule\": {
      \"level\": 10,
      \"description\": \"Multiple failed SSH login attempts\",
      \"id\": \"5763\"
    },
    \"agent\": {
      \"name\": \"kali-lab\",
      \"ip\": \"10.0.0.247\"
    },
    \"data\": {
      \"srcip\": \"185.220.101.47\",
      \"dstip\": \"10.0.0.247\"
    },
    \"timestamp\": \"$(date -u +\"%Y-%m-%dT%H:%M:%SZ\")\"
  }"

echo ""
echo "========================================="
echo " Expected AI Behavior"
echo "========================================="
echo "1. AI extracts srcip: 185.220.101.47 (external IP)"
echo "2. AI calls VirusTotal -> 13 detections found"
echo "3. AI calls AbuseIPDB -> 100% confidence score"
echo "4. AI assigns severity: CRITICAL"
echo "5. AI creates TheHive case with MITRE T1110 mapping"
echo "6. Total pipeline time: under 2 seconds"
echo ""
echo "Check results:"
echo "  n8n Executions: http://localhost:5678"
echo "  TheHive Cases:  http://localhost:9000"
echo "========================================="
