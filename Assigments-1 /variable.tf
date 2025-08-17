variable "bucket_name" {
  type = string
}

variable "lifecycle_days1" {
  type    = number
  default = 30
}

variable "lifecycle_days2" {
  type    = number
  default = 90
}

variable "expiration_days" {
  type    = number
  default = 365
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type = string
}

variable "key_path" {
  type = string
}

variable "public_key_path" {
  type = string
}

variable "file_source" {
  type = string
}

variable "file_destination" {
  type    = string
  default = "/home/ubuntu/sweti.pdf"
}
