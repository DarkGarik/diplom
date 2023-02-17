terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "terraformnetologygorkov"
    region     = "ru-central1"
    key        = "main/terraform.tfstate"
    access_key = "YCAJE5d3uMC3X1NVcGUKIcZoq"
    secret_key = "YCMJa_Qf29AA414DhbJcidqNnTGxbF9yI7egqcMV"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  folder_id = "${var.yc_folder_id}"
  zone = "ru-central1-a"
}
