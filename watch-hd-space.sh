#!/bin/bash

##
# watch-hd-space.sh
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
# 
#
##
# Usage
#
#
##

space=`df -h --sync / | awk 'NR==2{print $5}'`
space=${space:0:2}

echo $space

if [ $space -ge 90 ] ; then
  echo "99"
fi


#sendmail -S smtp.gmail.com:25 
#-f Jase Chen 
#-au jase.chen@gmail.com 
#-ap imWJ123 
#-t test user2000@gmail.com

echo "This is a test mail." | mail -s "test mail" jase.chen@gmail.com