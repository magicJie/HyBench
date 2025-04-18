load data
infile 'Data_1x/loanApps.csv'
badfile 'bad.log'
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
