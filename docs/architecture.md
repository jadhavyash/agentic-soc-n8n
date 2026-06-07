# System Architecture

## Full Pipeline Flow

Kali Linux Endpoint
      |
      | (auth logs, file changes, process events)
      v
Wazuh Agent v4.7.5
      |
      | (forwards events to manager via port 1514)
      v
Wazuh Manager (Docker container)
      |
      | (fires webhook when rule level 5+)
      v
n8n Webhook Trigger (port 5678)
      |
      v
n8n AI Agent (GPT-4o-mini)
      |
      |--- check_virustotal  (if external IP)
      |--- check_abuseipdb   (if external IP)
      |
      v
Severity Decision
      CRITICAL / HIGH / MEDIUM / LOW
      |
      v
TheHive Case Created (if MEDIUM or above)
      - Title: AI-generated description
      - Severity: 1=LOW, 2=MEDIUM, 3=HIGH, 4=CRITICAL
      - Description: Plain-English analysis with IOC details
      - Tags: wazuh, kali-lab, agentic-soc
      - MITRE technique mapped

## Docker Services
| Container | Image | Port | Purpose |
|-----------|-------|------|---------|
| wazuh.manager | wazuh/wazuh-manager:4.7.5 | 1514, 1515, 55000 | SIEM core |
| wazuh.indexer | wazuh/wazuh-indexer:4.7.5 | 9200 | Log storage |
| wazuh.dashboard | wazuh/wazuh-dashboard:4.7.5 | 443 | Web UI |
| n8n | n8nio/n8n | 5678 | AI orchestration |
| thehive | strangebee/thehive:5.3 | 9000 | Case management |
| cassandra | cassandra:4 | - | TheHive database |
| elasticsearch | elasticsearch:7.17.9 | - | TheHive indexing |

## Tool Selection Rationale
| Tool | Why Chosen | Enterprise Equivalent |
|------|-----------|----------------------|
| Wazuh | Free, full SIEM+EDR, native webhook | Splunk, QRadar, Sentinel |
| n8n AI Agent | Native AI reasoning, not fixed playbooks | Palo Alto XSIAM AI |
| GPT-4o-mini | $0.001/alert, fast, tool-calling support | CrowdStrike Charlotte AI |
| VirusTotal | 90+ vendor coverage in one API call | Recorded Future |
| AbuseIPDB | Single confidence score, crowd-sourced | ThreatConnect |
| TheHive | Purpose-built IR case management, REST API | IBM Resilient, ServiceNow SecOps |
| Docker | One-command deployment, no dependency conflicts | Standard enterprise deployment |
| Kali Linux | Attack tools pre-installed for realistic testing | Dedicated red team infrastructure |

## Resource Requirements
| Resource | Minimum | Used in Lab |
|----------|---------|-------------|
| RAM | 8GB | 8GB (6GB under load) |
| Disk | 30GB | 40GB |
| CPU | 4 cores | 7 cores |
| OS | Any Linux | Kali Linux 2026.1 |

## Network Ports Used
| Port | Service | Protocol |
|------|---------|---------|
| 443 | Wazuh Dashboard | HTTPS |
| 1514 | Wazuh Agent communication | TCP |
| 1515 | Wazuh Agent enrollment | TCP |
| 5678 | n8n webhook + UI | HTTP |
| 9000 | TheHive UI + API | HTTP |
| 9200 | Wazuh Indexer | HTTPS |
| 55000 | Wazuh API | HTTPS |
