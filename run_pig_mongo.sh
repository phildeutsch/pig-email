source /home/rick/.bash_profile
export JAVA_HOME=/usr
pig -l . -x local -v -w counts_to_mongo.pig 

