rmf sent_counts.txt

messages = LOAD '/home/rick/mbox-analysis/email.avro' USING AvroStorage();

grouped_by_from = GROUP messages BY From;
count_from = FOREACH grouped_by_from GENERATE group, COUNT(messages) as counter;     
count_from_sorted = ORDER count_from BY counter DESC;
STORE count_from_sorted INTO 'sent_counts.txt';
