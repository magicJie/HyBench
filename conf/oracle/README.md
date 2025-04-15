# 查看帮助
```bash
podman run --rm hybench:1.0.0
```

# 复制配置，便于持久化
```bash
podman create --name hybench hybench:1.0.0
podman cp hybench:/app/conf ./
podman rm hybench
```

# 创建压测用的用户
```sql
-- 创建表空间
CREATE TABLESPACE hybench DATAFILE '/opt/oracle/oradata/ORCL/ORCLPDB1/hybench.dbf' SIZE 20 G autoextend ON NEXT 100 M maxsize unlimited extent management LOCAL;
-- 创建用户
create user hybench identified by "hybench" default tablespace hybench;
-- 用户授权
GRANT ALL PRIVILEGES TO HYBENCH;

```

# 修改db.props文件
```properties
# 按需修改，一般情况改jdbc的配置即可
db=oracle
classname=oracle.jdbc.OracleDriver
username=hybench
password=hybench
url=jdbc:oracle:thin:@//192.168.122.1:1521/ORCLPDB1

url_ap=jdbc:oracle:thin:@//192.168.122.1:1521/ORCLPDB1
classname_ap=oracle.jdbc.OracleDriver
username_ap=hybench
password_ap=hybench

```

# 运行
```bash
# 注意映射压测数据目录,sf为数据规模，1x,10x,100x,1000x。1x数据量大约500M
sf=1x
podman run --name hybench -it -v $pwd/conf:/app/conf -v $pwd/Data_$sf:/app/Data_$sf -it hybench:1.0.0 bash

## 以oracle 为例

# 初始化表结构
./hybench -c ./conf/oracle/db.props -t sql -f ./conf/oracle/ddl_oracle.sql

# 生成数据
./hybench -c ./conf/oracle/db.props -t gendata

# 导入数据。由于各种数据库导入数据库的方式不同，所以需要根据不同的数据库进行不同的操作。参考后文导入数据库章节
# 复制Data_1x到oracle服务/home/oracle/Data_1x,复制conf/oracle/data_loader到oracle服务/home/oracle/data_loader
# 到oracle服务器上执行/home/oracle/data_loader/load.sh
cp -r Data_1x /home/oracle/Data_1x
cp -r conf/oracle/data_loader /home/oracle/data_loader

# 创建索引。为了提高导入效率，建议先导入数据再建索引
./hybench -c ./conf/oracle/db.props -t sql -f ./conf/oracle/create_index_oracle.sql

# 开始测试。如果要进行单项测试，参考前文测试步骤
./hybench -c ./conf/oracle/db.props -t runall -f ./conf/oracle/stmt_oracle.toml

# 清理数据
./hybench -c ./conf/oracle/db.props -t sql -f .conf/dropTables.sql

```
