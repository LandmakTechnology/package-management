## **Introduction to Ansible**
    https://github.com/Kenmakhanu/Ansible.git
- Ansible is an open-source configuration Management,
deployment and provisioning Automation tool maintained by Redhat.
- It is very, very simple to setup and yet powerful.
- Ansible will be helpful to perform:
    . Configuration Management
    . Application Deployment
    . Task Automation
    . IT Orchestration

## **How Ansible works**
  - Ansible works by connecting to remote nodes (hosts) and pushing out small programs, called “Ansible
    modules” to them.
  - The pushed programs/modules will be executed on remote server by Ansible over SSH and removes them
    when finished.
  - Unlike Puppet or Chef it doesn’t use an agent on the remote host, Instead Ansible uses SSH. It is agentless.
  - It’s written in Python which needs to be installed on the remote host.
  - This means that you don’t have to setup a client server environment before using Ansible

## **Benefits of using Ansible**
 - It is a free open -source Automation tool and simple to use.
 - Uses existing OpenSSH for connection
 - Agent-less – No need to install any agent on Ansible Clients/Nodes
 - Python/YAML based
 - Highly flexible and versatile in configuration management of systems.
 - Large number of ready to use modules for system management
 - Custom modules can be added if needed
