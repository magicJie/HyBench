load data
infile '/home/dmdba/Data_1x/savingAccount.csv'
badfile '/home/dmdba/bad.log'
into table savingaccount
fields terminated by ','
(
                accountID,
                userID,
                balance,
                Isblocked,
                timestamp date format 'yyyy-mm-dd HH24:MI:SS.FF3'
)
