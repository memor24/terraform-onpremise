## Monitoring onpremise infrastructure
For monitoring, Zabbix will be eventually using OS agents for active monitoring, or snmp for passive monitoring of network devices. 

Monitoring stack for onprem virtual machine infrastructure with Zabbix by running a terraform code: 
- Terraform: automating the provision of Linux machines
- Ansible: automating the install and config of <a href="https://www.zabbix.com/download?zabbix=7.0&os_distribution=ubuntu&os_version=22.04&components=server_frontend_agent_2&db=pgsql&ws=nginx" target="_blank">Zabbix</a>

![image](https://github.com/user-attachments/assets/6cb6c7af-31fa-4adf-9196-fe06bcc4dff0)

Just run the Terraform code:
```
terraform init
terraform plan
terraform apply

terraform destroy
```
