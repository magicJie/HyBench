load data
infile 'Data_1x/savingAccount.csv'
badfile 'bad.log'
into table savingaccount
fields terminated by ','
(
                accountID,
                userID,
                balance,
                Isblocked,
                timestamp timestamp "yyyy-mm-dd HH24:MI:SS.FF3"
)
