resource "yandex_iam_service_account" "sa" {
  name = "sa_bucket"
}

// Назначение роли сервисному аккаунту
resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = "${yc_folder_id}"
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

// Создание статического ключа доступа
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

// Создание бакета с использованием ключа
resource "yandex_storage_bucket" "terraformnetologygorkov" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "terraformnetologygorkov"
}

# resource "yandex_storage_bucket" "b354575785676456" {
#   bucket = "my-policy-bucket1234"

#   # anonymous_access_flags {
#   #   read = true
#   #   list = false
#   # }
# }
