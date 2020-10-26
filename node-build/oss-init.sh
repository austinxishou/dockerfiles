#!/bin/sh
set -e -x
echo "Start OSS Init `date`"

# OSS工具
if [ "$OSS_ENDPOINT" ] && [ "$OSS_AKI" ] && [ "$OSS_AKS" ];then
	ossutil64 config -e "${OSS_ENDPOINT}" -i "${OSS_AKI}" -k "${OSS_AKS}"
else
  echo "Not define the OSS_ENDPOINT OR OSS_AKI OR OSS_AKS"
  exit 1
fi


# 获取OSS存储
# project_name 工程名
# project_env  对应的环境如: dev,beta,master
# project_subpath 对应的子文件夹
oss_fetch_app() {
	ossutil64 cp -f "${OSS_BUCKET}/${OSS_PROJECT_PATH}/release.md" ./release.md
	fileUrl=$(cat ./release.md)
	ossutil64 cp -f "${OSS_BUCKET}/${OSS_PROJECT_PATH}/${fileUrl}" ./deploy.zip
	unzip -o deploy.zip -d /usr/web-app
}

if [ "$OSS_PROJECT_PATH" ];then
	oss_fetch_app
else
  echo "Not define the OSS_PROJECT_PATH"
  exit 1
fi
echo "Finish OSS Init `date`"