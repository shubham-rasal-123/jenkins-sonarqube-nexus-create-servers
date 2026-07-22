
# VPC-CIDR BLOCK

variable "vpc_cidr_value" {
  description = "CIDR value for vpc creation"
  type        = string
  default     = "10.0.0.0/16"
}


# ENVIRONMENT

variable "environment" {
  description = "Environment for vpc creation"
  type        = string
  default     = "dev"
}


# SUBNET VARIABLES

variable "public-subnet-cidr-value1" {
  description = "CIDR for public subnet creation"
  type        = string
  default     = "10.0.4.0/24"
}

variable "public-subnet-cidr-value2" {
  description = "CIDR for public subnet creation"
  type        = string
  default     = "10.0.3.0/24"
}

variable "private-subnet-cidr-value1" {
  description = "CIDR for private subnet creation"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private-subnet-cidr-value2" {
  description = "CIDR for private subnet 2 creation"
  type        = string
  default     = "10.0.2.0/24"
}
