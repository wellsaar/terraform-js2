variable "image_id" {
  default = "8f27559a-9e63-4fb7-9704-09526793e2d2"
  description = "The id of the image from Jetstream"
}

variable "flavor_id" {
  default = "3"
  description = "Flavor of VM on Jetstream"
}

variable "key_pair" {
  default = ""
}

variable "email" {
  default = ""
}
