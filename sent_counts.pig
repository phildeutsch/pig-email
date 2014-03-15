%default HOME `echo \$HOME`

REGISTER $HOME/pig-0.12.0/build/ivy/lib/Pig/avro-1.7.4.jar
REGISTER $HOME/pig-0.12.0/build/ivy/lib/Pig/json-simple-1.1.jar
REGISTER $HOME/pig-0.12.0/contrib/piggybank/java/piggybank.jar

DEFINE AvroStorage org.apache.pig.piggybank.storage.avro.AvroStorage();

rmf sent_counts.txt

/* Load the emails in avro format (edit the path to match where you saved them) using the AvroStorage UDF from Piggybank */
messages = LOAD '/home/rick/mbox-analysis/email.avro' USING AvroStorage();

/* Filter nulls, they won't help */
messages = FILTER messages BY (From IS NOT NULL) AND (To IS NOT NULL);

/* Emails can be 'to' more than one person. FLATTEN() will project our from with each 'to' that exists. */
addresses = FOREACH messages GENERATE From;

/* GROUP BY each from/to pair into a bag (array), then count the bag's contents ($1 means the 2nd field) to get a total.
   Same as SQL: SELECT from, to, COUNT(*) FROM lowers GROUP BY (from, to);
   Note: COUNT_STAR differs from COUNT in that it counts nulls. */

sent_counts = addresses COUNT_STAR(addresses) AS total;

/* Sort the data, highest sent count first */
sent_counts = ORDER sent_counts BY total DESC;
STORE sent_counts INTO 'sent_counts.txt';
