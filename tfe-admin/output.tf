output "plan_team_token" {
  value     = tfe_team_token.rbac_plan.token
  sensitive = true
}

output "apply_team_token" {
  value     = tfe_team_token.rbac_apply.token
  sensitive = true
}