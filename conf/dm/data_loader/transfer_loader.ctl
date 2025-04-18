load data
infile 'Data_1x/transfer.csv'
badfile 'bad.log'
into table transfer
fields terminated by ','
trailing nullcols
(
                id,
                sourceID,
                targetID,
                amount,
                type,
                timestamp date format 'yyyy-mm-dd HH24:MI:SS.FF3',
                fresh_ts date
)
