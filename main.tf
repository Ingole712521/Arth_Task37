###############
# AWS Backend #
###############
resource "aws_instance" "aws_backend" {
  count = var.aws_count
  ami = var.aws_ami
  associate_public_ip_address=var.associate_public_ip
  instance_type = var.instance_type
  key_name=var.key_name 
  vpc_security_group_ids=var.sg_id
  tags = {
    Name = "${count.index + 1}" 
  }
}


#######
# ELB #
#######
resource "aws_elb" "elb" {
  name               = "terraform-elb"
#  availability_zones = "ap-south-1"
  internal=var.internal

  dynamic "listener" { 
    for_each = var.instance_protocol
    content{
      instance_port     = lookup(var.instance_port,listener.value)
      instance_protocol = listener.value
      lb_port           = lookup(var.lb_port,listener.value)
      lb_protocol       = lookup(var.lb_protocol,listener.value)
    }
  }


  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = var.health_check_timeout
    target              = var.health_check_target
    interval            = var.health_check_interval
  }

  instances                   = aws_instance.aws_backend[*].id
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

}


