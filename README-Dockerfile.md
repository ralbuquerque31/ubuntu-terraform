1. Dockerfile

Crie o arquivo Dockerfile no mesmo diretório do seu projeto:

Dockerfile
FROM ubuntu:latest

# Evita interrupções interativas durante a instalação de pacotes
ENV DEBIAN_FRONTEND=noninteractive

# Instala pacotes essenciais
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    lsb-release \
    ca-certificates \
    git \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Adiciona a chave GPG e repositório oficial da HashiCorp
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list

# Instala o Terraform
RUN apt-get update && apt-get install -y terraform \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

CMD ["/bin/bash"]
2. docker-compose.yml

Crie o arquivo docker-compose.yml na mesma pasta:

YAML
services:
  terraform-lab:
    build: .
    container_name: ubuntu-terraform
    volumes:
      - .:/app
    stdin_open: true # Mantém a sessão STDIN aberta (-i)
    tty: true        # Aloca um pseudo-TTY (-t)
    working_dir: /app
Comandos para gerenciar o ambiente

Construir a imagem e iniciar o container:

Bash
docker compose up -d --build
Acessar o terminal do container:

Bash
docker compose exec terraform-lab bash
Parar o container sem apagar os arquivos locais:

Bash
docker compose down
