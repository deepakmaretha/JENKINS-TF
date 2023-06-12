resource "tls_private_key" "jenkins" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp" {
    depends_on = [ tls_private_key.jenkins ]
  key_name   = "jenkins"       # Create a "myKey" to AWS!!
  public_key = tls_private_key.jenkins.public_key_openssh

}

resource "null_resource" "pem_file" {
    depends_on = [ aws_key_pair.kp ]
  provisioner "local-exec" { # Create a "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.jenkins.private_key_pem}' > ./jenkins.pem"
  }
}

resource "null_resource" "change_pem_permissions" {
  depends_on = [ null_resource.pem_file ]
  provisioner "local-exec" { #Changin the pem file permission as 400!!
    command = "chmod 400 ./jenkins.pem"
  }
}