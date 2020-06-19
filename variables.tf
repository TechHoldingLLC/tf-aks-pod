variable "name" {
  type = string
}

variable "versions" {
  type = map(object({
    replicas = number
    ports = object({
      container = number
      service   = number
    })
    img_version = string
    img_env     = object({})
  }))
}

variable "image" {
  type = string
}

variable "image_pull_policy" {
  type    = string
  default = "Always"
}
