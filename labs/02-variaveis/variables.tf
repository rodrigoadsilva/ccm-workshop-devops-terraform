# Variáveis: as "entradas" do código.
# Quem usa o código escolhe os valores, sem precisar editar o main.tf.

# Sem default: a variável é obrigatória.
# O valor vem do arquivo terraform.tfvars.
variable "mensagem" {
  description = "Mensagem exibida na página"
  type        = string
}

# Com default: se ninguém informar outro valor, usa "white".
variable "cor_fundo" {
  description = "Cor de fundo da página (em inglês, como white, lightblue, pink)"
  type        = string
  default     = "white"
}
