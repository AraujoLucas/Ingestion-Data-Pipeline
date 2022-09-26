variable "query_output_locations" {
  type        = string
  default     = "wkg-results-account-id"
  description = "A map of output locations (S3 URLs) for Athena queries. Keys are query names identical to the map above"
}

variable "wkg_name" {
  type = string
  description = "name work group for athena"
  default = "wkg-analytics"
  
}
# variable "query_output_buckets_kms_keys" {
#   type        = map(string)
#   default     = {}
#   description = "A map of KMS keys used to encrypt data in output S3 buckets for Athena queries. Keys are query names identical to the map above. Results will not be encrypted if the key for a query is not defined in the map."
# }

variable "enforce_workgroup_configuration" {
  type        = string
  default     = false
  description = "Enforce workgroup configuration. Client side configuration will be ignored"
}
