# Lab 1 — Seu primeiro `terraform apply`

**Objetivo:** subir um servidor web (Nginx) usando apenas código, e depois removê-lo.
**Tempo:** 15 minutos.

> Dica: para colar no terminal do navegador, use `Ctrl+Shift+V` (ou clique com o botão direito e escolha *Paste*).

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

O Terraform mostra o que **faria**, sem fazer nada ainda. O sinal `+` significa "criar".

✅ **Esperado:** `Plan: 2 to add, 0 to change, 0 to destroy.`

## Passo 5 — Aplique

```bash
terraform apply
```

Ele mostra o plano de novo e pergunta se você confirma. Digite `yes` e pressione Enter.

✅ **Esperado:** `Apply complete! Resources: 2 added, 0 changed, 0 destroyed.`

## Passo 6 — Abra o site

1. Clique na aba **Ports**, ao lado do terminal.
2. Na linha da porta **8080**, clique no ícone de globo 🌐.

✅ **Esperado:** uma nova aba com a página **"Welcome to nginx!"**

🙋 **Chegou aqui? Levante a mão (ou reaja no chat)!**

## Passo 7 — Desafio: o que acontece se eu mudar o código?

1. No `main.tf`, troque `external = 8080` por `external = 8081` e salve (`Ctrl+S`).
2. Rode:

```bash
terraform plan
```

Repare no sinal `-/+`: o Terraform precisa **destruir e recriar** o container, porque a porta não pode ser trocada com ele rodando.

3. Volte o valor para `8080` e salve. Não precisa aplicar.

## Passo 8 — Remova tudo

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
| `port is already allocated` | Outro container está usando a porta. Rode `docker rm -f meu-nginx` e repita o `apply`. |
| A porta 8080 não aparece na aba Ports | Clique em **Forward a Port** e digite `8080`. |
| O terminal não aceita colar | Use `Ctrl+Shift+V` ou o botão direito do mouse. |

Se nada disso resolver, chame um dos ajudantes.