# Wazuh to n8n Webhook Integration

## ossec.conf Configuration
Add this block inside the Wazuh Manager container at /var/ossec/etc/ossec.conf:

<integration>
  <name>custom-n8n</name>
  <hook_url>http://YOUR_IP:5678/webhook/wazuh-alerts</hook_url>
  <level>5</level>
  <alert_format>json</alert_format>
</integration>

## Alert JSON Format
{
  "rule": { "level": 10, "description": "SSH brute force", "id": "5763" },
  "agent": { "name": "kali-lab", "ip": "10.0.0.247" },
  "data": { "srcip": "185.220.101.47", "dstip": "10.0.0.247" },
  "timestamp": "2026-05-31T22:30:00Z"
}

## Severity Mapping
| Wazuh Level | Severity |
|-------------|----------|
| 12+         | CRITICAL |
| 10-11       | HIGH     |
| 7-9         | MEDIUM   |
| Below 7     | LOW      |

## SSL Certificate Generation (Required)
cd ~/agentic-soc/wazuh-docker/single-node
docker compose -f generate-indexer-certs.yml run --rm generator
docker compose up -d
