--alter table customer add constraint customer_pkey primary key (custID);
--alter table company add constraint company_pkey primary key (companyID);
--alter table savingAccount add constraint savingAccount_pkey primary key (accountID);
--alter table checkingAccount add constraint checkingAccount_pkey primary key (accountID);
--alter table transfer add constraint transfer_pkey primary key (id);
--alter table checking add constraint checking_pkey primary key (id);
--alter table loanapps add constraint loanapps_pkey primary key (id);
--alter table loantrans add constraint loantrans_pkey primary key (id);

--CREATE SEQUENCE transfer_id_seq start with 6000001 increment by 1 cache 200;
--SELECT SETVAL('transfer_id_seq', (SELECT max(id) FROM transfer));
--ALTER TABLE transfer ALTER COLUMN id SET DEFAULT nextval('transfer_id_seq'::regclass);
--ALTER SEQUENCE transfer_id_seq OWNED BY transfer.id;

drop sequence transfer_seq;
create sequence transfer_seq start with 6000000 increment by 1;
 alter table transfer modify id default  transfer_seq.nextval;

--SELECT SETVAL('checking_id_seq', (SELECT max(id) FROM checking));
--ALTER TABLE checking ALTER COLUMN id SET DEFAULT nextval('checking_id_seq'::regclass);
--ALTER SEQUENCE checking_id_seq OWNED BY checking.id;
drop sequence checking_seq;
create sequence checking_seq start with 600000 increment by 1;
 alter table  checking modify id default  checking_seq.nextval;
drop sequence loanapps_seq;
CREATE SEQUENCE loanapps_seq  start with 600001 increment by 1 cache 200;
--SELECT SETVAL('loanapps_id_seq', (SELECT max(id) FROM loanapps));
--ALTER TABLE loanapps ALTER COLUMN id SET DEFAULT nextval('loanapps_id_seq'::regclass);
--ALTER SEQUENCE loanapps_id_seq OWNED BY loanapps.id;
alter table LOANapps  modify id default loanapps_seq.nextval;

drop sequence loantrans_seq;
CREATE SEQUENCE loantrans_seq  start with 600001 increment by 1 cache 200;
--ESELECT SETVAL('loantrans_id_seq', (SELECT max(id) FROM loantrans));
--ALTER TABLE loantrans ALTER COLUMN id SET DEFAULT nextval('loantrans_id_seq'::regclass);
--ALTER SEQUENCE loantrans_id_seq OWNED BY loantrans.id;

alter table loantrans modify id default loantrans_seq.nextval;
