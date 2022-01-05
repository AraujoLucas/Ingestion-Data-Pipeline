# resource "aws_glue_connection" "connection" {

#   name                  = var.conn_name
  
#   connection_properties = {
#     JDBC_CONNECTION_URL = var.conn_url 
#     PASSWORD            = var.conn_pwd 
#     USERNAME            = var.conn_user 
#   }

#   physical_connection_requirements {
#     availability_zone       = var.conn_azs
#     #security_group_id_list  = var.conn_sg_ids
#     subnet_id               = var.conn_subnet
#   }
# }

resource "aws_glue_connection" "glue_connection" {
  count           = 1
  name            = var.conn_name
  connection_type = var.conn_type

  connection_properties = {
    JDBC_CONNECTION_URL = var.conn_url 
    USERNAME            = var.conn_user 
    PASSWORD            = var.conn_pwd
  }
 
  physical_connection_requirements {
    availability_zone      = var.conn_azs 
    #security_group_id_list = var.conn_sg_ids
    subnet_id              = var.conn_subnet 
  }
}