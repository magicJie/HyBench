load data
infile 'Data_1x/checkingAccount.csv'
badfile 'bad.log'
into table checkingaccount
fields terminated by ','
(
                accountID,
                userID,
                balance,
                Isblocked,
                timestamp date format 'yyyy-mm-dd HH24:MI:SS.FF3'
)
