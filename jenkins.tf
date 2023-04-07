resource "aws_instance" "jenkins" {
	ami		       = "ami-012c6a03c2e59a445"
	instance_type	       = "t3.small"
	subnet_id	       = aws_subnet.subnet.id
	vpc_security_group_ids = [aws_security_group.sg.id]
	key_name	       = aws_key_pair.kp.key_name	
	associate_public_ip_address = true

	provisioner "local-exec" {
  		command = "echo ${aws_eip.jenkins.public_ip} >> ./ansible/jenkins-hosts"
  	}
 
        provisioner "file" {
   	 	source = "./script/init.sh"
    		destination = "/home/ec2-user/init.sh"

    		connection {
      			type        = "ssh"
      			host        = self.public_ip
      			user        = "ec2-user"
      			private_key = tls_private_key.pk.private_key_pem
 		}	
 	}

  	provisioner "remote-exec" {
    		inline = [
      			"chmod +x /home/ec2-user/init.sh",
      			"/home/ec2-user/init.sh",
			"echo ${aws_instance.web.private_ip} >> /home/ec2-user/web-hosts",
			"echo [default] >> /home/ec2-user/credentials",
                        "echo aws_access_key_id = ${aws_iam_access_key.s3_user_key.id} >> /home/ec2-user/credentials",
                        "echo aws_secret_access_key = ${aws_iam_access_key.s3_user_key.secret} >> /home/ec2-user/credentials"
    		]

    		connection {
      			type        = "ssh"
      			host        = self.public_ip
      			user        = "ec2-user"
      			private_key = tls_private_key.pk.private_key_pem
    		}
  	}

	tags = {
		Name = "jenkins-server" 
	}
}

resource "aws_eip" "jenkins" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_eip_association" "jenkins" {
  instance_id   = aws_instance.jenkins.id
  allocation_id = aws_eip.jenkins.id
}

output "jenkis_public_ip" {
  value = aws_eip.jenkins.public_ip
}
