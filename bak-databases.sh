#!/bin/bash

##
# bak-databases.sh
#
# backup DATABASE to /path/to
#
##
# This content is released under the MIT License (MIT)
#
# Copyright (c) 2015, Jase Chen (jase.chen@gmail.com)
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
##
# @Author 		Jase Chen (jase.chen@gmail.com)
# @Copyright 	Copyright (c) 2015, Jase Chen (jase.chen@gmail.com)
# @License 		MIT License (http://opensource.org/licenses/MIT)
# @Version 		0.0.1
#
##
# Requirements
# mysql: http://www.mysql.com
#
##
# Usage
# 	crontab
#	* * * * * bak-databses
##


# settings
database_user=""
database_password=""
binlog_position="N"						# Y/N
databases="database1 database2"  		#database1 database2
save_to_path="/tmp/"
save_to_file_extension="_$(date +"%Y%m%d").sql"


#generate cmd
cmd="mysqldump --user=$database_user --password=$database_password --default-character-set=utf8"

cmd_binlog_position=""
if [ $binlog_position == "Y" -o $binlog_position == "y" ]; then
	cmd_binlog_position="--master-data"
fi


# mysqldump
echo "backup databases $(date +"%Y-%m-%d"): "
for database in $databases; do
	save_to_file="$save_to_path$database$save_to_file_extension"

	$cmd $cmd_binlog_position --databases $database > $save_to_file
	echo "  $database > $save_to_file"
done
echo ""
