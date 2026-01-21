provider "aws"{
    region = "us-east-1"

}

resource "aws_key_pair" "ma_cle"{
    key_name = "cle_adnane"
    public_key = file("ma-cle-terraform.pub")    

}

resource "aws_instance" "server"{
    ami = "ami-0c7217cdde317cfec"
    instance_type = "t3.micro"

    key_name = aws_key_pair.ma_cle.key_name
    vpc_security_group_ids = [aws_security_group.allow_ssh.id]

    tags ={
        Name = "Site accesible"
    }
}

resource "aws_security_group" "allow_ssh"{
    name = "Allow SSH Adnane"
    description = "Allowing the 22 port "

    ingress{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
}



output "ip_publique"{

    value = aws_instance.server.public_ip
}

