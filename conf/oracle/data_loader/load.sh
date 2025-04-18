#!/bin/bash

script_dir=$(dirname "$0")
# 定义公共参数
USER_ID="hybench/hyBench_0@oracle_server:1521/orclpdb1"
LOG_PATH="${script_dir}/loader.log"
CTL_BASE_DIR="${script_dir}"

# 需要处理的control文件列表
CTL_FILES=(
  "checkingaccount"
  "savingaccount"
  "checking"
  "customer"
  "company"
  "transfer"
  "loanapps"
  "loantrans"
)

# 循环执行命令
for ctl_file in "${CTL_FILES[@]}"; do
  ctl_path="${CTL_BASE_DIR}/${ctl_file}_loader.ctl"

  sqlldr $USER_ID \
    control=$ctl_path \
    log=$LOG_PATH
done
