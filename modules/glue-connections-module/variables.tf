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
  default     = "user"

}

variable "conn_vpc_ids" {
  description = "user for connection in db"
  default = "vpc-id"

}

variable "conn_pwd" {
  description = "pwd for connection in db"

}

variable "conn_sg_ids" {
  default = "sg-id"
}

variable "conn_subnet" {
  type = string
  default = "subnet-id"
}

variable "conn_azs" {
  default = "region"
}

variable "conn_type" {
  default = "JDBC"
}
