OPENVPN_CLIENT=$1
OPENVPN_PORT=$2

if [ -z $OPENVPN_CLIENT ]; then
    echo "\nUso do script: "
    echo "\t$0 <OPENVPN_CLIENTS> <OPTIONAL_OPENVPN_PORT>"
    echo "Para 1 cliente:"
    echo "\tEx: $0 \"['Client1']\" <OPTIONAL_OPENVPN_PORT>"
    echo "Para multiplos clientes, separar por virgula."
    echo "\tEx: $0 \"['Client1','Client2','Client3']\" <OPTIONAL_OPENVPN_PORT>"
else
    if [ -z $OPENVPN_PORT ]; then
        echo "OPENVPN_PORT não especificada."
        echo "Usando OPENVPN_PORT default -> 1194"
        echo "..."
        ansible-playbook -i prod-inventory -vv --ask-sudo-pass --extra-vars="OPENVPN_CLIENTS=$OPENVPN_CLIENT" openvpn.yml
    else
        echo "Usando OPENVPN_PORT: $OPENVPN_PORT"
        echo "..."
        ansible-playbook -i prod-inventory -vv --ask-sudo-pass --extra-vars="OPENVPN_CLIENTS=$OPENVPN_CLIENT OPENVPN_PORT=$OPENVPN_PORT" openvpn.yml
    fi
fi