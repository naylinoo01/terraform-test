resource "aws_instance" "example" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  tags = {
    Name          = "example"
    Created_by    = "Nay Lin Oo"
    Environment   = "Production"
    Controlled_by = "terraform"
  }


  # the VPC subnet
  subnet_id = aws_subnet.prodvpc-public-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name

}  

