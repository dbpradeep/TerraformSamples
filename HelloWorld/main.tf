variable "name" {
  description = "Name to say hello to"
  type        = string
  default     = "World"
}

output "message" {
  value = "Hello, ${var.name}!"
}
