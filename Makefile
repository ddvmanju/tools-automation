infra:
	git pull
	terraform init
	terraform apply -auto-approve -var ssh_username=manju -var ssh_password=Manju@devops
	## Username and Password should not be hardcoded, Here we just hardcoding because to avoid the passing of input. This needs to be parsed as input in real time

ansible:
	git pull
	ansible-playbook -i $(tool_name)-internal.azdevops.online, tool-setup.yaml -e ansible_user=manju -e ansible_password=Manju@devops -e tool_name=$(tool_name) -e vault_token=$(vault_token)
	## Username and Password should not be hardcoded, Here we just hardcoding because to avoid the passing of input. This needs to be parsed as input in real time