#!/usr/bin/env bash
set -o nounset
set -o errexit
set -o pipefail

IP_REGEX="^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
TZ=GMT
APP=${0##*/}

log () {
    TZ=GMT
    DATE=`date`
    echo "$1" | sed -e "s/^/${DATE}, ${APP}: /;" >> ~/cloudflare-dynamic-ips.logs
}

log "Running update vpn server ip command"

# try to get IP
declare -a arr=("https://ipinfo.io/ip"
                "https://ipecho.net/plain"
                "https://ifconfig.me")
for i in "${arr[@]}"
do
    if SERVER_IP=$(curl -s ${i}) ; then
        [[ ${SERVER_IP} =~ $IP_REGEX ]] && break
    fi
done

# check DNS IP
DNS_IP=$(dig +short vpn.jchannon.com)

log "VPN IP: ${SERVER_IP}"
log "DNS IP: ${DNS_IP}"

if [[ "${SERVER_IP}" == "${DNS_IP}" ]] ; then
    log "IP unchanged"
    log "Exiting"
    exit
fi

# set variables
source ./secrets.env
TF_VAR_vpn_server_ip=${SERVER_IP}

# run terraform
log "Running terraform"
TF_OUTPUT=$(terraform apply \
    -var "cloudflare_email=${TF_VAR_cloudflare_email}" \
    -var "cloudflare_token=${TF_VAR_cloudflare_token}" \
    -var "vpn_server_ip=${TF_VAR_vpn_server_ip}" \
    -auto-approve)

log "${TF_OUTPUT}"

## check IP is correct
log "DNS IP updated to: ${SERVER_IP}"

sleep 2m

UPDATED_DNS_IP=$(dig +short vpn.jchannon.com)
log "DNS IP is now: ${UPDATED_DNS_IP}"
