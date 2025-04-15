load data
infile '/home/dmdba/Data_1x/loanTrans.csv'
badfile '/home/dmdba/bad.log'
into table loantrans
fields terminated by ','
(
                id,
                applicantID,
                appID,
                amount,
                status,
                timestamp date format 'yyyy-mm-dd HH24:MI:SS.FF3',
                duration,
                contract_timestamp date format 'yyyy-mm-dd HH24:MI:SS.FF3',
                delinquency
)
