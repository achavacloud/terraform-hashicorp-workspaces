# Conditionally create a new project or use an existing one
resource "tfe_project" "project" {
  count        = var.create_project ? 1 : 0
  organization = var.organization
  name         = var.project_name
}

locals {
  project_id = var.create_project ? tfe_project.project[0].id : var.existing_project_id
}

resource "tfe_workspace" "workspace" {
  name         = var.workspace_name
  organization = var.organization

  vcs_repo {
    identifier     = var.identifier
    oauth_token_id = var.oauth_token_id
    branch         = var.branch
  }

  terraform_version             = var.terraform_version
  auto_apply                    = var.auto_apply
  assessments_enabled           = var.assessments_enabled
  queue_all_runs                = var.queue_all_runs
  working_directory             = var.working_directory
  structured_run_output_enabled = var.structured_run_output_enabled
  project_id                    = local.project_id
  tag_names                     = var.tags

  depends_on = [tfe_project.project]
}

# Conditionally create the run trigger
resource "tfe_run_trigger" "run_trigger" {
  count = var.enable_run_trigger && var.source_workspace_id != null && var.target_workspace_id != null ? 1 : 0

  workspace_id       = tfe_workspace.workspace.id
  sourceable_id      = var.source_workspace_id

  depends_on = [tfe_workspace.workspace]
}
