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
        `git submodules update --init`
3. Specifiy server on `prod-inventory` file
4. Run install script
    * Full Installation (Server + Client)  
        `./run-full-install.sh <OPENVPN_CLIENT> <OPTIONAL_OPENVPN_PORT>`
    * Create new client configuration  
        `./run-create_vpn_client.sh <OPENVPN_CLIENT> <OPTIONAL_OPENVPN_PORT>`
5. After run script, copy '.ovpn' client configuration file, from /etc/openvpn/*.ovpn to your computer  
    `scp -C root@remote-server:/etc/openvpn/*.ovpn .`