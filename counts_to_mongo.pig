REGISTER /home/rick/hadoop/mongo-2.10.1.jar 
REGISTER /home/rick/hadoop/mongo-hadoop/core/target/mongo-hadoop-core_2.2.0-1.2.0.jar
REGISTER /home/rick/hadoop/mongo-hadoop/pig/target/mongo-hadoop-pig_2.2.0-1.2.0.jar

set mapred.map.tasks.speculative.execution false
set mapred.reduce.tasks.speculative.execution false

sent_counts = LOAD 'sent_counts.txt' AS (from:chararray, total:long);
STORE sent_counts INTO 'mongodb://localhost/emails.sent_counts' 
    USING com.mongodb.hadoop.pig.MongoStorage();

