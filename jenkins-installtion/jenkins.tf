provider "aws" {
    region = "ap-northeast-3"
}

resource "aws_instance" "jenkins_instance" {
  ami           = "ami-05ff0b3a7128cd6f8"
  instance_type = "t2.micro"
  key_name      = "mumbai-key"
  vpc_security_group_ids = ["sg-073f05c381f739f69"]
  tags = {
    Name = "jenkins_instance"
  }
    user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo dnf install fontconfig java-17-openjdk
              sudo wget -O /etc/yum.repos.d/jenkins.repo \
                     https://pkg.jenkins.io/redhat-stable/jenkins.repo
              sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
              sudo dnf upgrade
              sudo dnf install jenkins             
              sudo systemctl daemon-reload 
              sudo systemctl enable jenkins
              sudo systemctl start jenkins
              EOF
}
