variable "create_connection" {
  default = true
}

variable "conn_name" {
  description = "name connetion"

}
variable "conn_url" {
  description = "url the connection db"


}
variable "conn_user" {
  description = "user for connection in db"
  default     = "olidbuser"

}

variable "conn_vpc_ids" {
  description = "user for connection in db"
  default = "vpc-00bfcdbe5e827f2a6"

}

variable "conn_pwd" {
  description = "pwd for connection in db"

}

variable "conn_sg_ids" {
  default = "sg-0928b2c479d4dfc3f"
}

variable "conn_subnet" {
  type = string
  default = "subnet-0b0e20016e09b5f99"
}

variable "conn_azs" {
  default = "us-east-1a"
}

variable "conn_type" {
  default = "JDBC"
}
