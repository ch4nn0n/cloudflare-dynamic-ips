# Download
```bash
git clone https://github.com/ch4nn0n/cloudflare-dynamic-ips.git
cd cloudflare-dynamic-ips
```

# Install terraform
## Mac
```bash
brew install terraform
```
## Linux
```bash
export VER="0.11.13"
wget https://releases.hashicorp.com/terraform/${VER}/terraform_${VER}_linux_amd64.zip
unzip terraform_${VER}_linux_amd64.zip
sudo mv terraform /usr/local/bin/
```

# Init
```bash
sh add-cloudflare-creds.sh
sh set-up.sh
```

# lock down server
- <https://www.cyberciti.biz/faq/how-to-disable-ssh-password-login-on-linux/>
- <https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys--2>
