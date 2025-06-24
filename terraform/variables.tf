variable "project_name" {
  description = "The name of the new GCP project"
  type        = string
  default     = "micro1-test-project"
}

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "billing_account_id" {
  description = "The billing account to link the project to"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP zone"
  type        = string
  default     = "us-central1-c"
}

variable "owner_email" {
  description = "IAM member to assign Owner role to the project"
  type        = string
}
