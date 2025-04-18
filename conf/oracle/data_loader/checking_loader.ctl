load data
infile 'Data_1x/checking.csv'
badfile 'bad.log'
into table checking
fields terminated by ','
(
                id,
                sourceID,
                targetID,
                amount,
                type,
                timestamp timestamp "yyyy-mm-dd HH24:MI:SS.FF3"
)
