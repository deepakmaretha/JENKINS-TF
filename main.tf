#Creating a new EC2 Machine

resource "aws_instance" "Web" {
  depends_on     = [aws_key_pair.kp]
  ami            = "ami-0607784b46cbe5816" #AMAZON AMI
  instance_type  = "t2.micro" #FREETIER

  tags = {
    Name = "JENKINS by Terraform"
  }

  security_groups = ["JENKINS"]
  key_name        = aws_key_pair.kp.key_name

  user_data = data.template_file.jenkins_user_data.rendered
}

# Outputting the initial default password of Jenkins

resource "null_resource" "wait" {
  provisioner "local-exec" {
    command = "sleep 180"
  }
  
}

resource "null_resource" "jenkins_password" {

  depends_on = [ null_resource.wait ]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_key.jenkins.private_key_pem
    host        = aws_instance.Web.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "echo UNLOCK JENKINS USING BELOW MENTIONED PASSWORD",
      "sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
    ]
  }
}
