# terraform-aws-dynamic_ec2_elb

## This module has automated the process of launching ec2 instance from user provided ami & dynamically placing them behind the Load Balancer.

# Example:
<pre>
module "dynamic_ec2_elb" {
  source="Ayush122001/dynamic_ec2_elb/aws"
  version = "1.0.1"
  aws_count=4
  aws_az="ap-south-1"
  instance_port={"HTTP": 80}
  lb_port={"HTTP": 80}
  instance_protocol=["HTTP"]
  lb_protocol={"HTTP" : "HTTP"}
  aws_ami="ami-04c798aa91b4238ab"
  health_check_target="HTTP:80/index.php"
  internal=false
  health_check_interval=30
  health_check_timeout=3
  associate_public_ip=true
  sg_id=["sg-08a0f3cdae47fbbd6"]
  instance_type="t2.micro"
  key_name="keyhadoop"
}
</pre>

## variables: 
### - Required:

- aws_az  **(Required)**
    - Availability zone
    - Default = "ap-south-1" *Mumbai*

- instance_port **(Required)**
    - Port number on which Load Balancer will connect to instance  
    - Enter value in *map data* structure like  **{"HTTP": 80}**
    - Default = {"HTTP": 80}
    - **Syntax** = {"instance_protocol": port_number} 

- lb_port  **(Required)**
    - Port number on which client will connect to Load Balancer  
    - Enter value in *map data* structure like  **{"HTTP": 80}**
    - Default = {"HTTP": 80}
    - **Syntax** = {"instance_protocol": port_number}

- instance_protocol **(Required)**
    - Protocol on which instance will work
    - Enter valur in *list* data structure
    - Default: ["HTTP"]

- lb_protocol **(Required)**
    - Protocol on which Load Balancer will work/listen
    - Enter value in *map data* structure like  **{"HTTP": HTTP}**
    - Default = {"HTTP": "HTTP"}
    - **Syntax** = {"instance_protocol": "lb_protocol"}

- aws_ami **(Required)**
    - ami id for launching instance **Required**

- health_check_target **(Required)**
    - Default: "HTTP:80/index.php"


### - Optional

- internal
    - Whether Loadbalancer is internal or not
    - Default: true

- health_check_interval
    - Health check intervals for Load balancer
    - Default: 30

- health_check_timeout
    - Time out for health check
    - Default: 3

- associate_public_ip (Assign public ip to instance)
    - Default =true

- sg_id
    - Security Group id for instances
    - Default: [""]

- instance_type
    - Default = "t2.micro"

- key_name
    - Name of key that is to be used for login into instances
    - Default = None

- aws_count  
    - number of instance to be launched
    - Default = 1
 
 
# Terraform
