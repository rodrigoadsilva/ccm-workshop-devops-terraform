# Lab 2 — Variáveis e outputs

**Objetivo:** personalizar uma página web sem mexer no código principal, só mudando valores.
**Tempo:** 15 minutos.

> Antes de começar: confirme que você rodou o `terraform destroy` no final do Lab 1. Os dois labs usam a porta 8080.

---

## Passo 1 — Entre na pasta do lab

```bash
cd /workspaces/*/labs/02-variaveis
```

## Passo 2 — Conheça os arquivos

Desta vez, o código está dividido em quatro arquivos. O Terraform lê todos juntos, como se fossem um só.

| Arquivo | Para que serve |
|---|---|
| `main.tf` | Os recursos: a imagem e o container do Nginx |
| `variables.tf` | As **variáveis**: os valores que podem ser escolhidos por quem usa o código |
| `terraform.tfvars` | Os **valores** das variáveis |
| `outputs.tf` | Os **outputs**: informações exibidas ao final do `apply` |

Abra o `variables.tf`. Repare que existem duas variáveis:

- `mensagem`, **sem** valor padrão: é obrigatória, e o valor vem do `terraform.tfvars`;
- `cor_fundo`, **com** valor padrão `white`: só muda se alguém informar outro valor.

## Passo 3 — Suba a página

```bash
terraform init
terraform apply
```

Digite `yes` para confirmar.

✅ **Esperado:** no final, os **outputs** aparecem:

```
Outputs:

cor_usada = "white"
nome_container = "nginx-lab2"
```

Agora abra a página: aba **Ports** → linha **Nginx do lab** → ícone de globo 🌐.

✅ **Esperado:** uma página branca com **"Olá, Workshop de DevOps!"**

## Passo 4 — Personalize pelo `terraform.tfvars`

Abra o `terraform.tfvars` e deixe assim, colocando o seu nome:

```hcl
mensagem  = "Olá, eu sou Seu Nome!"
cor_fundo = "lightblue"
```

Salve (`Ctrl+S`) e veja o plano:

```bash
terraform plan
```

Repare no sinal `-/+`: o Terraform vai **destruir e recriar** o container, porque o conteúdo da página faz parte da criação dele.

Agora aplique:

```bash
terraform apply
```

Atualize a aba da página no navegador (`F5`).

✅ **Esperado:** fundo azul-claro e a sua mensagem. Você mudou a página **sem tocar no `main.tf`**.

🙋 **Chegou aqui? Levante a mão (ou reaja no chat)!**

## Passo 5 — Mude pela linha de comando

Valores passados com `-var` têm **prioridade** sobre o `terraform.tfvars`:

```bash
terraform apply -var="cor_fundo=pink"
```

Atualize a página.

✅ **Esperado:** fundo rosa, mesmo com o `terraform.tfvars` dizendo `lightblue`.

Esse é o mesmo mecanismo usado no dia a dia para criar ambientes diferentes (desenvolvimento, produção) com o **mesmo código**.

## Passo 6 — Consulte os outputs

Os outputs podem ser consultados a qualquer momento:

```bash
terraform output
```

✅ **Esperado:** `cor_usada = "pink"`

## Passo 7 — Remova tudo

```bash
terraform destroy
```

Digite `yes` para confirmar.

---

## Algo deu errado?

| Mensagem ou sintoma | O que fazer |
|---|---|
| `port is already allocated` | O container do Lab 1 ainda existe. Rode `docker rm -f meu-nginx` e repita o `apply`. |
| O Terraform pede `var.mensagem` no terminal | O arquivo `terraform.tfvars` não foi salvo ou a linha `mensagem` está comentada. Confira e salve. |
| A página não mudou | Atualize com `F5`. Se continuar igual, confira se o `apply` terminou com `Apply complete!`. |
| A cor não aparece | Use nomes de cores em inglês, como `lightblue`, `pink`, `lightgreen` ou `yellow`. |
| A porta 8080 não aparece na aba Ports | Clique em **Forward a Port** e digite `8080`. |

Se nada disso resolver, chame um dos ajudantes.
