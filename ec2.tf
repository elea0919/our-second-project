# Fetch the latest Amazon Linux AMI (accessible globally)
data "aws_ami" "latest_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}

resource "aws_instance" "group_1_instance" {
  ami                    = data.aws_ami.latest_linux.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet_1.id
  vpc_security_group_ids = [aws_security_group.group_1_sg.id]
  key_name               = aws_key_pair.group_1_key.key_name

  tags = {
     Name = "group-1" }


#   # Run Ansible after instance is provisioned
#   provisioner "local-exec" {
#     command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${self.public_ip},' ansible/jenkins.yaml"
#   }
 }

# Generate SSH key pair for passwordless SSH
resource "aws_key_pair" "group_1_key" {
  key_name   = "group-1-key"
  public_key = file("~/.ssh/id_rsa.pub")
}


output "ec2_public_ip" {
  value = aws_instance.group_1_instance.public_ip
}