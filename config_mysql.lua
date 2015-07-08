--MYSQL CONFIG:
config["mysqlhost"]="localhost"
config["mysqluser"]="username"
config["mysqlpassword"]="password"
config["mysqldb"]="databasename"

--IF You want to have a second unique log database set 'uniquelogdb' to true else let it be false
--IF true setup the other entries
config["uniquelogdb"]=false
config["logmysqlhost"]="localhost"
config["logmysqluser"]="logusername"
config["logmysqlpassword"]="logpassword"
config["logmysqldb"]="logdatabasename"