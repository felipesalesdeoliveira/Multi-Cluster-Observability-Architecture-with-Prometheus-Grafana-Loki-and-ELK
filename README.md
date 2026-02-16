# 🔎 Multi-Cluster Observability Architecture with Terraform on AWS (EKS)

![observability](arquitetura_project-00.png)

---

## 📌 Sobre o Projeto

Este projeto implementa uma arquitetura de observabilidade distribuída baseada em dois clusters Kubernetes isolados em **VPCs separadas na AWS**, provisionados e gerenciados via **Terraform**.

Os clusters são executados no **Amazon EKS**.

- 🟢 **Application Cluster**
- 🔵 **Observability Cluster**

O objetivo é:

- Gerar logs e métricas em um cluster isolado
- Exportar esses dados para outro cluster via rede privada
- Centralizar observabilidade
- Comparar ingestão e consulta de logs via **Loki** e **ELK Stack**
- Monitorar métricas com **Prometheus**
- Visualizar tudo no **Grafana**
- Simular respostas HTTP 2xx, 4xx e 5xx para validação de alertas

Simula um cenário real corporativo multi-VPC com segregação de responsabilidades.

---

# 🏗️ Arquitetura da Solução

## 🔵 Cluster 1 – Observability Cluster (EKS)

Provisionado em uma **VPC dedicada**.

Responsável por:

- Prometheus
- Grafana
- Loki
- Elasticsearch
- Logstash
- Kibana

Recebe métricas e logs remotamente do Application Cluster.

---

## 🟢 Cluster 2 – Application Cluster (EKS)

Provisionado em uma **VPC separada**.

Responsável por:

- Duas aplicações de teste:
  - App 1 – Serviço estável (HTTP 200 constante)
  - App 2 – Serviço com falhas controladas (HTTP 200 / 400 / 500)
- Exportação de métricas via Prometheus
- Exportação de logs via:
  - Promtail → Loki
  - Filebeat → Logstash

Comunicação entre VPCs ocorre via **VPC Peering**.

---

# 🌐 Topologia de Rede (AWS)

- VPC-App (Application Cluster)
- VPC-Observability (Monitoring Cluster)
- VPC Peering configurado
- Route Tables atualizadas
- Security Groups restritivos
- Subnets públicas e privadas
- NAT Gateway para saída controlada

Segregação garante:

✔ Isolamento entre workloads  
✔ Segurança de rede  
✔ Arquitetura enterprise real  
✔ Comunicação privada entre clusters  

---

# 📊 Stack de Observabilidade

## 🔎 Métricas

- Prometheus
- Node Exporter
- Kube State Metrics
- Remote Scraping entre clusters
- Métricas por status HTTP (2xx, 4xx, 5xx)
- Error rate por aplicação

## 📜 Logs

### Loki Stack
- Promtail (Application Cluster)
- Loki (Observability Cluster)
- Visualização via Grafana

### ELK Stack
- Filebeat (Application Cluster)
- Logstash (Observability Cluster)
- Elasticsearch
- Visualização via Kibana

---

# ⚙️ Aplicações de Teste

Duas aplicações simples (Node.js ou .NET):

---

## 🟢 App 1 – Healthy Service

- Endpoint `/health`
- Retorna **HTTP 200 constantemente**
- Gera logs estruturados
- Serve como baseline de comparação

---

## 🔴 App 2 – Controlled Failure Service

- Endpoint `/`
- ~60% → HTTP 200
- ~25% → HTTP 400
- ~15% → HTTP 500

Logs estruturados contendo:

- Timestamp
- Status code
- Latência
- Hostname
- Correlation ID

Objetivo:

- Validar monitoramento de error rate
- Criar alertas apenas para 5xx
- Correlacionar métricas com logs
- Simular ambiente de produção real

---

# 🔄 Fluxo de Dados

1️⃣ Aplicação gera log  
2️⃣ Promtail e Filebeat coletam logs  
3️⃣ Logs enviados para:
   - Loki
   - Logstash → Elasticsearch  
4️⃣ Aplicações expõem `/metrics`  
5️⃣ Prometheus realiza scrape remoto  
6️⃣ Grafana consolida dashboards  

---

# 📂 Estrutura de Pastas Recomendada (Terraform AWS)

```
multi-cluster-observability-aws/
├── modules/
│   ├── vpc/
│   ├── eks-cluster/
│   ├── vpc-peering/
│   ├── iam/
│   └── helm-charts/
├── environments/
│   ├── dev/
│   └── prod/
├── scripts/
│   ├── deploy-apps.sh
│   └── metrics-export.sh
├── README.md
└── .gitignore
```

---

# 🚀 Provisionamento com Terraform

## 1️⃣ Inicializar

```bash
terraform init
```

## 2️⃣ Planejar

```bash
terraform plan -var-file=variables.tfvars
```

## 3️⃣ Aplicar

```bash
terraform apply -var-file=variables.tfvars --auto-approve
```

---

# ☁️ Recursos AWS Provisionados

- 2 VPCs
- Subnets públicas e privadas
- Internet Gateway
- NAT Gateway
- Route Tables
- VPC Peering
- Security Groups
- IAM Roles para EKS (IRSA)
- 2 Clusters Amazon EKS
- Helm Charts (Prometheus, Loki, ELK)
- Aplicações de teste
- Dashboards Grafana

---

# 🔐 Segurança Aplicada

- Clusters em VPCs separadas
- Comunicação privada via peering
- Security Groups restritivos
- IAM Roles for Service Accounts (IRSA)
- TLS interno
- RBAC configurado
- Segregação por subnets privadas

---

# 📈 Resultados Técnicos

✔ Dois clusters EKS isolados  
✔ Comunicação privada entre VPCs  
✔ Logs ingeridos em Loki e ELK simultaneamente  
✔ Métricas centralizadas  
✔ Monitoramento de 2xx, 4xx e 5xx  
✔ Alertas baseados em falhas críticas (5xx)  
✔ Arquitetura pronta para produção  

---

# 📚 Aprendizados Aplicados

- Arquitetura multi-cluster com Amazon EKS
- VPC Peering na AWS
- Segurança com Security Groups e IAM
- Observabilidade distribuída
- Remote scraping Prometheus
- Logs estruturados e correlação
- Provisionamento automatizado com Terraform
- Deploy automatizado via Helm

---

# ⭐ Se este projeto foi útil

Considere:

- Dar uma estrela ⭐
- Compartilhar com sua rede
- Contribuir com melhorias

---

> Este projeto demonstra arquitetura multi-cluster na AWS utilizando Amazon EKS, com centralização de observabilidade e simulação de falhas HTTP para validação completa de métricas, logs e alertas em ambiente isolado.
