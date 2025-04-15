sqlldr hybench/hybench@//localhost:1521/orclpdb1 control=data_loader/checkingaccount_loader.ctl log=/home/oracle/loader.log

sqlldr hybench/hybench@//localhost:1521/orclpdb1 control=data_loader/savingaccount_loader.ctl log=/home/oracle/loader.log

sqlldr hybench/hybench@//localhost:1521/orclpdb1 control=data_loader/checking_loader.ctl log=/home/oracle/loader.log

sqlldr hybench/hybench@//localhost:1521/orclpdb1 control=data_loader/customer_loader.ctl log=/home/oracle/loader.log

sqlldr hybench/hybench@//localhost:1521/orclpdb1 control=data_loader/company_loader.ctl log=/home/oracle/loader.log

sqlldr hybench/hybench@//localhost:1521/orclpdb1 control=data_loader/transfer_loader.ctl log=/home/oracle/loader.log

sqlldr hybench/hybench@//localhost:1521/orclpdb1 control=data_loader/loanapps_loader.ctl log=/home/oracle/loader.log

sqlldr hybench/hybench@//localhost:1521/orclpdb1 control=data_loader/loantrans_loader.ctl log=/home/oracle/loader.log