terraform {
  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket   = "reddit-bucket"
    region   = "ru-central1"
    key      = "terraform.tfstate"
    access_key = "YCAJER-gM1GXuRaBGsEPElcHJ"
    secret_key = "YCPdQb_hRFCOrSWTrR_yEnzrAtLol0PBca2Q_EMb"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
