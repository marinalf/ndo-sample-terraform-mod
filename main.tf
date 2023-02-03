## Define Tenant

resource "mso_tenant" "tenant" {
  name         = "multicloud"
  display_name = "multicloud"
  site_associations {
    site_id                 = data.mso_site.azure_site.id
    vendor                  = "azure"
    azure_access_type       = "shared"
    azure_subscription_id   = var.azure.azure_subscription_id
    azure_shared_account_id = var.azure.azure_subscription_id
  }
  site_associations {
    site_id                = data.mso_site.aws_site.id
    vendor                 = "aws"
    aws_account_id         = var.aws.aws_account_id
    is_aws_account_trusted = true
  }
}

## Define schema and template

resource "mso_schema" "schema1" {
  name = "multicloud"
  template {
    name         = "distributed-app"
    display_name = "distributed-app"
    tenant_id    = mso_tenant.tenant.id
  }
}

## Associate schema and template with cloud sites

resource "mso_schema_site" "azure_site" {
  schema_id           = mso_schema.schema1.id
  template_name       = "distributed-app"
  site_id             = data.mso_site.azure_site.id
  undeploy_on_destroy = true
}

resource "mso_schema_site" "aws_site" {
  schema_id           = mso_schema.schema1.id
  template_name       = "distributed-app"
  site_id             = data.mso_site.aws_site.id
  undeploy_on_destroy = true
}

## Configure template policies via module

module "schema_config" {
  source = "./modules/template_policies"

  depends_on = [
    mso_schema_site.azure_site,
    mso_schema_site.aws_site
  ]
  schema_id     = mso_schema.schema1.id
  template_name = "distributed-app"
  cloudsite1_id = data.mso_site.azure_site.id
  cloudsite2_id = data.mso_site.aws_site.id
}


# Deploy template

resource "mso_schema_template_deploy_ndo" "cloud_deployer" {
  depends_on = [
    module.schema_config
  ]

  schema_id     = mso_schema.schema1.id
  template_name = "distributed-app"
}
