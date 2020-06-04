variable "name" {
  type = string
}
variable "replicas" {
  type    = number
  default = 1
}
variable "ports" {
  type = object({
    container = number
    service   = number
  })
  default = {
    container = 8080
    service   = 80
  }
}
variable "image" {
  type = string
}
variable "image_pull_policy" {
  type    = string
  default = "IfNotPresent"
}
variable "image_env" {
  type = object({})
}
