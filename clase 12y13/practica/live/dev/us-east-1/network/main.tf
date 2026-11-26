

locals {
    environment = "dev"
}

# git:file:///c:/tf-modules/edutek-modules//network?ref=v1.0.0

module "network" {
    source = "git:file:///c:/tf-modules/edutek-modules//network?ref=v1.0.0"
    environment        = var.environment # variable del root → baja al módulo
    cidr_block         = "10.0.0.0/16"
    availability_zones = ["us-east-1a", "us-east-1b"]
}
