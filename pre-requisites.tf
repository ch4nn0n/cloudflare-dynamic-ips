variable "cloudflare_email" {}
variable "cloudflare_token" {}
variable "vpn_server_ip" {}

provider "cloudflare" {
  email = "${var.cloudflare_email}"
  token = "${var.cloudflare_token}"
}

resource "cloudflare_record" "vpn" {
  domain = "jchannon.com"
  name = "vpn"
  value = "${var.vpn_server_ip}"
  type = "A"
}
