# Agentic SOC — Autonomous AI-Powered Alert Triage

Fully autonomous Security Operations Center built on Kali Linux.
Wazuh SIEM detects threats → n8n AI Agent (GPT-4o-mini) triages autonomously
→ VirusTotal + AbuseIPDB enrichment → TheHive case auto-created in under 2 seconds.

## Results
| Metric | Manual | Agentic AI | Improvement |
|--------|--------|-----------|-------------|
| Triage time | 25+ min | Under 2 sec | 92% faster |
| False positives | High | 60%+ reduced | AI suppresses internal IPs |
| IOC enrichment | Manual | Automated | 100% automated |

## Stack
- Wazuh 4.7.5 — SIEM + EDR
- n8n — AI Agent orchestration
- OpenAI GPT-4o-mini — reasoning engine
- VirusTotal API — threat intelligence
- AbuseIPDB API — IP reputation
- TheHive 5.3 — case management
- Docker — containerization
- Kali Linux — host OS + attack simulation

## Attack Scenarios Tested
| Attack | Severity | MITRE |
|--------|----------|-------|
| SSH Brute Force | HIGH | T1110 |
| Ransomware C2 | CRITICAL | T1071 |
| SQL Injection | HIGH | T1190 |
| Crypto Miner | HIGH | T1496 |
| Port Scan | MEDIUM | T1046 |
| Malware Hash | CRITICAL | T1204 |
| Phishing URL | HIGH | T1566 |
| Privilege Escalation | CRITICAL | T1548 |
| FTP Brute Force | MEDIUM | T1110 |
| Data Exfiltration | CRITICAL | T1041 |
| Web Shell | CRITICAL | T1505 |
