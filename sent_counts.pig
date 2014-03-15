messages = LOAD '/home/rick/mbox-analysis/email.avro' USING AvroStorage();
grouped_by_from = group messages by From;
count_from = FOREACH grouped_by_from GENERATE group, COUNT(messages) as counter;     
count_from_sorted = ORDER count_from BY counter ASC;
DUMP count_from_sorted
