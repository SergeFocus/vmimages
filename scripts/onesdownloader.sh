# this file from https://github.com/Infactum/onec_dock/blob/master/download.sh
# see license notice for legal purpose

#!/bin/bash
#set -x
source ./.env

if [ -z "$USERNAME" ]
then
    echo "USERNAME not set"
    exit 1
fi

if [ -z "$PASSWORD" ]
then
    echo "PASSWORD not set"
    exit 1
fi

if [ -z "$VERSION" ]
then
    echo "VERSION not set"
    exit 1
fi

SRC=$(curl -c /tmp/cookies.txt -s -L https://releases.1c.ru)
ACTION=$(echo "$SRC" | grep -oP '(?<=form method="post" id="loginForm" action=")[^"]+(?=")')
EXECUTION=$(echo "$SRC" | grep -oP '(?<=input type="hidden" name="execution" value=")[^"]+(?=")')

curl -s -L \
    -o /dev/null \
    -b /tmp/cookies.txt \
    -c /tmp/cookies.txt \
    --data-urlencode "inviteCode=" \
    --data-urlencode "execution=$EXECUTION" \
    --data-urlencode "_eventId=submit" \
    --data-urlencode "username=$USERNAME" \
    --data-urlencode "password=$PASSWORD" \
    https://login.1c.ru"$ACTION"

if ! grep -q "TGC" /tmp/cookies.txt
then
    echo "Auth failed"
    exit 1
fi

mkdir -p $DOWNLOADIR

CLIENTLINK=$(curl -s -G \
    -b /tmp/cookies.txt \
    --data-urlencode "nick=Platform83" \
    --data-urlencode "ver=$VERSION" \
    --data-urlencode "path=Platform\\${VERSION//./_}\\client.deb32.tar.gz" \
    https://releases.1c.ru/version_file | grep -oP '(?<=a href=")[^"]+(?=">Скачать дистрибутив)')

SERVERINK=$(curl -s -G \
    -b /tmp/cookies.txt \
    --data-urlencode "nick=Platform83" \
    --data-urlencode "ver=$VERSION" \
    --data-urlencode "path=Platform\\${VERSION//./_}\\deb.tar.gz" \
    https://releases.1c.ru/version_file | grep -oP '(?<=a href=")[^"]+(?=">Скачать дистрибутив)')    


PLATGFORM32LINK=$(curl -s -G \
    -b /tmp/cookies.txt \
    --data-urlencode "nick=Platform83" \
    --data-urlencode "ver=$VERSION" \
    --data-urlencode "path=Platform\\${VERSION//./_}\\windows.rar" \           
    https://releases.1c.ru/version_file | grep -oP '(?<=a href=")[^"]+(?=">Скачать дистрибутив)')

curl --fail -b /tmp/cookies.txt -o $DOWNLOADIR/client32.tar.gz -L "$CLIENTLINK"
curl --fail -b /tmp/cookies.txt -o $DOWNLOADIR/server32.tar.gz -L "$SERVERINK"
curl --fail -b /tmp/cookies.txt -o $DOWNLOADIR/server32.tar.gz -L "$PLATGFORM32LINK"

rm /tmp/cookies.txt