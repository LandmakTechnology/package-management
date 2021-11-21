## **Ad-hoc Commands**

- An Ad-Hoc command is a one-liner ansible command that performs one task on the target host(s)/group(s).

- Unlike playbooks — which consist of collections of tasks that can be reused — ad hoc commands are tasks that you don’t perform frequently, such as restarting a service or retrieving information about the remote systems that Ansible manages.

- This command will only have two parameters,\
        the group / target of a host that you want to perform the task and \
        the Ansible module to run.

 **Modules:**
  These are small programs that do some work on the server. They are the main building blocks
  of Ansible and are basically reusable scripts that are used by Ansible Ad-hoc and playbooks.
  Ansible comes with a number of reusable modules.

  - The basic syntax of an Ad-hoc command is

  **$ ansible [ -i inventory_file ] <server1:server2:Group1:Group2> -m <module> [-a arguments]**

  - To list all available modules:
    **$ ansible-doc -l**

## Testing Connection to Ansible Hosts
The following command will test connectivity between your Ansible control node and all your Ansible hosts. This command uses the current system user and its corresponding SSH key as the remote login, and includes the -m option, which tells Ansible to run the ping module. It also features the -i flag, which tells Ansible to ping the hosts listed in the specified inventory file

  **$ ansible all -i inventory -m ping**

- If this is the first time you’re connecting to these servers via SSH, you’ll be asked to confirm the authenticity of the hosts you’re connecting to via Ansible. When prompted, type yes and then hit ENTER to confirm.

You should get output similar to this:
#
     Output
     server1 | SUCCESS => {
       "changed": false,
        "ping": "pong"
      }
     server2 | SUCCESS => {
       "changed": false,
        "ping": "pong"
      }

- Once you get a "pong" reply back from a host, it means the connection is live and you’re ready to run Ansible commands on that server.

## Adjusting Connection Options
By default, Ansible tries to connect to the nodes as a remote user with the same name as your current system user, using its corresponding SSH keypair.

To connect as a different remote user, append the command with the -u flag and the name of the intended user:

  **$ ansible all -i inventory -m ping -u sammy**

- If you’re using a custom SSH key to connect to the remote servers, you can provide it at execution time with the --private-key option:

 **$ ansible all -i inventory -m ping --private-key=~/.ssh/custom_id**

- Once you’re able to connect using the appropriate options, you can adjust your inventory file to automatically set your remote user and private key, in case they are different from the default values assigned by Ansible. Then, you won’t need to provide those parameters in the command line.

The following example inventory file sets up the ansible_user variable only for the server1 server:
#
    ~/ansible/inventory
     server1 ansible_host=203.0.113.111 ansible_user=sammy
     server2 ansible_host=203.0.113.112

- Ansible will now use sammy as the default remote user when connecting to the server1 server.

- To set up a custom SSH key, include the ansible_ssh_private_key_file variable as follows:
#
    ~/ansible/inventory
    server1 ansible_host=203.0.113.111 ansible_ssh_private_key_file=/home/sammy/.ssh/custom_id
    server2 ansible_host=203.0.113.112

- In both cases, we have set up custom values only for server1. If you want to use the same settings for multiple servers, you can use a child group for that:
#
    ~/ansible/inventory
    [group_a]
    203.0.113.111
    203.0.113.112

    [group_b]
    203.0.113.113

    [group_a:vars]
    ansible_user=sammy
    ansible_ssh_private_key_file=/home/sammy/.ssh/custom_id

- This example configuration will assign a custom user and SSH key only for connecting to the servers listed in group_a.

## Defining Targets for Command Execution
- When running ad hoc commands with Ansible, you can target individual hosts, as well as any combination of groups, hosts and subgroups. For instance, this is how you would check connectivity for every host in a group named db:

   **$ ansible db -i inventory -m ping**

- You can also specify multiple hosts and groups by separating them with colons:

  **$ ansible server1:server2:dbservers [-i inventory] -m ping**

- To include an exception in a pattern, use an exclamation mark, prefixed by the escape character \, as follows. This command will run on all servers from group1, except server2:

  **$ ansible group1:\!server2 -i inventory -m ping**

- In case you’d like to run a command only on servers that are part of both group1 and group2, for instance, you should use & instead. Don’t forget to prefix it with a \ escape character:

  **$ ansible group1:\&group2 -i inventory -m ping**
