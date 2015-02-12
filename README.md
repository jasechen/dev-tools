## DEV-TOOLS
	1. 這些 scripts 是 server 上會用到的工具.
	2. develop on Ubuntu.

### License
the [MIT License](http://en.wikipedia.org/wiki/MIT_License).


### push-code.sh
	1. 利用 git 將檔案一次將 add, commit, push 至 git server
	2. 若是 php 檔，會先 php-cs-fixer 過
###### Requirements
    1. php-cs-fixer: https://github.com/FriendsOfPHP/PHP-CS-Fixer
    2. git: http://git-scm.com
###### Usage
	# push-code.sh /path/to/file1 /path/to/file2 ...


### bak-databases.sh
	1. 利用 mysqldump 將 databases 匯出作備份
	2. 可設定若是要匯出 binlog 開始及結束位置
	3. 可搭配 cron job 使用
###### Requirements
	1. mysql: http://www.mysql.com
###### Usage
	# bak-databases.sh


### watch-hd-space.sh
	1. 偵測機器的空間有無超過監控值，若有超過則寄信通知
	2. 本程式利用 mail 通知管理者
	3. 可搭配 cron job 使用
###### Requirements
	1. mailutils: http://mailutils.org
	2. other common tools
###### Usage
	# watch-hd-space.sh


### watch-cpu-loading.sh
	1. 偵測機器的 CPU loading 有無超過監控值，若有超過則寄信通知
	2. 本程式利用 mail 通知管理者
	3. 可搭配 cron job 使用
###### Requirements
	1. sysstat: https://github.com/sysstat/sysstat
	2. other common tools
###### Usage
	# watch-cpu-loading.sh


### watch-mem-loading.sh
	1. 偵測機器的 Memory loading 有無超過監控值，若有超過則寄信通知
	2. 本程式利用 mail 通知管理者
	3. 可搭配 cron job 使用
###### Requirements
	1. some linux common tools
###### Usage
	# watch-mem-loading.sh
