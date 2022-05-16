variable "image_id" {
  #Ubuntu 20 on JS2
  default = "a49148ce-f119-4180-b913-009546052f18"
  description = "The id of the image from Jetstream 2"
}

variable "flavor_id" {
  default = "3"
  description = "Flavor of VM on Jetstream 2"
}

variable "key_pair" {
  default = ""
}

variable "email" {
  default = ""
}

variable "domain_name" {
  default = ""
}
