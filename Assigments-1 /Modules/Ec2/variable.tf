variable "ami_id" { 
    type = string 
    }
variable "instance_type" {
     type = string 
     }
variable "key_name" {
     type = string 
     }
variable "key_path" {
     type = string 
     }
variable "public_key_path" { type = string }
variable "security_group_ids" { type = list(string) }
variable "iam_instance_profile" { type = string }
variable "file_source" { type = string }
variable "file_destination" { type = string }
variable "bucket_name" { type = string }
