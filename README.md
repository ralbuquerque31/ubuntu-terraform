Para subir um container Ubuntu no Docker mantendo seus arquivos salvos no sistema hospedeiro (host), siga o procedimento abaixo.

**1. Iniciar o container mapeando um diretório local**

Crie uma pasta no seu Linux para guardar seus códigos `.tf` e suba o container Ubuntu interativo:

```bash
mkdir -p ~/terraform-lab && cd ~/terraform-lab
docker run -it --name ubuntu-terraform -v $(pwd):/app -w /app ubuntu:latest bash

```

**2. Instalar dependências e o repositório da HashiCorp**

Dentro do terminal do container Ubuntu, atualize o gerenciador de pacotes e adicione a chave GPG do Terraform:

```bash
apt update && apt install -y curl gnupg lsb-release

curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list

```

**3. Instalar e verificar o Terraform**

Atualize a lista de pacotes e faça a instalação:

```bash
apt update && apt install -y terraform
terraform -v

```

---

**Gerenciamento do container no dia a dia**

* **Sair do container:** digite `exit`.
* **Voltar a acessar o container com tudo instalado:** `docker start -ai ubuntu-terraform`
* **Remover o container se precisar recriar:** `docker rm -f ubuntu-terraform` (seus arquivos `.tf` na pasta `~/terraform-lab` do Linux não serão apagados).
