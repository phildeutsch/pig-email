source /home/rick/.bash_profile
export JAVA_HOME=/usr
pig -l . -x local -v -w sent_counts.pig 

