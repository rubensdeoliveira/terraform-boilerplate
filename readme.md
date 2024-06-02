# Terraform Boilerplate

## Pré-Requisitos

- Criar arquivo docker do backend
- Criar arquivo docker do frontend
- Conectar ao gcloud localmente com gcloud auth login
- Gerar build do docker do backend com endereço do gcloud. ex: 
`docker build -t gcr.io/PROJECT_ID/PROJECT_NAME .`
onde PROJECT_ID você pega do console do GCP e PROJECT_NAME pode-se escolher de sua preferência
- Gerar build do docker do frontend com endereço do gcloud. ex: 
`docker build -t gcr.io/PROJECT_ID/PROJECT_NAME .` 
onde PROJECT_ID você pega do console do GCP e PROJECT_NAME pode-se escolher de sua preferência
- Subir docker image para Google Cloud:
`docker push gcr.io/PROJECT_ID/PROJECT_NAME`

## Como Rodar
### Passo 1
`cp terraform.tfvars.example staging/terraform.tfvars && cp terraform.tfvars.example production/terraform.tfvars`

### Passo 2
- `terraform init`
- `terraform apply`

## Tecnologias

- Cloud Run - NestJs (GCP)
- Cloud Run - Next.js (GCP)
- Cloud Storage (GCP)
- Cloud SQL - Postgres (GCP)
- Firestore (GCP)
- Cache - Redia (GCP)