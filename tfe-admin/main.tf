# 기존 workspace 조회 - workspace ID 획득 (ws-xxxxxxxx)
data "tfe_workspace" "poc" {
  name         = var.workspace_name
  organization = var.organization
}

#####################################################
# Advisory
#####################################################
# tfe_slug - API의 tar.gz 작업 진행
data "tfe_slug" "advisory" {
  source_path = "${path.module}/../policy/advisory"
}

# Advisory Policy Set 생성
resource "tfe_policy_set" "advisory" {
  name         = "sg-advisory"
  description  = "Advisory public SSH policy"
  organization = var.organization

  slug = data.tfe_slug.advisory
}

#####################################################
# Soft-mandatory
#####################################################
# tfe_slug - API의 tar.gz 작업 진행
data "tfe_slug" "soft_mandatory" {
  source_path = "${path.module}/../policy/soft-mandatory"
}

# Soft-mandatory Policy Set 생성
resource "tfe_policy_set" "soft_mandatory" {
  name         = "sg-soft-mandatory"
  organization = var.organization

  slug = data.tfe_slug.soft_mandatory
}

#####################################################
# Hard-mandatory
#####################################################
# tfe_slug - API의 tar.gz 작업 진행
data "tfe_slug" "hard_mandatory" {
  source_path = "${path.module}/../policy/hard-mandatory"
}

# Hard-mandatory Policy Set 생성
resource "tfe_policy_set" "hard_mandatory" {
  name         = "sg-hard-mandatory"
  organization = var.organization

  slug = data.tfe_slug.hard_mandatory
}

#####################################################
# Policy Set <-> Workspace Attachments
#
# count = 0: policy는 생성되지만 workspace에 붙지는 않음
#####################################################
resource "tfe_workspace_policy_set" "advisory" {
  count = var.policy_mode == "advisory" ? 1 : 0

  workspace_id  = data.tfe_workspace.poc.id
  policy_set_id = tfe_policy_set.advisory.id
}

resource "tfe_workspace_policy_set" "soft_mandatory" {
  count = var.policy_mode == "soft-mandatory" ? 1 : 0

  workspace_id  = data.tfe_workspace.poc.id
  policy_set_id = tfe_policy_set.soft_mandatory.id
}

resource "tfe_workspace_policy_set" "hard_mandatory" {
  count = var.policy_mode == "hard-mandatory" ? 1 : 0

  workspace_id  = data.tfe_workspace.poc.id
  policy_set_id = tfe_policy_set.hard_mandatory.id
}

#####################################################
# RBAC - Plan Team
#####################################################
resource "tfe_team" "rbac_plan" {
  name         = "rbac-plan-team"
  organization = var.organization
}

resource "tfe_team_access" "rbac_plan" {
  access       = "plan"
  team_id      = tfe_team.rbac_plan.id
  workspace_id = data.tfe_workspace.poc.id
}

# Ephemeral Team Token
resource "tfe_team_token" "rbac_plan" {
  team_id = tfe_team.rbac_plan.id
}

#####################################################
# RBAC - Apply Team
#####################################################
resource "tfe_team" "rbac_apply" {
  name         = "rbac-apply-team"
  organization = var.organization
}

resource "tfe_team_access" "rbac_apply" {
  access       = "write"
  team_id      = tfe_team.rbac_apply.id
  workspace_id = data.tfe_workspace.poc.id
}

# Ephemeral Team Token
resource "tfe_team_token" "rbac_apply" {
  team_id = tfe_team.rbac_apply.id
}