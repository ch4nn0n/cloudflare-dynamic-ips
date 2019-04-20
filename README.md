# CloudFlare Dynamic IPs
If your ISP doesn't provide allocate a static IP to you it can be troublesome for running a server at home.

This tool allows you direct network traffic via a domain using CloudFlare's DNS service. 

It works by running a cron job on the server that queries it public IP, when the server IP differs to the record in CloudFlare's DNS it will update the A record.

## Setup
1. Download this repo
    ```bash
    git clone https://github.com/ch4nn0n/cloudflare-dynamic-ips.git
    cd cloudflare-dynamic-ips
    ```
1. Add your CloudFlare credentials:
    ```bash
    bash add-cloudflare-creds.sh
    ```
    You can obtain your API key from the bottom of the "My Account" page, found here: [Go to My account](https://dash.cloudflare.com/profile).
1. Create the DNS A record and set up cron job
    ```bash
    bash set-up.sh
    ```

## Security
Since the server will contain you CloudFlare api token, it is recommended that you take reasonable security precautions. The follow are good resources for explaining how to lock down a web server:
- <https://www.cyberciti.biz/faq/how-to-disable-ssh-password-login-on-linux/>
- <https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys--2>
