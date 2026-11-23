terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:1.27"
  keep_locally = true
}

resource "docker_container" "web" {
  name  = "nginx-lab3"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = 8080
  }

  upload {
    content = <<-EOT
      <!DOCTYPE html>
      <html>
        <head><meta charset="utf-8"><title>Lab 3</title></head>
        <body style="font-family: sans-serif; text-align: center; padding-top: 80px;">
          <h1>Este site é gerenciado pelo Terraform</h1>
          <p>Se alguém apagá-lo por fora, o Terraform percebe.</p>
        </body>
      </html>
    EOT
    file    = "/usr/share/nginx/html/index.html"
  }
}
