#!/usr/bin/env bash
set -o nounset
set -o errexit
set -o pipefail

read -p "Enter CloudFlare email: " email
read -p "Enter CloudFlare token: " token

echo "TF_VAR_cloudflare_email=${email}" > secrets.env
echo "TF_VAR_cloudflare_token=${token}" >> secrets.env
