## Terraform HashiCorp Workspace Module

This Terraform module helps manage Terraform Cloud or Terraform Enterprise workspaces, enabling teams to create and manage infrastructure consistently and securely. The module can either create a new project and associate workspaces with it or use an existing project for workspace management.

Features
- Project Management: Create new projects or use existing ones in Terraform Cloud or Enterprise.
- Workspace Configuration: Set up workspaces with VCS integration, including options for branch, working directory, and Terraform version.
- VCS Integration: Supports integration with version control systems through a common OAuth token, ensuring consistent access to repositories.
- Tagging and Metadata: Apply tags and additional metadata to workspaces for better organization and management.
- Auto Apply and Run Configuration: Configure auto-apply, run queuing, and assessment settings for workspaces.

Module Structure

This module provides a structured approach to managing Terraform workspaces and projects, making it easy to maintain and scale across multiple teams and environments.

###### This module structure and configuration allow users to create a VPC with customizable settings, including region, subnets, and security configurations. The use of variables makes the module flexible and reusable across different projects and environments. Users can provide their specific values for the variables in a terraform.tfvars file or through other methods, ensuring the infrastructure meets their specific needs.

```sh
terraform-hashicorp-workspace/
├── resource_group.tf          # Core resource definitions
├── variables.tf     # Input variable definitions
├── outputs.tf       # Output definitions
└── terraform.tfvars # (Optional) Default variable values  
```
Usage

Provider Configuration

Make sure to configure the TFE provider with the necessary API token for authentication:

```hcl
provider "tfe" {
  hostname = "app.terraform.io"  # Or your Terraform Enterprise hostname
  token    = var.tfe_token       # Use a variable or environment variable for the token
}
```

Module Example

Creating a New Project and Workspace

**main.tf**
```hcl
provider "tfe" {
  hostname = "app.terraform.io"  # your Terraform Enterprise hostname
  token    = var.tfe_token       # Use a variable or environment variable for the token
}

module "team_a_workspace1" {
  source = "achavacloud/workspaces/hashicorp"

  organization   = var.organization
  create_project = var.create_project
  project_name   = var.project_name
  workspace_name = var.workspace_name
  identifier     = var.identifier
  oauth_token_id = var.oauth_token_id
  branch         = var.branch
  terraform_version  = var.terraform_version
  auto_apply     = var.auto_apply
  assessments_enabled = var.assessments_enabled
  queue_all_runs = var.queue_all_runs
  working_directory = var.working_directory
  structured_run_output_enabled = var.structured_run_output_enabled
  tags           = var.tags
}

module "team_a_workspace2" {
  source = "achavacloud/workspaces/hashicorp"

  organization   = var.organization
  create_project = var.create_project
  project_name   = var.project_name
  existing_project_id = module.team_a_workspace1.project_id
  workspace_name = var.workspace_name
  identifier     = var.identifier
  oauth_token_id = var.oauth_token_id
  branch         = var.branch
  terraform_version  = var.terraform_version
  auto_apply     = var.auto_apply
  assessments_enabled = var.assessments_enabled
  queue_all_runs = var.queue_all_runs
  working_directory = var.working_directory
  structured_run_output_enabled = var.structured_run_output_enabled
  tags           = var.tags
}
```
**outputs.tf**
```hcl
output "project_id" {
  description = "The ID of the TFE project."
  value       = local.project_id
}

output "workspace_id" {
  description = "The ID of the created TFE workspace."
  value       = tfe_workspace.workspace.id
}

output "workspace_name" {
  description = "The name of the created TFE workspace."
  value       = tfe_workspace.workspace.name
}
```
**terraform.tfvars** refer examples
```hcl
organization          = "my-org"
tfe_token             = "your-api-token"
oauth_token_id        = "ot-XYZ"
existing_project_id   = "existing-project-id-if-any"
create_project        = true
project_name          = "team-a-project"
workspace_name        = "team-a-workspace-1"
identifier            = "github-org/repo-name"
branch                = "main"
terraform_version     = "1.0.0"
auto_apply            = true
assessments_enabled   = true
queue_all_runs        = false
working_directory     = "/path/to/dir"
structured_run_output_enabled = true
tags                  = ["team-a", "production"]
```
**variables.tf**
```hcl
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

variable "tfe_token" {
  description = "The API token for Terraform Cloud or Enterprise."
  type        = string
  sensitive   = true
}
```
