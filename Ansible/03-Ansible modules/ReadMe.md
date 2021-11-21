## **Running Ansible Modules**

- These are small programs that do some work on the server.
- They are the main building blocks of Ansible and are basically reusable scripts that are used by Ansible Ad-hoc and playbooks.

- Ansible comes with a number of reusable modules. To list all available modules \
 **$ ansible-doc -l**

- The basic syntax of an Ad-hoc command is

  **$ ansible [ -i inventory_file ] <server1:server2:Group1:Group2> -m <module> [-a arguments]**

- To execute a module with arguments, include the -a flag followed by the appropriate options in double quotes, like this:

  **ansible target -i inventory -m module -a "module options"**

- As an example, this will use the apt module to install the package tree on server1:

 **$ ansible server1 -i inventory -m apt -a "name=git state=present"**

## **Running Bash Commands**
- When a module is not provided via the -m option, the command module is used by default to execute the specified command on the remote server(s).

- This allows you to execute virtually any command that you could normally execute via an SSH terminal, as long as the connecting user has sufficient permissions and there aren’t any interactive prompts.

- This example executes the uptime command on all servers from the specified inventory:

 **$ ansible all -i inventory -a "uptime"**

## **Using Privilege Escalation to Run Commands with sudo**
- If the command or module you want to execute on remote hosts requires extended system privileges or a different system user, you’ll need to use Ansible’s privilege escalation module, become. This module is an abstraction for sudo as well as other privilege escalation software supported by Ansible on different operating systems.

- For instance, if you wanted to run a tail command to output the latest log messages from Nginx’s error log on a server named server1 from inventory, you would need to include the --become option as follows:

 **$ ansible server1 -i inventory -a "tail /var/log/nginx/error.log" --become**

- This would be the equivalent of running a sudo tail /var/log/nginx/error.log command on the remote host, using the current local system user or the remote user set up within your inventory file.

- Privilege escalation systems such as sudo often require that you confirm your credentials by prompting you to provide your user’s password. That would cause Ansible to fail a command or playbook execution. You can then use the --ask-become-pass or -K option to make Ansible prompt you for that sudo password:

 **$ ansible server1 -i inventory -a "tail /var/log/nginx/error.log" --become -K**

## **Installing and Removing Packages**
The following example uses the apt module to install the nginx package on all nodes from the provided inventory file:

  **$ ansible all -i inventory -m apt -a "name=nginx" --become -K**

To remove a package, include the state argument and set it to absent:.

  **$ ansible all -i inventory -m apt -a "name=nginx state=absent" --become  -K**

## **Copying Files**
- With the copy module, you can copy files between the control node and the managed nodes, in either direction. The following command copies a local text file to all remote hosts in the specified inventory file:

  **$ ansible all -i inventory -m copy -a "src=./file.txt dest=~/myfile.txt"**

- To copy a file from the remote server to your control node, include the remote_src option:

  **$ ansible all -i inventory -m copy -a "src=~/myfile.txt remote_src=yes dest=./file.txt"**

## **Changing File Permissions**
- To modify permissions on files and directories on your remote nodes, you can use the file module.

- The following command will adjust permissions on a file named file.txt located at /var/www on the remote host. It will set the file’s umask to 600, which will enable read and write permissions only for the current file owner. Additionally, it will set the ownership of that file to a user and a group called sammy:

  **$ ansible all -i inventory -m file -a "dest=/var/www/file.txt mode=600 owner=sammy group=sammy" --become  -K**

- Because the file is located in a directory typically owned by root, we might need sudo permissions to modify its properties. That’s why we include the --become and -K options. These will use Ansible’s privilege escalation system to run the command with extended privileges, and it will prompt you to provide the sudo password for the remote user.

## **Restarting Services**
- You can use the service module to manage services running on the remote nodes managed by Ansible. This will require extended system privileges, so make sure your remote user has sudo permissions and you include the --become option to use Ansible’s privilege escalation system. Using -K will prompt you to provide the sudo password for the connecting user.

- To restart the nginx service on all hosts in group called webservers, for instance, you would run:

  **$ ansible webservers -i inventory -m service -a "name=nginx state=restarted" --become  -K**

## **Restarting Servers**
Although Ansible doesn’t have a dedicated module to restart servers, you can issue a bash command that calls the /sbin/reboot command on the remote host.

Restarting the server will require extended system privileges, so make sure your remote user has sudo permissions and you include the --become option to use Ansible’s privilege escalation system. Using -K will prompt you to provide the sudo password for the connecting user.

**Warning:** The following command will fully restart the server(s) targeted by Ansible. That might cause temporary disruption to any applications that rely on those servers.

To restart all servers in a webservers group, for instance, you would run:
  **$ ansible webservers -i inventory -a "/sbin/shutdown"  --become  -K**   \
  **$ ansible webservers -i inventory -a "/sbin/reboot"  --become  -K**

## **Gathering Information About Remote Nodes**
The setup module returns detailed information about the remote systems managed by Ansible, also known as system facts.

To obtain the system facts for server1, run:

  **$ ansible server1 -i inventory -m setup**

This will print a large amount of JSON data containing details about the remote server environment. To print only the most relevant information, include the "gather_subset=min" argument as follows:

 **$ ansible server1 -i inventory -m setup -a "gather_subset=min"**

To print only specific items of the JSON, you can use the filter argument. This will accept a wildcard pattern used to match strings, similar to fnmatch. For example, to obtain information about both the ipv4 and ipv6 network interfaces, you can use *ipv* as filter:

  **$ ansible server1 -i inventory -m setup -a "filter=*ipv*"**

If you’d like to check disk usage, you can run a Bash command calling the df utility, as follows:

  **$ ansible all -i inventory -a "df -h"**
