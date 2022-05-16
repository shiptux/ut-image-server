#!/bin/bash

mkdir -p /home/ubuntu/system-image/secret/gpg/keys/
cp -R tools/keys/* /home/ubuntu/system-image/secret/gpg/keys/


bin/si-shell << EOF 
pub.create_channel("test")
pub.create_device("test", "mako")
for keyring in ("archive-master", "image-master", "image-signing", "blacklist"):
    pub.publish_keyring(keyring)
EOF

chown -R www-data:www-data /var/www/
