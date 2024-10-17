#!/bin/bash

# 检查是否是Git仓库
if [ ! -d ".git" ]; then
    echo "Not a Git repository."
    exit 1
fi

# 提示用户输入提交信息
echo "Enter your commit message:"
read COMMIT_MESSAGE

# 添加所有改动的文件到暂存区
git add .

# 提交暂存区的改动
git commit -m "$COMMIT_MESSAGE"

# 获取远程仓库的名字，默认为origin
REMOTE_NAME="origin"
if git remote | grep -qw "origin"; then
    REMOTE_NAME="origin"
else
    echo "No default remote named 'origin' found."
    exit 1
fi

# 推送提交到远程仓库
git push -u $REMOTE_NAME main

# 输出结果
if [ $? -eq 0 ]; then
    echo "Commit and push successful!"
else
    echo "Failed to push changes. Please check your Git configuration."
fi