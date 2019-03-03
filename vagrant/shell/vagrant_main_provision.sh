#!/usr/bin/env bash

if ! ansible --version | grep ansible;
then
    echo "-> Installing Ansible"
    # Add Ansible Repository & Install Ansible
    wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
    sudo rpm -Uvh epel-release-*.rpm
    sudo sed -i "s/mirrorlist=https/mirrorlist=http/" /etc/yum.repos.d/epel.repo
    sudo sudo yum -y install ca-certificates openssl nss
    sudo yum update -y
    sudo yum install ansible -y
    sudo yum install python-urllib3 pyOpenSSL python2-ndg_httpsclient python-pyasn1 -y

    # Add SSH key
    cat /ansible/files/authorized_keys >> /home/vagrant/.ssh/authorized_keys
else
        echo "-> Ansible already Installed!"
fi

echo "-> Installing Ansibe Galaxy Modules"
ansible-galaxy install -r /ansible/requirements.yml

# Execute Ansible
echo "-> Execute Ansible"
ansible-playbook /ansible/playbook_development.yml -i /ansible/inventories/hosts --connection=local
