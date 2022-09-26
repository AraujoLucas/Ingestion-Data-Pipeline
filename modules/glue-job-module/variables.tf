variable "job_name" {
  type = string
  description = "Job Name"
}

variable "job_role" {
  description = "role do job que contem as permissoes de ingerir"
  default = "arn:aws:iam::account-id:role/datalake_ingestion"

}

variable "job_language" {
  description = "Job Language"

}

variable "job_script_location" {
  description = "Job Script Location"

}
variable "job_version" {
  description = "Job version"

}

variable "connections" {
  default = []

}

variable "work_type" {
  default = "G.1X"

}

variable "number_of_workers" {
  default = 10

}
