
resource "aws_key_pair" "example" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "aws_instance" "ec2_with_awscli" {
  ami           = var.ami_id          # Example: "ami-0c02fb55956c7d316" (Amazon Linux 2)
  instance_type = var.instance_type   # Example: "t2.micro"
  key_name               = aws_key_pair.example.key_name
  iam_instance_profile   = var.iam_instance_profile
  vpc_security_group_ids = var.security_group_ids

  user_data = <<-EOF
              #!/bin/bash
                sudo apt update -y
                sudo apt install -y unzip curl
                curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
                unzip awscliv2.zip
                sudo ./aws/install
                rm -rf awscliv2.zip aws
                aws --version
                EOF
  tags = {
    Name = "infosysTest_2"
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"              # Replace with the appropriate username for your EC2 instance
    private_key = file(var.key_path) # Replace with the path to your private key
    host        = self.public_ip
  }

}

# -------------------- Always-run Upload --------------------
  
resource "null_resource" "upload_file" {
  triggers = {
    always_run = timestamp()
  }

  # Define connection once at the resource level
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.key_path) # or var.key_path
    host        = aws_instance.ec2_with_awscli.public_ip
  }

  # Copy file to EC2 each apply
  provisioner "file" {
    source      = var.file_source
    destination = var.file_destination
  }

  # Upload file to S3
  provisioner "remote-exec" {
    inline = [
      "aws s3 cp ${var.file_destination} s3://${var.bucket_name}/"
    ]
  }
}


