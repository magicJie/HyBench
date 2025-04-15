load data
infile '/home/dmdba/Data_1x/loanApps.csv'
badfile '/home/dmdba/bad.log'
into table loanapps
fields terminated by ','
(
                id,
                applicantID,
                amount,
                duration,
                status,
                timestamp date format 'yyyy-mm-dd HH24:MI:SS.FF3'
)
