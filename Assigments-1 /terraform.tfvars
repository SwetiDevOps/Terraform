bucket_name     = "my-migration-bucket-12345"
lifecycle_days1 = 30
lifecycle_days2 = 90
expiration_days = 365

ami_id      = "ami-0261755bbcb8c4a84"
instance_type = "t2.micro"

key_name        = "id_rsa"
key_path        = "~/.ssh/id_rsa"
public_key_path = "~/.ssh/id_rsa.pub"

file_source      = "C:/Users/sweti/Infofile/sweti.pdf"
file_destination = "/home/ubuntu/sweti.pdf"

