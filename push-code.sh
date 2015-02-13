#!/bin/bash

##
# push-code.sh
#
# push code script for pushing code to bitbucket.org
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
# php-cs-fixer: https://github.com/FriendsOfPHP/PHP-CS-Fixer
# git: http://git-scm.com/
#
##
# Usage
# push-code.sh /path/to/file1 /path/to/file2
#
##


# php-cs-fixer
read -p "PHP files [y/n]: " is_php
if [ $is_php=="Y" -o $is_php=="y" ]; then
	for filename in "$@"
	do
		if [ -f "$filename" ]; then
			php-cs-fixer fix -q --level=psr2 $filename
		fi
	done
fi


# git add
git add "$@"


# git commit
read -p "comment (no message): " comment
if [ -z "$comment" ]; then
	comment="no message"
fi
git commit -q -m "$comment"


# git push
git push origin master
