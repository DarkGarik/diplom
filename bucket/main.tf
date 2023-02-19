terraform {
    required_providers {
    yandex = {
        source = "yandex-cloud/yandex"
    }
    }
    required_version = ">= 0.13"
}

provider "yandex" {
    folder_id = "${var.yc_folder_id}"
    zone = "ru-central1-a"
}

resource "yandex_iam_service_account" "sa" {
    name = "sa-bucket"
}

// Назначение роли сервисному аккаунту
resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
    folder_id = "${var.yc_folder_id}"
    role      = "storage.editor"
    member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

// Создание статического ключа доступа
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
    service_account_id = yandex_iam_service_account.sa.id
    description        = "static access key for object storage"
}

// Создание бакета с использованием ключа
resource "yandex_storage_bucket" "test" {
    access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
    secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
    bucket     = "terraformnetologygorkov"
    force_destroy = true
}

# resource "local_file" "access_key" {
#     content = yandex_iam_service_account_static_access_key.sa-static-key.access_key
#     filename = "access_key"
# }

# resource "local_file" "secret_key" {
#     content = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
#     filename = "secret_key"
# }