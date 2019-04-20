#!/usr/bin/env bash
set -o nounset
set -o errexit

# check terraform installed
if ! which terraform ; then
#    brew install terraform
    VER="0.11.13"
    wget https://releases.hashicorp.com/terraform/${VER}/terraform_${VER}_linux_amd64.zip
    unzip terraform_${VER}_linux_amd64.zip
    sudo mv terraform /usr/local/bin/
fi

# run job every hour
CRON="0 */1 * * * * sh `pwd`/update-ip.sh"

# check cron tab exists
if crontab -l ; then
    crontab -l > CRON_FILE
fi

# add cron job
echo "${CRON}" >> CRON_FILE
crontab CRON_FILE
rm CRON_FILE
