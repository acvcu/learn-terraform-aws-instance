variable "region" {
  default = "us-east-1"
}

variable "vpcCIDRblock" {
  default = "10.0.0.0/16"
}

variable "subnetCIDRblock" {
  default = "10.0.1.0/24"
}

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}

variable "instance_ami" {
    type = string
    default = "ami-053b0d53c279acc90"
}

variable "vpc_name" {
    type = string
    default = "tf-vpc"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}
