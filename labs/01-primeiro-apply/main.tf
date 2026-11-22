# Bloco terraform: declara quais providers este código usa e de onde eles vêm.
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# Provider: o "tradutor" que conversa com a API do Docker.
provider "docker" {}

# Resource 1: a imagem do Nginx, baixada do Docker Hub.
# A versão é fixa (1.27) para que todos tenham exatamente o mesmo resultado.
resource "docker_image" "nginx" {
  name = "nginx:1.27"
}

# Resource 2: o container que roda a imagem.
# Como ele referencia docker_image.nginx, o Terraform cria a imagem primeiro.
resource "docker_container" "web" {
  name  = "meu-nginx"
  image = docker_image.nginx.image_id

  # Liga a porta 80 do container à porta 8080 do Codespace.
  ports {
    internal = 80
    external = 8080
  }
}