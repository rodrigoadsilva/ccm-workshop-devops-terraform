# Outputs: as "saídas" do código, exibidas ao final do apply.

output "nome_container" {
  description = "Nome do container criado"
  value       = docker_container.web.name
}

output "cor_usada" {
  description = "Cor de fundo aplicada na página"
  value       = var.cor_fundo
}
