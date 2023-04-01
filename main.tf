provider "aws" {
  region = "ap-northeast-3"
}

resource "aws_instance" "example" {
	ami	= "ami-0265608a60d05ecf8"
	instance_type = "t2.micro"
	vpc_security_group_ids = [aws_security_group.instance.id]
	key_name = aws_key_pair.kp.key_name	

	provisioner "local-exec" {
  		command = "echo ${self.public_ip} >> ./ansible/hosts"
  	}
 
	#provisioner "local-exec" {
  	#	command = "sh start.sh"
	#}

        provisioner "file" {
   	 	source = "script.sh"
    		destination = "/home/ec2-user/script.sh"

    		# 인스턴스에 SSH 연결
    		connection {
      			type        = "ssh"
      			host        = self.public_ip
      			user        = "ec2-user"
      			private_key = tls_private_key.pk.private_key_pem
 		}	
 	}

  	provisioner "remote-exec" {
    		inline = [
      			"chmod +x /home/ec2-user/script.sh",
      			"/home/ec2-user/script.sh"
    		]

    		# 인스턴스에 SSH 연결
    		connection {
      			type        = "ssh"
      			host        = self.public_ip
      			user        = "ec2-user"
      			private_key = tls_private_key.pk.private_key_pem
    		}
  	}

	tags = {
		Name = "terraform-example" 
	}
}

resource "aws_security_group" "instance" {
	name = "terraform-example-instance"

	ingress {
		from_port = 8080
		to_port = 8080
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	
	ingress {
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}


}

