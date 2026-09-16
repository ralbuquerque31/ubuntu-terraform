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



Para sincronizar esse ambiente entre seus computadores e rodá-lo rapidamente em qualquer máquina com Docker instalado, o ideal é versionar os arquivos de configuração e garantir que arquivos temporários ou de estado do Terraform não sejam enviados ao repositório.1.Criar o arquivo .gitignore:Evita o envio de segredos e arquivos de estado do Terraform.Crie um arquivo chamado .gitignore dentro da pasta do projeto para evitar o versionamento do diretório .terraform e dos arquivos de estado (.tfstate):gitignore# Terraform local state and modules
.terraform/
*.tfstate
*.tfstate.backup
*.tfvars
*.tfplan
crash.log

# Sistema e IDEs
.DS_Store
.vscode/
.idea/
*.swp
2.Inicializar e registrar os arquivos no Git:No terminal da pasta do seu projeto, execute o versionamento inicial dos arquivos de infraestrutura (Dockerfile, docker-compose.yml e .gitignore):Bashgit init
git add Dockerfile docker-compose.yml .gitignore
git commit -m "feat: ambiente docker lab para terraform no ubuntu"

3.Publicar o repositório no GitHub ou GitLab:Crie um novo repositório no seu provedor de preferência (público ou privado) e conecte seu código local a ele:Bashgit branch -M main
git remote add origin https://github.com/ralbuquerque31/ubuntu-terraform.git
git push -u origin main

4.Abrir o ambiente em outro computador ou notebook:Em qualquer outra máquina com Git e Docker instalados, basta clonar o projeto e subir o container:Bashgit clone https://github.com/ralbuquerque31/ubuntu-terraform.git
cd SEU_REPOSITORIO
docker compose up -d --build
docker compose exec terraform-lab bash


O erro ocorreu por dois motivos: o GitHub desativou a autenticação por senha tradicional via HTTPS em 2021 (exigindo um Personal Access Token ou Chave SSH) e a URL origin já ficou salva na primeira tentativa.

Escolha uma das duas soluções abaixo para ajustar e concluir o envio:

Opção 1: Usar Personal Access Token (PAT) via HTTPS (Mais rápida)
Gerar o Token no GitHub:

Acesse GitHub.com > Clique na sua foto de perfil (canto superior direito) > Settings.

No menu esquerdo, vá ao final em Developer Settings > Personal access tokens > Tokens (classic).

Clique em Generate new token (classic).

Defina um nome (ex: hml-docker01), marque a caixinha repo (acesso completo aos repositórios) e clique em Generate token.

Copie o token gerado (ele só é exibido uma vez, parece com ghp_xxxxxxx...).

Fazer o Push usando o Token:
No terminal do servidor, execute o push novamente:

Bash
git push -u origin main
Username: ralbuquerque31

Password: Cole o Token gerado (não digite sua senha da conta).

git push -u origin main --force
