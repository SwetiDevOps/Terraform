# S3 bucket
module "s3" {
  source          = "./modules/s3"
  bucket_name     = var.bucket_name
  lifecycle_days1 = var.lifecycle_days1
  lifecycle_days2 = var.lifecycle_days2
  expiration_days = var.expiration_days
}

#IAM
module "iam" {
  source      = "./modules/iam"
  bucket_name = var.bucket_name
}

# Security Group
module "sg" {
  source = "./modules/security_group"
}

#EC2 instance
module "ec2" {
  source             = "./modules/ec2"
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  key_name           = var.key_name
  key_path           = var.key_path
  public_key_path    = var.public_key_path
  security_group_ids = [module.sg.sg_id]
  iam_instance_profile = module.iam.instance_profile
  file_source        = var.file_source
  file_destination   = var.file_destination
  bucket_name        = var.bucket_name
}
