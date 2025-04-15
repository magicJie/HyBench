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
./load.sh
```

# 创建索引
```bash
./hybench -c ./conf/dm/db.props -t sql -f ./conf/dm/create_index_oracle.sql
```

# 开始测试
```bash
./hybench -c ./conf/dm/db.props -t runall -f ./conf/dm/stmt_oracle.toml
```