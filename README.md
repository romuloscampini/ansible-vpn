# Ansible for OpenVPN Server and Client
Ansible Project for Install OpenVPN Server and create client configuration

## Requirements
 * Ansible
 * Python
 * SSH
 * Git

## Usage

1. Clone this repo
2. Initialize sub-modules:
    * Inside dir of cloned repo, run:
        `git submodule update --init`
3. Specifiy server on `prod-inventory` file
4. Run install script
    * Full Installation (Server + Client)  
        `./run-full-install.sh <OPENVPN_CLIENT> <OPTIONAL_OPENVPN_PORT>`  
        Ex: `./run-full-install.sh "['Client1','Client1']" 1094`  
    * Create new client configuration  
        `./run-create_vpn_client.sh <OPENVPN_CLIENT> <OPTIONAL_OPENVPN_PORT>`  
        Ex: `./run-create_vpn_client.sh "['Client1','Client1']" 1094`  
5. Client configuration file (.ovpn) will be copied to /tmp/ansible/<CLIENT_CONFIG> on your host computer.
