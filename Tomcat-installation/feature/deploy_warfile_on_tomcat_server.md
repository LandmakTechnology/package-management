##  How to deploy on tomcat server using maven
##### Prerequisite
	1. Maven Installation  [Get help here]
	2. Tomcat Installation [Get help here]

###  Procedure

## 1. Update pom.xml code to add maven plugin to copy artifacts onto tomcat 

``` sh
 cd jp #the folder Name of your javaproject
 cd mwa #Navigate to the directory of your maven web application
 vi pom.xml  #search for where the plugins tag end "</plugins>" and paste the below before the ending tag
##cchange the localhost to the public ip address of the tomcat server
```

 ```sh 
<plugins>
    <plugin>
        <groupId>org.apache.tomcat.maven</groupId>
        <artifactId>tomcat7-maven-plugin</artifactId>
        <version>2.2</version>
        <configuration>
        <url>http://localhost:8177/manager/text</url>
        <server>TomcatServer</server>
        <path>/second-demo-webapp</path>
        </configuration>
    </plugin>
</plugins>
```

## 2. create settings.xml for credentials 
   ```sh 
   <?xml version="1.0" encoding="UTF-8"?>
	<settings>
		<servers>

			<server>
				<id>TomcatServer</id>
				<username>admin</username>
				<password>change-to-configure-user-manager-password</password>
			</server>

		</servers>
	</settings>
  ```

## 3. Build and the project on tomcat
   ```sh
      mvn tomcat7:deploy
   ```
   
## 4. Check the tomcat manager you will see the newly deployed application there
