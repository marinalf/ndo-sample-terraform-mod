
### Template Level

## Create VRF to be stretched between AWS & Azure

resource "mso_schema_template_vrf" "vrf1" {
  schema_id    = var.schema_id
  template     = var.template_name
  name         = var.vrf_name
  display_name = var.vrf_name
}

## Define Region, CIDR and Subnets in Azure

resource "mso_schema_site_vrf_region" "azure_region" {
  schema_id          = var.schema_id
  template_name      = var.template_name
  vrf_name           = mso_schema_template_vrf.vrf1.name
  site_id            = var.cloudsite1_id
  region_name        = var.azure_region_name
  vpn_gateway        = false
  hub_network_enable = true #This enables VNet Peering to Infra/Hub VNet
  hub_network = {
    name        = "default"
    tenant_name = "infra"
  }
  cidr {
    cidr_ip = var.azure_cidr_ip
    primary = true

    dynamic "subnet" {
      for_each = var.user_subnets
      content {
        ip   = subnet.value.ip
        name = subnet.value.name
      }
    }
  }
}

## Define Region, CIDR and Subnets in AWS

resource "mso_schema_site_vrf_region" "aws_region" {
  schema_id          = var.schema_id
  template_name      = var.template_name
  site_id            = var.cloudsite2_id
  vrf_name           = mso_schema_template_vrf.vrf1.name
  region_name        = var.aws_region_name
  vpn_gateway        = false
  hub_network_enable = true # This enables attachment to Infra TGW
  hub_network = {
    name        = var.tgw_name
    tenant_name = "infra"
  }
  cidr {
    cidr_ip = var.aws_cidr_ip
    primary = true

    dynamic "subnet" {
      for_each = var.aws_tgw_subnets
      content {
        ip    = subnet.value.ip
        name  = subnet.value.name
        zone  = subnet.value.zone
        usage = "gateway"
      }
    }
    dynamic "subnet" {
      for_each = var.aws_user_subnets
      content {
        ip    = subnet.value.ip
        name  = subnet.value.name
        zone  = subnet.value.zone
        usage = "user"
      }
    }
  }
}