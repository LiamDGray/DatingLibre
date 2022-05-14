if [[ $1 == "webserver" ]]
then
  ansible-playbook -i ./deploy/inventories/production ./deploy/webservers.yml --vault-password-file=~/vault_password
fi;

if [[ $1 == "database" ]]
then
  ansible-playbook -i ./deploy/inventories/production ./deploy/databases.yml --vault-password-file=~/vault_password
fi;

if [[ $1 == "site" ]]
then
  ansible-playbook -i ./deploy/inventories/production ./deploy/sites.yml --vault-password-file=~/vault_password
fi;

