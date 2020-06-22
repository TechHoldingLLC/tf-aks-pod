variable "name" {
  type = string
}

variable "versions" {
  type = map(object({
    img_version = string
    replicas    = number
    envvars     = map(string)
    secrets     = map(map(string))
    ports = object({
      container = number
      service   = number
    })
  }))
}

variable "image" {
  type = string
}

variable "image_pull_policy" {
  type    = string
  default = "Always"
}
