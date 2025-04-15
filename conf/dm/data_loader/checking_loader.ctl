load data
infile '/home/dmdba/Data_1x/checking.csv'
badfile '/home/dmdba/bad.log'
into table checking
fields terminated by ','
(
                id,
                sourceID,
                targetID,
                amount,
                type,
                timestamp date format 'yyyy-mm-dd HH24:MI:SS.FF3'
)
