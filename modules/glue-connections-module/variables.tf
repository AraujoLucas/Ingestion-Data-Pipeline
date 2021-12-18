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

}
variable "conn_pwd" {
  description = "pwd for connection in db"

}

variable "conn_sg_ids" {
  default = "sg-021152b8d2bdce48a"
}

variable "conn_subnet" {
  type = string
  default = "subnet-00f15e6d880f43512"
}

variable "conn_azs" {
  default = "us-east-1a"
}

variable "conn_type" {
  default = "JDBC"
}
