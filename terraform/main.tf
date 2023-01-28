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
    access_key = "YCAJEwMLaCxtkRAGEKIFgrO3H"
    secret_key = "YCP2leH5PnydF8xM--4oRul2ma1ViYV0klQrc6ea"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  folder_id = "${var.yc_folder_id}"
  zone = "ru-central1-a"
}

