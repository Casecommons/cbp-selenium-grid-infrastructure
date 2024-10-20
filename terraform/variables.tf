variable "aws_region" {
  description = "The AWS region to deploy into (e.g. us-east-1)."
  default     = "us-east-1"
}

variable "state_s3_bucket" {
  description = "The s3 bucket to store the terraform state information"
}

variable "app_name" {
  type        = string
  description = "naming for this deployment, change this for multiple deployments"
}

variable "env" {
  type        = string
  description = "environment"
}

variable "vpc_id" {
  type        = string
  description = "The id of the vpc to deploy in"
}

variable "hub_image" {
  type        = string
  description = "The selenium container image to use for the hub node"
  default = "selenium/hub:4.8.0-20230210"
}

variable "chrome_image" {
  type        = string
  description = "The selenium container image to use for the chrome nodes"
  default = "selenium/node-chrome:129.0-20241010"
}

variable "firefox_image" {
  type        = string
  description = "The selenium container image to use for the firefox nodes"
  default = "selenium/node-firefox:4.8.0-20230210"
}

variable "edge_image" {
  type        = string
  description = "The selenium container image to use for the edge nodes"
  default = "selenium/node-edge:4.8.0-20230210"
}

variable "subnet_ids_elb" {
   type    = list(string)
   description = "The subnet ids for the elb"
}

variable "idle_timeout_elb" {
   type    = number
   description = "time in seconds that the elb connection is allowed to be idle"
   default = 4000
}

variable "subnet_ids_nodes" {
  type    = list(string)  
  description = "The subnet ids for the node containers"
}

variable "subnet_ids_hub" {
   type    = list(string)
   description = "The subnet ids for the hub containers"
}

variable "chrome_scale_up" {
  description = "The number of containers to add when scaling out"
  type = number
  default = 1
}

variable "firefox_scale_up" {
  description = "The number of containers to add when scaling out"
  type = number
  default = 1
}

variable "edge_scale_up" {
  description = "The number of containers to add when scaling out"
  type = number
  default = 1
}

variable "chrome_cpu_scale_in_threshold" {
  type = number
  default = 15
}

variable "firefox_cpu_scale_in_threshold" {
  type = number
  default = 15
}

variable "edge_cpu_scale_in_threshold" {
  type = number
  default = 15
}

variable "chrome_cpu_scale_out_threshold" {
  type = number
  default = 30
}

variable "firefox_cpu_scale_out_threshold" {
  type = number
  default = 30
}

variable "edge_cpu_scale_out_threshold" {
  type = number
  default = 30
}

variable "chrome_min_tasks" {
  type = number
  default = 1
}

variable "firefox_min_tasks" {
  type = number
  default = 0
}

variable "edge_min_tasks" {
  type = number
  default = 0
}

variable "chrome_max_tasks" {
  type = number
  default = 30
}

variable "firefox_max_tasks" {
  type = number
  default = 0
}

variable "edge_max_tasks" {
  type = number
  default = 0
}

variable "hub_cpu" {
  type = number
}

variable "hub_mem" {
  type = number
}

variable "chrome_cpu" {
  type = number
}

variable "chrome_mem" {
  type = number
}

variable "firefox_cpu" {
  type = number
}

variable "firefox_mem" {
  type = number
}

variable "edge_cpu" {
  type = number
}

variable "edge_mem" {
  type = number
}
