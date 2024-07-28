variable "organization" {
  description = "The name of the Terraform Cloud organization."
  type        = string
}

variable "create_project" {
  description = "Whether to create a new project or use an existing one."
  type        = bool
  default     = true
}

variable "existing_project_id" {
  description = "The ID of an existing project to use if not creating a new one."
  type        = string
  default     = ""
}

variable "project_name" {
  description = "The name of the project in Terraform Cloud. Ignored if create_project is false."
  type        = string
  default     = ""
}

variable "workspace_name" {
  description = "The name of the workspace in Terraform Cloud."
  type        = string
}

variable "identifier" {
  description = "The VCS repository identifier, e.g., 'github-org/repo-name'."
  type        = string
}

variable "oauth_token_id" {
  description = "The OAuth token ID for the VCS provider."
  type        = string
}

variable "branch" {
  description = "The branch of the VCS repository to use."
  type        = string
  default     = "main"
}

variable "terraform_version" {
  description = "The Terraform version to use in the workspace."
  type        = string
  default     = "1.0.0"
}

variable "auto_apply" {
  description = "Whether to automatically apply changes when a Terraform plan is successful."
  type        = bool
  default     = false
}

variable "assessments_enabled" {
  description = "Whether to enable assessments for the workspace."
  type        = bool
  default     = false
}

variable "queue_all_runs" {
  description = "Whether to queue all runs, including speculative plans."
  type        = bool
  default     = false
}

variable "working_directory" {
  description = "The working directory for the workspace."
  type        = string
  default     = "/"
}

variable "structured_run_output_enabled" {
  description = "Whether to enable structured run output for the workspace."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A list of tags to assign to the workspace."
  type        = list(string)
  default     = []
}
