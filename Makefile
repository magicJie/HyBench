REGISTRY ?= 
ORG ?= 
REPO ?= hybench
ARCH ?=
IMAGE_NAME := $(REPO)$(if $(ARCH),_$(ARCH))
IMAGE_TAG ?= 1.1.0
IMAGE_FULL_NAME := $(if $(REGISTRY),$(REGISTRY)/)$(if $(ORG),$(ORG)/)$(IMAGE_NAME):$(IMAGE_TAG)
OCI ?= "podman"

# 默认目标（显示帮助信息）
.DEFAULT_GOAL := help

# 测试数据规模
SF := 1x
# OCI运行模板
OCI_RUN := $(OCI) run --rm --network=host -it -v $(CURDIR)/conf:/app/conf -v $(CURDIR)/Data_$(SF):/app/Data_$(SF) --name $(IMAGE_NAME) $(IMAGE_FULL_NAME)

# 帮助信息
.PHONY: help
help:
	@echo "可用命令:"
	@echo "  make build              # 构建 $(OCI) 镜像（默认开发环境）"
	@echo "  make clean              # 删除镜像和容器"
	@echo "  make help               # 显示此帮助信息"
	@echo "  make load               # 从文件加载镜像"
	@echo "  make push               # 推送镜像到镜像仓库"
	@echo "  make run                # 运行容器,开发模式，挂载代码"
	@echo "  make run-prod           # 运行容器,生产模式"
	@echo "  make save               # 保存镜像到文件"
	@echo "  make test-cpu           # cpu测试"
	@echo "  make test-fileio        # 文件读写测试"
	@echo "  make test-mem           # 内存测试"
	@echo "  make test-net           # 网络测试"
	@echo "  make test-net-server    # 启动网络测试服务端"

.PHONY: build
build:
	$(OCI) build -t $(IMAGE_FULL_NAME) .

# 清理镜像和容器
.PHONY: clean
clean: 
	$(OCI) rmi $(IMAGE_FULL_NAME) || true

# 推送镜像到镜像仓库
.PHONY: push
push:
	$(OCI) push $(IMAGE_FULL_NAME)

# 保存镜像到文件
.PHONY: save
save:
	@if [ ! -d $(CURDIR)/out ]; then \
			mkdir -p $(CURDIR)/out; \
		else \
			rm -rf $(CURDIR)/out/*; \
	fi
	$(OCI) image save -o out/$(IMAGE_NAME).tar $(IMAGE_FULL_NAME)
	zip out/$(IMAGE_NAME).zip out/$(IMAGE_NAME).tar

# 从文件加载镜像
.PHONY: load
load:
	unzip -f out/$(IMAGE_NAME).zip out/$(IMAGE_NAME).tar || true
	$(OCI) image load -i out/$(IMAGE_NAME).tar | grep "Loaded image" |awk '{print $$3}'| xargs -I {} $(OCI) tag {} $(IMAGE_FULL_NAME)

release: save
	rm -rf out/$(IMAGE_NAME)_$(IMAGE_TAG).zip || true
	zip -r out/$(IMAGE_NAME)_$(IMAGE_TAG).zip ./* -x ".idea/*" "Data_$(SF)/*" "target/*" "out/*.zip" "bin/*" "package/*"

# 调试
debug:
	@echo "$(IMAGE_FULL_NAME)"

# 前置条件检查
ensure-pre:
	@if [ ! -d $(CURDIR)/Data_$(SF) ]; then \
			mkdir -p $(CURDIR)/Data_$(SF); \
	fi

.PHONY: run
run: ensure-pre
	$(OCI_RUN) bash || true

copy-conf:
	$(OCI) create --rm -it --name $(IMAGE_NAME) $(IMAGE_FULL_NAME)
	$(OCI) cp $(IMAGE_NAME):/app/conf/ ./conf
	$(OCI) rm $(IMAGE_NAME)

# 生成测试数据,各数据库通用
gendata: ensure-pre
	$(OCI_RUN) \
		./hybench -c ./conf/db.props -t gendata

oracle-init: 
	$(OCI_RUN) bash -c \
		"./hybench -c ./conf/oracle/db.props -t sql -f ./conf/oracle/ddl_oracle.sql &&\
		./hybench -c ./conf/oracle/db.props -t sql -f ./conf/oracle/create_index_oracle.sql"
oracle-load:
	$(OCI_RUN) \
		./conf/oracle/data_loader/load.sh
oracle-run:
	# 开始测试。如果要进行单项测试，参考前文测试步骤
	$(OCI_RUN) \
		./hybench -c ./conf/oracle/db.props -t runall -f ./conf/oracle/stmt_oracle.toml
oracle-clean:
	$(OCI_RUN) bash -c \
		"./hybench -c ./conf/oracle/db.props -t sql -f ./conf/dropTables.sql && \
		 ./hybench -c ./conf/oracle/db.props -t sql -f ./conf/oracle/clean.sql"
oracle-all: oracle-init oracle-load oracle-run oracle-clean

dm-init: 
	$(OCI_RUN) bash -c \
		"./hybench -c ./conf/dm/db.props -t sql -f ./conf/dm/ddl_oracle.sql &&\
		./hybench -c ./conf/dm/db.props -t sql -f ./conf/dm/create_index_oracle.sql"
dm-load:
	$(OCI_RUN) \
		./conf/dm/data_loader/load.sh
dm-run:
	# 开始测试。如果要进行单项测试，参考前文测试步骤
	$(OCI_RUN) \
		./hybench -c ./conf/dm/db.props -t runall -f ./conf/dm/stmt_oracle.toml
dm-clean:
	$(OCI_RUN) bash -c \
		"./hybench -c ./conf/dm/db.props -t sql -f ./conf/dropTables.sql && \
		./hybench -c ./conf/dm/db.props -t sql -f ./conf/dm/clean.sql"
dm-all: adm-init dm-load dm-run dm-clean