variable "folder" {
  type = string
  description = "YC folder id"
  default = "b1gts9m60ogqg42vocdj"
}

variable "cloud" {
  type = string
  description = "YC cloud id"
  default = "b1g4bbs8vqoial0me098"
}

variable "zonea" {
  type = string
  description = "YC zone A name"
  default = "ru-central1-a"
}

variable "ssh_key_private" {
  type = string
  description = "Private key"
  default = "keys/id_ed25519"
}

variable "ssh_user" {
  type = object({
    name = string
    private_key = string
    pub_key = string
  })

  default = {
    name = "sennin"
    private_key = "keys/id_ed25519"
    pub_key = "keys/id_ed25519.pub"
  }
}