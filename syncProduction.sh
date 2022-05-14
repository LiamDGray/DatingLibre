ansible-playbook -i ./deploy/inventories/production ./deploy/webservers.yml --vault-password-file=~/vault_password --tags sync
