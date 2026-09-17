

```markdown
# Terraform Lab - Ubuntu Docker Environment

Ambiente automatizado via Docker Compose para estudos e testes com Terraform rodando em um container Ubuntu.

---

## 📋 Pré-requisitos

* **Docker** instalado e em execução.
* **Docker Compose** (plugin `docker compose` v2+).
* **Git** instalado na máquina hospedeira.

---

## 🚀 Passo a Passo para Instalação

### 1. Criar o diretório de trabalho e clonar o repositório

Abra o terminal do Linux (ou WSL) e execute os comandos para criar a pasta em `/opt/docker/terraform-lab` e clonar o projeto:

```bash
# Cria o diretório e acessa a pasta
sudo mkdir -p /opt/docker/terraform-lab
cd /opt/docker/terraform-lab

# Clona o repositório no diretório atual
sudo git clone [https://github.com/ralbuquerque31/ubuntu-terraform.git](https://github.com/ralbuquerque31/ubuntu-terraform.git) .

```

---

### 2. Subir o ambiente com Docker Compose

Construa a imagem e inicie o container em segundo plano:

```bash
docker compose up -d --build

```

> **Verificação:** Para conferir se o container está rodando, execute `docker compose ps`.

---

### 3. Acessar o terminal do container

Acesse a sessão interativa dentro do Ubuntu com todas as dependências do Terraform instaladas:

```bash
docker compose exec terraform-lab bash

```

Dentro do container, confirme se a instalação do Terraform foi concluída com sucesso:

```bash
terraform -v

```

---

## 🛠️ Comandos Úteis do Dia a Dia

* **Sair do container:** Digite `exit` no terminal interativo.
* **Parar o ambiente:** `docker compose down` (seus arquivos e códigos `.tf` criados na pasta permanecerão salvos).
* **Reiniciar o ambiente:** `docker compose restart`
* **Reconstruir a imagem (sem usar cache):** `docker compose build --no-cache`

```

```
