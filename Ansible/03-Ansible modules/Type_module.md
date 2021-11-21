## **1. Command module**
- Used to execute binary commands
- It is the **default module**
- With the Command module the command will be executed without being proceeded through a shell.
- Consequently, some variables like $HOME and operations like <, >, | and & will not work.
-The command module is more secure, because it will not be affected by the user’s environment \
   **$ ansible all -i inventory -a "uptime"**

   **$ ansible db -a "cat /etc/hosts && pwd"**

## **2. Shell Module**
- Used to execute binary commands
- It is more superior than the command module
- Command will be executed being proceeded through a shell. \
   **$ ansible db -a "cat /etc/hosts && pwd"**

   **$ ansible db –m shell –a "cat /etc/passwd && pwd"**

## **3. File Module**
- Used to create files and directories \
 a) Create a file named file25 \
  **$ ansible group1 -m file -a "path=file26.txt state = touch"**

 b) Create a directory file25 \
  **$ ansible db -m file -a "path=/home/ansible/file26 state=directory mode=777 owner=root group=root" --become**

- If state=absent, the file or directory will be deleted

## **4. Copy Module**
- Used to copy files from the ansible control node to the remote
node or copy files from one location to another in the remote
node. \
a) From ansible control node to remote node \
  **$ ansible group1 -m copy -a "src=/source/file/path dest=/dest/location"** \
  **$ ansible group1 -m copy -a "src=/etc/hosts dest=/home/ansible"**

 b) From one location in remote node to another location in remote node \
  **$ ansible db -m copy -a “src=/source/file/path dest=/dest/location remote_src=yes"**

  **$ ansible group1 -m copy -a "src=/etc/hosts dest=/home/ansible remote_src=yes"**

 c) Change permission of a file in a remote node \
  **$ ansible db -m file -a "dest=/home/ansible/hosts mode=0664"**

## **5. Fetch Module**
- Used to download files from a remote node to the control machine. \
  **$ ansible db -m fetch -a “src=/source/file/path dest=/dest/location"**

- Will copy the files with a directory structure. \
  **$ ansible all -m fetch -a "src=./hosts dest=./"**

- To fetch the file without a directory structure, use the flat=yes option \
  **$ ansible all -m fetch -a "src=./hosts dest=./ flat=yes"**

## **6. Yum Module**
- Used to install a package in the ansible client. \
  **$ ansible db -m apt -a "name=apache2 state=present" --become**

  **$ ansible db -m service -a "name=apache2 state=started" --become**

  **$ ansible db -m apt -a "name=nginx state=present" -b**

## **7. Service Module**
- You can use the service module to manage services running on the remote nodes managed by Ansible. This will require extended system privileges, so make sure your remote user has sudo permissions and you include the --become option to use Ansible’s privilege escalation system. Using -K will prompt you to provide the sudo password for the connecting user.

  **$ ansible all -i inventory -m service -a "name=nginx state=restarted" --become  -K**

  **$ ansible all -m service -a "name=nginx state=stopped" --become  -K**

## **8. User Module**
 - Used to create user accounts.
 - Create a password encryption

 **$ openssl passwd -crypt <desired_password>**

 **$ ansible db -m user -a "name=Peter password=wiyiMQbLhCRUY shell=/bin/bash" -b**

## **9. Setup module**
- This is a default module and is used to gather facts about the hosts.
- The setup module returns detailed information about the remote systems managed by Ansible, also known as system facts.
- To obtain the system facts for group1, run:

  **$ ansible group1 -m setup**

- This will print a large amount of JSON data containing details about the remote server environment.
- To print only the most relevant information, include the "gather_subset=min" argument as follows:

  **$ ansible group1 -m setup -a "gather_subset=min"**

- To print only specific items of the JSON, you can use the filter argument. This will accept a wildcard pattern used to match strings. For example, to obtain information about both the ipv4 and ipv6 network interfaces, you can use *ipv* as filter:

  **$ ansible group1 -m setup -a "filter=*ipv*"**

## **10. Debug module**
- Executes only on the local host to display some information- message or variable value.
- We do not need ssh connectivity or password for a debug module. When using the debug module, the arguments will either be \
      - msg  =  to display a message \
      - var  = to display a variable

      **Default variables**
          - inventory_hostname
          - inventory_hostname_short
          - groups/ groups.keys()

  **$ ansible all -m debug -a "msg='This is a debug module'"** \
  **$ ansible all -m debug -a "var={{}}"**

 **inventory_hostname**
  - You can use debug to display variables.

  **$ ansible all -m debug -a "var='inventory_hostname'"** \
  **$ ansible all -m debug -a "msg={{inventory_hostname}}"**

  - If you have an inventory with entries like 'server1.cloud.production.host' then the command below will return server1. \
  **$ ansible all -m debug -a "msg={{inventory_hostname_short}}"**

  - You can also use debug module to display groups or groups keys in your inventory. \
  **$ ansible all -m debug -a "var='groups'"** \
  **$ ansible all -m debug -a "var='groups.keys()'"**
