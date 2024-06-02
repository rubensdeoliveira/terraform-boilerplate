locals {
  service_account_roles = flatten([
    for sa in var.service_account_accounts : [
      for role in sa.roles : {
        id   = sa.id
        role = role
      }
    ]
  ])
}

resource "google_service_account" "service_account_accounts" {
  for_each                     = { for sa in var.service_account_accounts : sa.id => sa }
  account_id                   = each.value.id
  display_name                 = each.value.display_name
  create_ignore_already_exists = true
}

resource "google_project_iam_member" "permissions" {
  for_each = { for sar in local.service_account_roles : "${sar.id}-${sar.role}" => sar }

  project = var.service_account_project_id
  member  = "serviceAccount:${google_service_account.service_account_accounts[each.value.id].email}"
  role    = each.value.role
}


