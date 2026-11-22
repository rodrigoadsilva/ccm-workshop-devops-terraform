# Lab 1 — Seu primeiro `terraform apply`

**Objetivo:** subir um servidor web (Nginx) usando apenas código, e depois removê-lo.
**Tempo:** 15 a 20 minutos.

> Dica: para colar no terminal do navegador, use `Ctrl+Shift+V` (ou clique com o botão direito e escolha *Paste*).

## O contexto

Você herdou o código desta pasta de um colega. Ele o escreveu há alguns anos, e na época tudo funcionava perfeitamente. Vamos ver se ainda funciona.

---

## Passo 1 — Entre na pasta do lab

No terminal, na parte de baixo da tela, rode:

```bash
cd labs/01-primeiro-apply
```

## Passo 2 — Leia o código

Abra o arquivo `main.tf` no explorador à esquerda. Ele tem só dois recursos:

- uma **imagem** do Nginx;
- um **container** que roda essa imagem na porta 8080.

Repare: o código não diz *como* criar nada, só *o que* queremos ter.

## Passo 3 — Inicialize o projeto

```bash
terraform init
```

O Terraform baixa o provider do Docker.

✅ **Esperado:** `Terraform has been successfully initialized!`

## Passo 4 — Veja o plano

```bash
terraform plan
```

❌ **Esperado: um erro!** Algo como:

```
Error: Unsupported attribute
...
This object has no argument, nested block, or exported attribute named "latest".
```

**Calma: esse erro faz parte do lab.**

## Passo 5 — Entenda o que aconteceu

Ninguém mexeu no código, e mesmo assim ele quebrou. Por quê?

1. O `terraform init` baixou a **versão mais recente** do provider do Docker, porque o código não diz qual versão usar.
2. O código foi escrito para uma **versão antiga** do provider, em que a imagem tinha um atributo chamado `latest`.
3. Na versão 3 do provider, esse atributo foi **removido** e substituído por `image_id`.

Repare no comentário do `main.tf`: o colega teve o cuidado de fixar a versão da **imagem** (`nginx:1.27`), mas esqueceu de fixar a versão do **provider**.

**Lição:** tudo o que não tem versão fixa pode mudar sem aviso.

## Passo 6 — Corrija o código

Faça duas alterações no `main.tf`:

**1.** No bloco `required_providers`, adicione a linha `version`:

```hcl
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
```

O `~> 3.0` significa "qualquer versão 3.x, mas nunca a 4". Assim, correções chegam, mas mudanças incompatíveis não.

**2.** No recurso `docker_container`, troque `.latest` por `.image_id`:

```hcl
  image = docker_image.nginx.image_id
```

Salve o arquivo (`Ctrl+S`) e rode:

```bash
terraform init -upgrade
terraform plan
```

O `-upgrade` faz o Terraform reavaliar a versão do provider de acordo com a regra que você acabou de escrever.

✅ **Esperado:** `Plan: 2 to add, 0 to change, 0 to destroy.`

O sinal `+` significa "criar". O Terraform mostra o que **faria**, sem fazer nada ainda.

## Passo 7 — Aplique

```bash
terraform apply
```

Ele mostra o plano de novo e pergunta se você confirma. Digite `yes` e pressione Enter.

✅ **Esperado:** `Apply complete! Resources: 2 added, 0 changed, 0 destroyed.`

## Passo 8 — Abra o site

1. Clique na aba **Ports**, ao lado do terminal.
2. Na linha **Nginx do lab** (porta 8080), clique no ícone de globo 🌐.

✅ **Esperado:** uma nova aba com a página **"Welcome to nginx!"**

🙋 **Chegou aqui? Levante a mão (ou reaja no chat)!**

## Passo 9 — Remova tudo

```bash
terraform destroy
```

Digite `yes` para confirmar.

✅ **Esperado:** `Destroy complete! Resources: 2 destroyed.`

---

## Algo deu errado?

| Mensagem ou sintoma | O que fazer |
|---|---|
| `No such file or directory` no `cd` | Rode `cd /workspaces/*/labs/01-primeiro-apply` |
| `Required plugins are not installed` ou `Inconsistent dependency lock file` | Você pulou o `terraform init`. Rode-o agora. |
| O erro do `latest` continua depois da correção | Confira se salvou o arquivo (`Ctrl+S`) e se trocou `.latest` por `.image_id` na linha `image =`. |
| `locked provider ... does not match configured version constraint` | Rode `terraform init -upgrade`. |
| `port is already allocated` | Outro container está usando a porta. Rode `docker rm -f meu-nginx` e repita o `apply`. |
| A porta 8080 não aparece na aba Ports | Clique em **Forward a Port** e digite `8080`. |
| O terminal não aceita colar | Use `Ctrl+Shift+V` ou o botão direito do mouse. |

Se nada disso resolver, chame um dos ajudantes.