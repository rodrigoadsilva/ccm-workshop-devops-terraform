# Lab 3 — O state e o drift

**Objetivo:** ver como o Terraform sabe o que criou, e o que acontece quando alguém muda a infraestrutura "por fora".
**Tempo:** 15 minutos.

> Antes de começar: confirme que você rodou o `terraform destroy` no final do Lab 2. Os labs usam a mesma porta 8080.

---

## Passo 1 — Entre na pasta e suba o site

```bash
cd /workspaces/*/labs/03-state
terraform init
terraform apply
```

Digite `yes` para confirmar. Depois, abra a página: aba **Ports** → linha **Nginx do lab** → ícone de globo 🌐.

✅ **Esperado:** a página **"Este site é gerenciado pelo Terraform"**. Deixe essa aba aberta.

## Passo 2 — Veja o que o Terraform sabe

O Terraform guarda tudo o que criou num arquivo chamado **state**. Para listar o que está nele:

```bash
terraform state list
```

✅ **Esperado:**

```
docker_container.web
docker_image.nginx
```

Agora veja os detalhes do container:

```bash
terraform state show docker_container.web
```

Procure as linhas `id` e `name`. O `id` é o identificador real do container no Docker: é assim que o Terraform liga o recurso do código ao container que existe de verdade.

Repare no explorador à esquerda: apareceu um arquivo `terraform.tfstate`, com o nome **apagado**. Isso significa que ele está no `.gitignore` e nunca vai para o Git, porque o state pode conter informações sensíveis.

## Passo 3 — Simule um colega apressado

Imagine que um colega, tentando resolver um problema às pressas, apagou o container direto pelo Docker, sem passar pelo Terraform:

```bash
docker rm -f nginx-lab3
```

Atualize a aba da página (`F5`).

✅ **Esperado:** a página não carrega mais. O site saiu do ar.

A realidade agora é diferente do que está no código. Isso se chama **drift**.

## Passo 4 — Pergunte ao Terraform

```bash
terraform plan
```

✅ **Esperado:** `Plan: 1 to add, 0 to change, 0 to destroy.`

Antes de planejar, o Terraform **comparou o state com a realidade** e percebeu que o container sumiu. Ninguém precisou avisá-lo. Repare também que só o container será recriado: a imagem continua lá.

## Passo 5 — Restaure o estado desejado

```bash
terraform apply
```

Digite `yes` e atualize a página (`F5`).

✅ **Esperado:** o site está de volta.

🙋 **Chegou aqui? Levante a mão (ou reaja no chat)!**

O código é a **fonte da verdade**: o Terraform sempre leva a realidade de volta ao que está escrito.

## Passo 6 — Para pensar

E se a mudança do colega fosse a **correta**, uma correção urgente de verdade? O próximo `apply` a teria desfeito do mesmo jeito.

Por isso, em equipes que usam Terraform, **toda mudança passa pelo código**. Mudanças feitas por fora são esquecidas ou, pior, desfeitas sem ninguém perceber.

## Passo 7 — Remova tudo

```bash
terraform destroy
```

Digite `yes` para confirmar.

---

## Algo deu errado?

| Mensagem ou sintoma | O que fazer |
|---|---|
| `port is already allocated` | Um container de outro lab ainda existe. Rode `docker rm -f meu-nginx nginx-lab2` e repita o `apply`. |
| `No such container` no Passo 3 | Confira se digitou o nome exatamente como `nginx-lab3`. |
| O `plan` do Passo 4 mostra `No changes` | O container não foi apagado. Rode `docker ps` para conferir e repita o Passo 3. |
| A página não volta no Passo 5 | Confira se o `apply` terminou com `Apply complete!` e atualize com `F5`. |
| A porta 8080 não aparece na aba Ports | Clique em **Forward a Port** e digite `8080`. |

Se nada disso resolver, chame um dos ajudantes.
