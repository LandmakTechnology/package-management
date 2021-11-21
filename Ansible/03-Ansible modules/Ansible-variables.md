- Variables are used to store values.
- Ansible variable names should be letters, numbers, underscore and they should always start with a letter.

**Types of variables:** \
    - Default variables \
    - Inventory Vars (Host Vars and Group Vars) \
    - Facts and Local facts \
    - Registered variables

**Default variables** \
    - inventory_hostname \
    - inventory_hostname_short \
    - groups/ groups.keys()

  **Debug module**
- Executes only on the local host to display some information- message or variable value. We do not need ssh connectivity or password for a debug module.
- When using the debug module, the arguments will either be
    - msg  =  to display a message
    - var  = to display a variable

  **$ ansible all -m debug -a "var='This is a debug module'"** \
  **$ ansible all -m debug -a "msg={{}}"**

#**inventory_hostname**
- You can use debug to display variables.

$ ansible all -m debug -a "var='inventory_hostname'" \
$ ansible all -m debug -a "msg={{inventory_hostname}}"

- If you have an inventory with entries like 'server1.cloud.production.host' then the command below will return server1.

  **$ ansible all -m debug -a "msg={{inventory_hostname_short}}"**

#**groups/groups.keys()**
- You can list the hosts within a group \
 **$ ansible db --list-hosts**
- To list all groups in the inventory, then we can use the debug module \
  **$ ansible localhost -m debug -a "var=groups"**
- To display only the groups without the server ips, then use keys. \
  **$ ansible localhost -m debug -a "var=groups.keys()"**

#**Host and group variables**
- If were run the ping command on all servers, we will get permission denied on the servers that need a password to authenticate.
- instead of that, we can provide the password in the host file
- This is at a host level or host level variable.
#
       Host variables
       [db]
       172.31.13.31  ansible_ssh_pass=ansible

- You can also connect using a different user by specifying the user in the hosts file.
#
     [db]
     172.31.13.31  ansible_ssh_user=sammy ansible_ssh_pass=abc123

- Create a file on the managed nodes to see which user its working with. \
 **$ ansible all -m file -a "path=test.txt state=touch"**

#**Group variables:**
#
     [db:vars]
     ansible_ssh_user=sammy
     ansible_ssh_pass=abc123

- Host variables have the highest priorities. If variables are defined at a host level, then those variables will have precedence over variables that are defined at a group level.
