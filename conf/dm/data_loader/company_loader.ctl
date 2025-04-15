load data
infile '/home/dmdba/Data_1x/company.csv'
badfile '/home/dmdba/bad.log'
into table company
fields terminated by ','
(
                companyID,
                name,
                category,
                staff_size,
                loan_balance,
                phone,
                province,
                city,
                SavingCredit,
				CheckingCredit,
				LoanCredit,
                Isblocked,
                created_date date format 'yyyy-mm-dd HH24:MI:SS.FF3',
                last_update_timestamp date format 'yyyy-mm-dd HH24:MI:SS.FF3'
)
