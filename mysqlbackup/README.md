# MySQL 自动备份容器

## 主要特性
- 定时执行
- mysql全量备份
- zip加密压缩
- 上传ALI OSS


## 相关环境变量

### 数据库
DB_SERVER: 数据库主机地址 
DB_PORT: 数据库端口
DB_USER: 数据库用户
DB_PASS: 密码
DB_NAMES: 需要备份的数据库名称

### 备份
DB_DUMP_FREQ: 备份频率
DB_DUMP_BEGIN: 备份开始时间
DB_DUMP_CRON: 备份cron格式
RUN_ONCE: 运行一次并退出


DB_DUMP_DEBUG: 是否开启日志输出
DB_DUMP_BY_SCHEMA: 是否把schema定义和数据分开(非必填,默认为false)
DB_DUMP_KEEP_PERMISSIONS: 是否把权限保存为文件(非必填,默认为true)
MYSQLDUMP_OPTS: mysqldump 命令额外参数
DB_DUMP_TARGET: 备份保存方式,可以设置多个保存路径,用空格分开
  - local: 本地文件保存, 用/开始
  - s3: s3://bucketname/path
  - oss: oss://bucketname/path

### 阿里 OSS
OSS_ENDPOINT: bucket所在地域名信息,详情参考 [访问域名和数据中心](https://help.aliyun.com/document_detail/31837.html?spm=5176.8465980.help.49.4e701450eJafpo#concept-zt4-cvy-5db)
OSS_AKI: AccessKeyId
OSS_AKS: AccessKey secret


## 主要函数

- do_dump
- backup_target