## How to use the module
```hcl
module "my_k8s_pod" {
  source = "github.com/TechHoldingLLC/tf-aks-pod?ref=v1.2.0"

  name              = var.images.helloworld.name
  image             = var.images.helloworld.image
  image_pull_policy = var.env == "prod" ? "IfNotPresent" : "Always"
  versions          = var.images.helloworld.versions
}
```

## Variable used for the module
```hcl
images = {
  helloworld = {
    name = "helloworld"
    image = "hello-world"
    versions = {
      v1 = {
        img_version = "v1.1"
        replicas = 1
        envvars = {
          APP_VERSION = 1
        }
        secrets = {}
        ports = {
          container = 8080
          service = 80
        }
      }
      v2 = {
        img_version = "v2"
        replicas = 2
        envvars = {
          TEST = true
          APP_VERSION = 2
        }
        secrets = {
          SECRET_WORD = {
            name = "my-aks-secret"
            key = "word"
          }
        }
        ports = {
          container = 5000
          service = 80
        }
      }
    }
  }
}
```

A PORT env is automatically added based on the ports.container value
