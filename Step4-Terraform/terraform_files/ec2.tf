resource "aws_instance" "web" {
  ami                    = "ami-0bbdd8c17ed981ef9"
  key_name               = aws_key_pair.deployer.key_name
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  tags = local.common_tags

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install -y apache2
    sudo systemctl enable apache2
    sudo systemctl start apache2
    echo "<h1>Hello from Terraform!</h1>" > /var/www/html/index.html
  EOF

}

output "ec2" {
  value = aws_instance.web.public_ip
}