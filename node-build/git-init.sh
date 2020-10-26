#!/bin/sh
# vim:sw=4:ts=4:et
set -e -x
echo "Start Git Init `date` "
path=$(pwd)
npm_build() {
  if [ "$NPM_BUILD_CMD" ] && [ "$NPM_OUT_DIR" ];then
    echo "Start build local `date` "
    registry="https://registry.npm.taobao.org" 
    if [ "$ALI_NPM_ACCOUNT_USR" ] && [ "$ALI_NPM_ACCOUNT_PSW" ]; then
      # 进行npm登录
      npm set registry https://registry-node.aliyun.com/org/1598402524133439/registry/kulchao/
      node /usr/local/bin/npm-login-cmd.js
      registry="https://registry-node.aliyun.com/org/1598402524133439/registry/kulchao/"
    fi


    npm install --unsafe-perm --registry=$registry \
      --sass_binary_site=https://npm.taobao.org/mirrors/node-sass/

    if [ "$NPM_BUILD_CMD" ];then
      echo "BuildCmd is $NPM_BUILD_CMD and outDir is $NPM_OUT_DIR"
      $NPM_BUILD_CMD
    fi
    cp -R /usr/build-temp/$NPM_OUT_DIR/* /usr/web-app
    cd /
    rm -rf /usr/build-temp/
    echo "Finish build local `date` "
  else
      cp -R /usr/build-temp/* /usr/web-app
      cd /
      rm -rf /usr/build-temp/
  fi
}

git_clone() {
  export GIT_SSH_COMMAND='ssh -i /etc/secret-volume/ssh-privatekey -o IdentitiesOnly=yes -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
  git clone $GIT_REPO -b $GIT_BRANCH /usr/build-temp
  cd /usr/build-temp
}

if [ "$GIT_REPO" ] && [ "$GIT_BRANCH" ];then
	git_clone
  npm_build
  cd $path
else
  echo "Not define the GIT_REPO AND GIT_BRANCH"
  exit 1
fi