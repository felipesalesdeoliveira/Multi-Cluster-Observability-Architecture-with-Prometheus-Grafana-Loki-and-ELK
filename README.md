# 🔎 Multi-Cluster Observability Architecture with Prometheus, Grafana, Loki and ELK

![observability](arquitetura_project-00.png)

---

## 📌 Sobre o Projeto

Este projeto implementa uma arquitetura de observabilidade distribuída baseada em dois clusters Kubernetes isolados em redes separadas:

- 🟢 **Cluster de Aplicações**
- 🔵 **Cluster de Observabilidade**

O objetivo é:

- Gerar logs e métricas em um cluster isolado
- Exportar esses dados para outro cluster
- Centralizar observabilidade
- Comparar ingestão e consulta de logs via **Loki** e **ELK Stack**
- Monitorar métricas com **Prometheus**
- Visualizar tudo no **Grafana**

Simula um cenário real de produção multi-ambiente com segregação de responsabilidades.

---

# 🏗️ Arquitetura da Solução

## 🔵 Cluster 1 – Observability Cluster

Responsável por:

- Prometheus
- Grafana
- Loki
- Elasticsearch
- Logstash
- Kibana

Este cluster é isolado em sua própria VNet/Subnet.

Recebe métricas e logs remotamente do cluster de aplicações.

---

## 🟢 Cluster 2 – Application Cluster

Responsável por:

- Duas aplicações de teste:
  - App 1 – Geração de logs HTTP 200 frequentes
  - App 2 – Geração de logs HTTP 200 e 500 simulados
- Exportação de métricas via Prometheus
- Exportação de logs via:
  - Promtail → Loki
  - Filebeat → Logstash (ELK)

Este cluster está em VNet separada, com comunicação controlada via peering.

---

# 🌐 Topologia de Rede

- VNet-App (Cluster Aplicação)
- VNet-Observability (Cluster Monitoramento)
- VNet Peering configurado
- NSGs restringindo tráfego
- Comunicação apenas nas portas necessárias

Segregação garante:

✔ Isolamento  
✔ Segurança  
✔ Simulação de ambiente corporativo real  

---

# 📊 Stack de Observabilidade

## 🔎 Métricas

- Prometheus
- Node Exporter
- Kube State Metrics
- Remote Scraping entre clusters

## 📜 Logs

### Loki Stack
- Promtail (no cluster app)
- Loki (cluster observability)
- Consulta via Grafana

### ELK Stack
- Filebeat (cluster app)
- Logstash (cluster observability)
- Elasticsearch
- Visualização via Kibana

---

# ⚙️ Aplicações de Teste

Duas aplicações simples (exemplo: Node.js ou .NET Minimal API):

### App 1
- Endpoint `/health`
- Retorna 200 constantemente
- Gera log a cada request

### App 2
- Endpoint `/`
- 80% status 200
- 20% status 500 simulados
- Logs estruturados (JSON)

Logs incluem:
- Timestamp
- Status code
- Latência
- Hostname
- Correlation ID

---

# 🔄 Fluxo de Dados

1️⃣ Aplicação gera log  
2️⃣ Log é coletado por Promtail e Filebeat  
3️⃣ Logs enviados para:
   - Loki
   - Logstash → Elasticsearch  
4️⃣ Métricas expostas via `/metrics`  
5️⃣ Prometheus faz scrape remoto  
6️⃣ Grafana centraliza dashboards  

---

# 📈 Comparação Loki vs ELK

O projeto permite comparar:

| Critério | Loki | ELK |
|----------|------|------|
| Modelo | Indexa labels | Indexa conteúdo completo |
| Custo | Mais leve | Mais pesado |
| Escalabilidade | Alta | Alta |
| Query | LogQL | DSL |

Objetivo prático: avaliar performance, custo e experiência de consulta.

---

# 🔐 Segurança Aplicada

- Clusters em VNets separadas
- Network Policies no Kubernetes
- TLS entre componentes
- RBAC configurado
- Secretos via Kubernetes Secrets
- Comunicação restrita via NSG

---

# 🚀 Provisionamento

Provisionamento pode ser feito via:

- Terraform
- Azure CLI
- Helm Charts para stacks

Componentes instalados via:

- Helm (Prometheus Stack)
- Helm (Loki Stack)
- Helm (Elastic Stack)

---

# 📊 Observabilidade Implementada

Dashboards incluem:

- Taxa de requisições
- Percentual de erros
- Latência média
- Logs por status code
- Comparativo Loki vs Kibana
- Consumo de recursos do cluster

---

# 🧠 Decisões Técnicas

- Separação física de clusters para simular ambiente enterprise
- Dupla ingestão de logs para comparação real
- Métricas e logs desacoplados
- Uso de Helm para padronização
- Aplicações leves apenas para geração de carga
- Estrutura pensada para escalabilidade futura

---

# 📚 Aprendizados Aplicados

- Arquitetura multi-cluster Kubernetes
- Observabilidade distribuída
- Comparação prática Loki vs ELK
- Segurança em redes segmentadas
- Remote scraping Prometheus
- Logs estruturados e correlação
- Estratégia de monitoramento enterprise

---

# 📈 Resultados Técnicos

✔ Dois clusters isolados e comunicando via peering  
✔ Logs ingeridos simultaneamente em Loki e ELK  
✔ Métricas centralizadas  
✔ Dashboards funcionais  
✔ Simulação realista de ambiente corporativo  

---

# ⭐ Projeto focado em

Cloud Engineer  
DevOps Engineer  
SRE  
Observability Engineer  

---

> Este projeto demonstra arquitetura multi-cluster com centralização de observabilidade e comparação prática entre Loki e ELK em ambiente isolado.
