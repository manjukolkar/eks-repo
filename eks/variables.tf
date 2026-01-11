variable "region" {
  default = "us-east-1"
}

variable "cluster_name" {
  default = "demo-cluster"
}

variable "node_group_name" {
  default = "demo-nodes"
}

variable "node_instance_type" {
  default = "t3.medium"
}

variable "desired_size" {
  default = 2
}

variable "max_size" {
  default = 3
}

variable "min_size" {
  default = 1
}
