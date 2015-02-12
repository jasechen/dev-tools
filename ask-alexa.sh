#!/bin/bash

##
# ask-alexa.sh
#
#
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
#	1. other common tools in linux
#
##
# Usage
#	ask-alexa.sh URL
#
##


for site in "$@"
do
	curl -s http://www.alexa.com/siteinfo/$site > /tmp/alexa_$site
	cat /tmp/alexa_$site | grep '/images/flags/' | grep '<strong class="metrics-data align-vmiddle">' > /tmp/alexa_o_$site

	if [ -s /tmp/alexa_o_$site ] ; then
		reputation=`cat /tmp/alexa_o_$site | sed 's/<\/strong>//' | sed 's/^.*align-vmiddle">//g'`

		rm /tmp/alexa_$site
		rm /tmp/alexa_o_$site
		
		echo "$site: $reputation"
	else
		rm /tmp/alexa_$site
		rm /tmp/alexa_o_$site

		echo "$site: not exist."
	fi
done
