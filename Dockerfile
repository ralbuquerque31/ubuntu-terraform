FROM ubuntu:24.04

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
