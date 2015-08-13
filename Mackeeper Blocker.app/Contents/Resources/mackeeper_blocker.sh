#!/bin/sh

if [ $EUID != 0 ]; then
    echo "Please enter your password. It is needed to make the required changes."
    sudo "$0" "$@"
else
    URLS=("mackeeperapp.mackeeper.com" "mackeeperapp2.mackeeper.com" "mackeeperapp3.mackeeper.com" "mackeeper.com")

    for url in ${URLS[*]}; do
        echo "Adding $url to /etc/hosts"
        echo "127.0.0.1  $url" >> /etc/hosts
    done

    echo "Finished! Please close this Terminal window."
fi
