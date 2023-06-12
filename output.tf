output "Name" {
  value = "JENKINS"

}

output "configuration" {
  value = "JENKINS Server has bees Successfully Configured"

}

output "key_name" {
  value = aws_instance.Web.key_name

}

output "security_groups" {
  value = "To access the Server and Run API Port 80,8080,443,22 are opened"

}

output "public_ip" {
  value = aws_instance.Web.public_ip

}

output "private_ip" {
  value = aws_instance.Web.private_ip
}

output "Jenkins_Access_URL" {
  value = "http://${aws_instance.Web.public_ip}:8080"

}
