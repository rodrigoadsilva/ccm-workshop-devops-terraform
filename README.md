# Workshop DevOps — Terraform na prática

Neste workshop, você vai criar, alterar e destruir infraestrutura usando apenas código, com o Terraform. Tudo roda no navegador: não é preciso instalar nada no seu computador.

## Antes do workshop

Você só precisa de duas coisas:

- **Uma conta pessoal no GitHub.** Se ainda não tem, crie em [github.com/signup](https://github.com/signup). É gratuito.
- **Um navegador atualizado**, de preferência Chrome ou Edge.

## Criando o seu ambiente

1. Entre na sua conta do GitHub.
2. Clique no botão abaixo:

   [![Abrir no GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/rodrigoadsilva/ccm-workshop-devops-terraform?quickstart=1)

3. Na página que abrir, clique em **Create codespace**.
4. Aguarde. A primeira criação leva de **2 a 5 minutos**. Enquanto isso, acompanhe a apresentação.

Quando o ambiente ficar pronto, você verá um editor de código no navegador, com o guia do Lab 1 aberto e um terminal na parte de baixo da tela.

> Se o botão não funcionar: nesta página, clique no botão verde **Code**, depois na aba **Codespaces** e em **Create codespace on main**.

## Os labs

Cada lab tem um guia (`README.md`) com todos os passos e os resultados esperados. Faça na ordem:

| Lab | O que você vai fazer |
|---|---|
| [Lab 1 — Seu primeiro `terraform apply`](labs/01-primeiro-apply/README.md) | Subir um servidor web com código e descobrir por que versionar importa |
| [Lab 2 — Variáveis e outputs](labs/02-variaveis/README.md) | Personalizar uma página sem mexer no código principal |
| [Lab 3 — O state e o drift](labs/03-state/README.md) | Ver o Terraform perceber e corrigir uma mudança feita "por fora" |

Para ler um guia formatado dentro do Codespace, clique com o botão direito no arquivo `README.md` e escolha **Open Preview**.

## Quanto custa?

Nada. Contas pessoais do GitHub têm uma cota gratuita mensal de Codespaces, e o workshop usa só uma pequena parte dela.

## Ao terminar

Apague o seu Codespace para não consumir a cota gratuita:

1. Acesse [github.com/codespaces](https://github.com/codespaces).
2. No menu `...` ao lado do Codespace do workshop, clique em **Delete**.

## Precisa de ajuda?

Durante o workshop, levante a mão na call ou indique para o ajudante na sala. Cada guia também tem, no final, uma tabela com os problemas mais comuns e como resolvê-los.
