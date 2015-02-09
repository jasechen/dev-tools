## DEV-TOOLS
這些 scripts 是幫忙開發的工具.


### License
the MIT License.


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
