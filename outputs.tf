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
