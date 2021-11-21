## **Configuring managed nodes.**
- Launch/select required no of servers (managed
nodes)
- Ansible Engine uses SSH Connection to connect
and work with Manage nodes.
- We can create SSH Connection in two ways:
     a) Password Authentication
     b) Password-less Authentication(This is with SSHKeys)
- Provide the managed Nodes IP/FQDN in
inventory file on Ansible Engine.
- Test the connectivity by running:

 **$ ansible all -m ping**

## a) Password Authentication
=================================
- Create same user(ansible) across all servers and provide
password for all users.

 **$ sudo adduser ansible**

- Provide root privileges to all ansible users on all servers.

 **$ echo "ansible ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/ansible**

- Make sure that PasswordAuthentication is enabled to yes in all servers under
/etc/ssh/sshd_config file.
- Restart the sshd service

 **$ sudo systemctl restart sshd.service**
- Test connectivity by providing a -k option to be prompted to enter the SSH password.

  **$ ansible all -m ping -k**

- By default, Ansible tries to connect to the nodes as a remote user with the same name as your current system user, using its corresponding SSH keypair.

- To connect as a different remote user, append the command with the -u flag and the name of the intended user:

  **$ ansible all -m ping -u sammy**

- If the remote user has a password, use -k option to be prompted to enter the SSH password.\
  **$ ansible all -m ping -u sammy -k**

 **Host and group variables**
- If were run the ping command on all servers, we will get permission denied on the servers that need a password to authenticate.
- instead of that, we can provide the password in the host file
- This is at a host level or host level variable.
#
    **Host variables**
    [db]
    172.31.13.31  ansible_ssh_pass=ansible

- You can also connect using a different user by specifying the user in the hosts file.
#
    [db]
    172.31.13.31  ansible_ssh_user=sammy ansible_ssh_pass=abc123

- Create a file on the managed nodes to see which user its working with. \
   **$ ansible all -m file -a "path=test.txt state=touch"**
#  
    **Group variables:**
    [db:vars]
    ansible_ssh_user=sammy
    ansible_ssh_pass=abc123

- Host variables have the highest priorities. If variables are defined at a host level, then those variables will have precedence over variables that are defined at a group level.

## b) **Password-less Authentication (SSH_Keys)**
- Generate ssh-keys using ssh-keygen command from ansible user in the control machine.
- Copy ssh public key using ssh-copy-id <hostname> from
/home/ansible/.ssh/ location.
- Now login to remote server without providing password with the
following command:

 **$ ssh user_name@hostname**

- Now we can test connection from Ansible Engine to Managed Node
using:

 **$ ansible all -m ping**
