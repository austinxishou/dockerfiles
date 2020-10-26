#!/bin/sh
# vim:sw=4:ts=4:et
set -e -x
echo "Start deploy init `date` "

# 钉钉通知
ding_talk_notify() {
	curl --location --request POST "https://oapi.dingtalk.com/robot/send?access_token=$DINGTALK_TOKEN" \
	--header 'Content-Type: application/json' \
	--data-raw '{
		"msgtype": "link", 
		"link": {
			"text": "K8s集群 '$HOSTNAME' 发布成功", 
			"title": "'$HOSTNAME'发布成功", 
			"picUrl": "https://freepngimg.com/thumb/success/6-2-success-png-image.png", 
			"messageUrl": "'$DINGTALK_APP_URL'"
		}
	}'
}

case "$INIT_METHOD" in
  git)
    sh /usr/local/bin/git-init.sh
    ;;
  oss)
    sh /usr/local/bin/oss-init.sh
    ;;
  *)
    echo "$INIT_METHOD is not supported!"
    ;;
esac

if [ -d /home/config ];then
  cp -r -f -L /home/config/* /usr/web-app
fi

# 格式化 DINGTALK_APP_URL 链接
case "$DINGTALK_APP_URL" in
  http*)
    ;;
  *.com)
    DINGTALK_APP_URL="https://$DINGTALK_APP_URL"
    ;;
  *)
    DINGTALK_APP_URL="https://www.kulchao.com"
    ;;
esac

if [ "$DINGTALK_TOKEN" ];then
	ding_talk_notify
fi

exec "$@"
