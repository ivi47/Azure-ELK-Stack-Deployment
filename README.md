# projects
Repository dedicated to personal projects and pieces of work.

## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![TODO: Update the path with the name of your diagram](Images/diagram_filename.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the _____ file may be used to install only certain pieces of it, such as Filebeat.

  - ``` 
  	projects/ansible/elk-ansible/elk-ansible_playbook.yml
	```
This document contains the following details:
- Description of the Topologu
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting inbound access to the network.
- Loadbalancers offer a failover and high availability strategy in the case of downtime or maintenance, by balancing traffic and workload between 2 or more servers. The jumpbox allows for a more secure way of accessing critical internal infrastrcture by being highly restrictive to only authorized and internal users.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to file systems and system metrics.
- Filebeat analyzes and reports log & file data collected from enabled modules within the filebeat config file (ex. apache, mysql etc.)
- Metricbeat collects and reports system-level metrics from enabled modules within the metricbeat config file.

The configuration details of each machine may be found below.

| Name     | Function  |IP Address | Operating System|
|----------|-----------|----------|------------------|
| JumpBox  | Gateway   |10.0.0.4  | Linux            |
| Web-1    | Web Server|10.0.0.5  | Linux            |
| Web-2    | Web Server|10.0.0.6  | Linux            |
| ElkStack | SIEM      |10.1.0.4  | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the 'JumpBox' machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- IP: 104.232.121.103

Machines within the network can only be accessed by other machines within the network, except for 'JumpBox' (accessible publicy by 1 IP address).
- The ELK VM can only be SSH'ed into via the 'JumpBox', and from within the Ansible docker container; much like both Web-1 & Web-2. The 'JumpBox' IP is 10.0.0.4.

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses         |
|----------|---------------------|------------------------------|
| JumpBox  | Yes                 | 104.232.121.103              |
| Web-1    | No                  | 10.0.0.1-254                 |
| Web-2    | No                  | 10.0.0.1-254                 |
| ElkStack | No                  | 10.0.0.1-254 && 10.1.0.1-254 |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- Infrastructure as a code enables the provisioning of systems, services, and applications simoltaneously and reliably in high complex environments and across multiple hosts, with flexibility that allows for both effeciency and security. 

The playbook implements the following tasks:
- Using 'apt', install 'docker.io' (Docker Engine) and 'python3-pip' (package for installing python modules).
- Using the newly installed 'python3-pip', use 'pip' module to install the docker python module (required by ansible to control docker).
- Using 'command' module, call 'sysctl' to increase virtual memory usage (required to run ELK). Then using the 'sysctl' module, ensure that the setting is reloaded on every boot.
- Using the 'docker_container' module, install and launch the elk container, and publish with specified ports.
- Use systemd module to enable docker service on boot.

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

- ![docker ps](/ansible/images/elk-container_docker-ps.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web-1: 10.0.0.5
- Web-2: 10.0.0.6

We have installed the following Beats on these machines:
- Filebeat (ENABLED MODULES: System Logs, Apache)
- Metricbeat (ENABLED MODULES: Docker Metrics)

These Beats allow us to collect the following information from each machine:
- Depending on the enabled modules, Filebeat will analyze and collect changes to file systems within the host. For example, with the Apache module enabled, web logs containing data such as visit history were being indexed and sent to Kibana for display. Metricbeat on the other hand, detects and logs changes in system, performance, and health metrics. With the 'Docker metrics' module enabled, metricbeat will collect data regarding CPU usage, healthcheck, memory, etc.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

- Access your Ansible Control Node and cd into your /etc/ansible dir.
- Git clone this repo using the command:```
	'git clone https://github.com/iviay/projects.git' ```
- Next copy the ELK playbook from the projects/ansible/elk-ansible/elk-ansible_playbook.yml into /etc/ansible:```
	'cp projects/ansible/elk-ansible/elk-ansible_playbook.yml /etc/ansible'```
- Repeat previous step for filebeat and metricbeat playbooks too.```
	'cp projects/ansible/filebeat-ansible_playbook.yml /etc/ansible'```
- Create or update the hosts file under /etc/ansible to include your target hosts (they will later be called in the playbook).```
	To create or update: 'nano hosts' in the /etc/ansible dir.```
- Edit your elk-ansible_playbook.yml file to include your specific target host (created in previous step).```
	'nano elk-ansible_playbook.yml'```
- Repeat previous step for the filebeat playbook as well.
