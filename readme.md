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
`cp terraform.tfvars.example terraform.tfvars`
ou
copia o conteúdo de terraform.tfvars.example e cria um arquivo terraform.tfvars e cola o conteúdo

### Passo 2
Preencha o arquivo terraform.tfvars criado com as informações necessárias, no arquivo vai ter exemplos para faciliar o entendimento, mas caso uma descrição de cada variável acesse o arquivo variables.tf

### Passo 3
Este repositório trabalha com a ideia de workspaces, para funcionar com todos os recursos crie um workspace de staging e prod, como no exemplo a seguir:
- `terraform workspace new prd`
- `terraform workspace new stg`

se quiser selecionar um workspace:
`terraform workspace select stg` onde stg é o workspace que quer selecionar 

se quiser listar os workspaces:
`terraform workspace list`

se quiser excluir um workspace:
`terraform workspace delete stg` onde stg é o workspace que quer deletar

### Passo 4
- `terraform init`
- `terraform apply`

## Tecnologias

- Cloud Run - NestJs (GCP)
- Cloud Run - Next.js (GCP)
- Cloud Storage (GCP)
- Cloud SQL - Postgres (GCP)
- Firestore (GCP)
- Cache - Redia (GCP)