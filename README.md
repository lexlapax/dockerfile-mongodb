dockerfile-mongodb
==================

single instance mongodb for dev purposes.. generic enough to be used for other purposes..


uses mongodb 2.6+



how to use
----------

create a local directory for configs and dbs

> mkdir  -p {somedir}/data/db {somedir}/data/etc`


create a config file without auth

> vi {somedir}/data/db/mongod.conf

that has at least the following contents
```
noauth = true

dbpath = /data/db
```


start a container with a mounted data dir

> docker run -d -p 27017:27017 -p 28017:28017 -v {somedir}/data/:/data/ --name yourcontainername lapax/mongodb


connect to the daemon using your local mongo shell (make sure the versions match) and create a user admin role - see http://docs.mongodb.org/manual/tutorial/enable-authentication-without-bypass/


stop the container 

> docker stop yourcontainername


edit the mongod config file to enable authentication by changing noauth=true to auth=true
```
auth = true

dbpath = /data/db
```


restart the container

> docker start yourcontainername


connect via mongo shell using user admin role created and create normal users  - see http://docs.mongodb.org/manual/tutorial/add-user-to-database/

