# 创建表空间、用户
```sql
-- 创建表空间
CREATE TABLESPACE hybench DATAFILE '/home/dmdba/data/DMDB/hybench.dbf' SIZE 10240M;

-- 创建用户
CREATE USER hybench IDENTIFIED BY hyBench_0 DEFAULT TABLESPACE hybench ;

-- 授权
GRANT RESOURCE TO hybench;

```

# 使用Makefile方式
```bash
make dm-gendata

make dm-load

make dm-run

make dm-clean

```


# 生成数据
```bash
./hybench -c ./conf/dm/db.props -t gendata
```

# 初始化表结构
```bash
./hybench -c ./conf/dm/db.props -t sql -f ./conf/dm/ddl_dm.sql
```

# 导入数据
```bash
# 需要提前把 Data_1x和data_loader放到合适的位置
scp -r Data_1x root@192.168.122.1:/home/dmdba/Data_1x
scp -r data_loader root@192.168.122.1:/home/dmdba/data_loader

#需要到dm服务器上执行(dmdba用户)load.sh
./data_loader/load.sh
```

# 创建索引
```bash
./hybench -c ./conf/dm/db.props -t sql -f ./conf/dm/create_index_oracle.sql
```

# 开始测试
```bash
./hybench -c ./conf/dm/db.props -t runall -f ./conf/dm/stmt_oracle.toml
```
