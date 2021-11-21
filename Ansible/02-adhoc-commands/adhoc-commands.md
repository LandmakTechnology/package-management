## **Examples of Ad-hoc Commands**

$ ansible all -m ping          :  => ping module

$ ansible all -a "cat /etc/passwd"     #=> command module/ default - does not work with |,>,<,&

$ ansible all -a "cat /etc/passwd | tail -3" : => will fail

$ ansible all -m shell -a "cat /etc/passwd | tail -3" :  => shell module

$ ansible db -m copy -a 'src=/source/file/path dest=/dest/location'

$ ansible db -m copy -a 'src=/source/file/path  dest=/dest/location remote_src = yes'

$ ansible all -m debug -a 'var=inventory_hostname' # debug module

$ ansible all -m debug -a 'msg={{inventory_hostname}}'
