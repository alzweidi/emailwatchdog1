#!/bin/bash

set -e

# === CONFIGURABLE ===
SMTP_EMAIL="79sends@gmail.com"
SMTP_PASSWORD="rfkfwalbaktmyqwl"
EMAIL_RECIPIENT="alzweidi@gmail.com"

echo "[1/4] Installing msmtp..."
sudo apt update && sudo apt install msmtp -y

echo "[2/4] Creating ~/.msmtprc config..."
cat > ~/.msmtprc <<EOF
defaults
auth           on
tls            on
tls_starttls   on
logfile        ~/.msmtp.log

account        default
host           smtp.gmail.com
port           587
from           $SMTP_EMAIL
user           $SMTP_EMAIL
password       $SMTP_PASSWORD
EOF

chmod 600 ~/.msmtprc

echo "[3/4] Sending test email to $EMAIL_RECIPIENT..."
echo -e "Subject: ✅ NockChain Email Setup Successful\n\nYour error email environment is ready." | msmtp "$EMAIL_RECIPIENT"

echo "[4/4] Done. Log:"
tail -n 10 ~/.msmtp.log
