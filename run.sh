#!/bin/bash

echo -e '==========================='
echo -e 'OpenVPN Server Installation'
echo -e '==========================='
echo -e '\t1. Install server and create client config'
echo -e '\t2. Create client config'
echo -e '\t0. Exit'


function runInstallServerAndClient() {
    printf '\t- OpenVPN Server Port: ' && read OPENVPN_PORT
    printf '\t- OpenVPN Client Names (Ex: Client1, Client2): ' && read OPENVPN_CLIENT
    if [ -z $OPENVPN_CLIENT ]; then
        echo "\nUso do script: "
        echo "\t$0 <OPENVPN_CLIENTS> <OPTIONAL_OPENVPN_PORT>"
        echo "Para 1 cliente:"
        echo "\tEx: $0 \"['Client1']\" <OPTIONAL_OPENVPN_PORT>"
        echo "Para multiplos clientes, separar por virgula."
        echo "\tEx: $0 \"['Client1','Client2','Client3']\" <OPTIONAL_OPENVPN_PORT>"
    else
        if [ -z $OPENVPN_PORT ]; then
            echo "OpenVPN Server Port not specified."
            echo "Using default OpenVPN Server Port -> 1194"
            echo "..."
            ansible-playbook -i inventory-prd -vv --ask-sudo-pass --extra-vars="OPENVPN_CLIENTS=$OPENVPN_CLIENT" openvpn.yml
        else
            echo "Usando OPENVPN_PORT: $OPENVPN_PORT"
            echo "..."
            ansible-playbook -i inventory-prd -vv --ask-sudo-pass --extra-vars="OPENVPN_CLIENTS=$OPENVPN_CLIENT OPENVPN_PORT=$OPENVPN_PORT" openvpn.yml
        fi
    fi    
}

function checkServerConfiguration(){
    HOST=`cat inventory-prd | grep \<SERVER_HOST\>`
    USER_SSH=`cat inventory-prd | grep \<USERNAME\>`
    if [ ! -z "$HOST" ] || [ ! -z "$USER_SSH" ]; then
        echo -e '\n[ERROR] Host not specified'
        echo -e 'Specify host:'
        printf '\t- IP or Host: ' && read -p "" SERVER_HOST
        printf '\t- SSH User: ' && read -p "" USERNAME_SSH
        sed -i '' "s/\<SERVER_HOST\>/${SERVER_HOST}/g" inventory-prd
        sed -i '' "s/\<USERNAME\>/${USERNAME_SSH}/g" inventory-prd
    fi
}


while true; do
    read -p "Choose an option: " option
    case $option in
        1)
            checkServerConfiguration
            runInstallServerAndClient
            git checkout inventory-prd
            break;;
        4)
            checkServerConfiguration
            runClientConfig
            git checkout inventory-prd
            break;;
        0)
            exit;;
        * )
            echo "Invalid option";;
    esac
done