#!/bin/bash

# 获取当前 Git 项目的远程仓库 URL
REMOTE_URL=$(git remote get-url origin)

# 如果没有配置远程仓库，退出脚本
if [ -z "$REMOTE_URL" ]; then
    echo "没有检测到远程仓库，请先配置远程仓库。"
    exit 1
fi

# 执行 git pull 操作，拉取最新的远程更新
echo "正在拉取远程仓库的最新更改..."
git pull

# 判断 git pull 是否成功
if [ $? -eq 0 ]; then
    echo "git pull 成功，继续执行 git 操作..."
else
    echo "git pull 失败，请检查问题。"
    exit 1
fi

# 添加所有更改到暂存区
echo "添加更改到暂存区..."
git add .

# 检查是否有文件被添加
if git diff-index --quiet HEAD --; then
    echo "没有检测到任何更改，不执行 git commit 和 push。"
    exit 0
fi

# 提示用户输入提交信息
read -p "请输入 commit 信息: " commit_message

# 提交更改
echo "提交更改..."
git commit -m "$commit_message"

# 推送到远程仓库
echo "推送更改到远程仓库..."
git push

# 检查推送状态
if [ $? -eq 0 ]; then
    echo "推送成功！"
else
    echo "推送失败，请检查问题。"
    exit 1
fi