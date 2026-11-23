terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

# Local: um valor calculado dentro do código, a partir das variáveis.
# Aqui, montamos o HTML da página com a mensagem e a cor escolhidas.
locals {
  pagina_html = <<-EOT
    <!DOCTYPE html>
    <html>
      <head><meta charset="utf-8"><title>Lab 2</title></head>
      <body style="background-color: ${var.cor_fundo}; font-family: sans-serif; text-align: center; padding-top: 80px;">
        <h1>${var.mensagem}</h1>
        <p>Página criada com Terraform</p>
      </body>
    </html>
  EOT
}

resource "docker_image" "nginx" {
  name         = "nginx:1.27"
  keep_locally = true
}

resource "docker_container" "web" {
  name  = "nginx-lab2"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = 8080
  }

  # Coloca a nossa página no lugar da página padrão do Nginx.
  upload {
    content = local.pagina_html
    file    = "/usr/share/nginx/html/index.html"
  }
}