## **Ansible Directory Structure**

- The default ansible home directory is /etc/ansible
- This directory will consist of:
a) ansible.cfg
b) hosts
c) roles

## **Default ansible configuration file**
- The default location is: /etc/ansible/ansible.cfg,
 in which we can make various settings like location of inventory file, host_key_checking as False
- But we can define ansible configuration file in different location
and for this there is a priority for this files.

**Locations with priority(starting from top to bottom):** \
      - ANSIBLE_CONFIG environment variable \
      - ./ansible.cfg from the current directory \
      - ~/.ansible.cfg file present in home directory \
      - /etc/ansible/ansible.cfg default ansible.cfg file.

- Ansible will only use the configuration settings from the file
which is found in this sequence first, it will not look for the settings
in the higher sequence files if the setting is not present in the file
which is chosen for deployment

## **Host Key Checking**

- Anytime you make an ssh connection with a server for the
first time, you will be prompted to confirm if you want to
continue making the connection.
- This feature is by default set to true in the ansible.cfg file
- Disable this by uncommenting the line in the configuration file

   or

 **export ANSIBLE_HOST_KEY_CHECKING=false**
