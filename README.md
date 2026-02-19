# 🔎 Multi-Cluster Observability Architecture with Terraform on AWS (EKS)

![observability](arquitetura_project-00.png)

---

## 📌 Sobre o Projeto

Este projeto implementa uma arquitetura de observabilidade distribuída baseada em dois clusters Kubernetes isolados na AWS, provisionados via Terraform.

Os clusters são executados no Amazon EKS e possuem responsabilidades separadas:

- 🟢 Application Cluster
- 🔵 Observability Cluster

O objetivo é:

- Isolar workloads de aplicação e monitoramento
- Centralizar métricas e logs
- Exportar dados do cluster de aplicação para o cluster de observabilidade
- Monitorar status HTTP (2xx, 4xx, 5xx)
- Implementar arquitetura realista e modular pronta para ambiente corporativo

---

# 🏗️ Arquitetura da Solução

A arquitetura é composta por dois clusters EKS independentes, cada um em sua própria VPC simplificada (single-AZ para redução de complexidade e custo).

---

## 🔵 Cluster 1 – Observability Cluster (EKS)

Responsável por centralizar monitoramento e visualização.

Componentes implantados via Helm:

- Prometheus
- Grafana
- Loki
- Alertmanager

Funções:

- Receber métricas do Application Cluster
- Receber logs via Fluent Bit
- Armazenar séries temporais
- Criar dashboards e alertas

---

## 🟢 Cluster 2 – Application Cluster (EKS)

Responsável por executar workloads de aplicação.

Componentes:

- Aplicações de teste (App 1 e App 2)
- Fluent Bit (DaemonSet)
- Prometheus Exporter
- ServiceMonitor ou configuração de scrape remoto

Funções:

- Gerar métricas HTTP
- Gerar logs estruturados
- Exportar métricas para Prometheus remoto
- Enviar logs para Loki no cluster de Observabilidade

---

# 🌐 Topologia de Rede (AWS)

Cada cluster possui:

- 1 VPC dedicada
- 2 subnets (1 pública + 1 privada)
- 1 NAT Gateway
- Internet Gateway
- Route Tables específicas
- Security Groups restritivos

Clusters se comunicam via:

- VPC Peering
ou
- Endpoint privado configurado entre clusters

Arquitetura simplificada, sem múltiplas AZs e sem excesso de subnets.

---

# 📊 Stack de Observabilidade

## 🔎 Métricas

No Application Cluster:

- Prometheus Exporter expõe métricas em `/metrics`
- Métricas HTTP:
  - Requests totais
  - Status 2xx, 4xx, 5xx
  - Latência
  - Throughput

No Observability Cluster:

- Prometheus realiza scrape remoto
- Alertmanager envia alertas para falhas 5xx
- Grafana consolida dashboards

---

## 📜 Logs

No Application Cluster:

- Fluent Bit coleta logs de containers
- Logs estruturados contendo:
  - Timestamp
  - Status code
  - Latência
  - Pod name
  - Namespace

Envio de logs para:

- Loki no Observability Cluster

Visualização via Grafana.

---

# ⚙️ Aplicações de Teste

## 🟢 App 1 – Healthy Service

- Endpoint `/health`
- Retorna HTTP 200 constantemente
- Gera logs estruturados

---

## 🔴 App 2 – Controlled Failure Service

- Endpoint `/`
- ~60% → HTTP 200
- ~25% → HTTP 400
- ~15% → HTTP 500

Objetivos:

- Medir error rate
- Criar alerta apenas para 5xx
- Validar correlação entre métricas e logs
- Simular comportamento real de produção

---

# 🔄 Fluxo de Dados

1️⃣ Aplicação gera requisição  
2️⃣ Logs coletados pelo Fluent Bit  
3️⃣ Logs enviados para Loki  
4️⃣ Aplicação expõe métricas em `/metrics`  
5️⃣ Prometheus (Observability Cluster) realiza scrape remoto  
6️⃣ Grafana exibe dashboards consolidados  

---

# 📂 Estrutura Recomendada (Terraform)

```
multi-cluster-observability/
├── modules/
│   ├── vpc/
│   ├── eks/
│   ├── peering/
│   ├── iam/
│   └── helm/
├── app-manifests/
│   ├── app1.yaml
│   ├── app2.yaml
│   ├── fluentbit.yaml
│   └── exporter.yaml
├── environments/
│   ├── app/
│   └── observability/
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
terraform plan -var-file=app.tfvars
terraform plan -var-file=observability.tfvars
```

## 3️⃣ Aplicar

```bash
terraform apply -var-file=observability.tfvars --auto-approve
terraform apply -var-file=app.tfvars --auto-approve
```

---

# ☁️ Recursos AWS Provisionados

- 2 VPCs (simples, single-AZ)
- 2 Clusters Amazon EKS
- IAM Roles (IRSA habilitado)
- Security Groups restritivos
- VPC Peering
- Helm Charts (Prometheus, Grafana, Loki)
- Fluent Bit como DaemonSet
- Aplicações de teste
- Dashboards e Alertas

---

# 🔐 Segurança Aplicada

- Isolamento total entre clusters
- Comunicação privada entre VPCs
- IAM Roles for Service Accounts (IRSA)
- RBAC configurado
- Logs e métricas trafegando via rede privada
- Sem exposição pública de componentes internos

---

# 📈 Resultados Técnicos

✔ Separação clara entre aplicação e observabilidade  
✔ Logs centralizados via Fluent Bit + Loki  
✔ Métricas coletadas via Prometheus Exporter  
✔ Alertas baseados em erro 5xx  
✔ Arquitetura modular e escalável  
✔ Provisionamento 100% automatizado com Terraform  
✔ Estrutura pronta para ambiente enterprise  

---

# 📚 Aprendizados Aplicados

- Arquitetura multi-cluster com Amazon EKS
- VPC Peering na AWS
- Observabilidade distribuída
- Remote scraping Prometheus
- Coleta de logs com Fluent Bit
- Alertas baseados em métricas críticas
- Terraform modular
- Deploy automatizado via Helm

---

# ⭐ Se este projeto foi útil

Considere:

- Dar uma estrela ⭐
- Compartilhar com sua rede
- Contribuir com melhorias

---

> Este projeto demonstra uma arquitetura multi-cluster moderna com Amazon EKS, separando workloads de aplicação e observabilidade, centralizando métricas e logs via Prometheus e Fluent Bit em ambiente isolado e automatizado com Terraform.
