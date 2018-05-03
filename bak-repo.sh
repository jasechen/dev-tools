#!/bin/bash

##
# bak-repo.sh
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
# @Author       Jase Chen (jase.chen@gmail.com)
# @Copyright    Copyright (c) 2018, Jase Chen (jase.chen@gmail.com)
# @License      MIT License (http://opensource.org/licenses/MIT)
# @Version      0.0.1
#
##
# Requirements
#   1. git: https://git-scm.com/
#   2. curl: https://curl.haxx.se/
#   3. other common tools in linux
##
# Usage
#   1. setup bak_git_service, bak_repo_username, bak_repo_password
#   2. $ bak-repo.sh
#
##

bak_git_service="bitbucket"     # github / bitbucket
bak_repo_username=""
bak_repo_password=""

bak_repo_github_url="git@github.com:$bak_repo_username/"
bak_repo_bitbucket_url="git@bitbucket.org:$bak_repo_username/"

bak_repo_github_api="https://api.github.com/user/repos"
bak_repo_github_api_params_prefix="-d '{\"name\":\""
bak_repo_github_api_params_suffix="\"}'"

bak_repo_bitbucket_api="https://api.bitbucket.org/1.0/repositories/"
bak_repo_bitbucket_api_params="--data name="

if [ "$bak_git_service" = "bitbucket" ]; then
    bak_repo_api=$bak_repo_bitbucket_api
    bak_repo_api_params_prefix=$bak_repo_bitbucket_api_params
    bak_repo_api_params_suffix=''

    bak_repo_url=$bak_repo_bitbucket_url
else
    bak_repo_api=$bak_repo_github_api
    bak_repo_api_params_prefix=$bak_repo_github_api_params_prefix
    bak_repo_api_params_suffix=$bak_repo_github_api_params_suffix

    bak_repo_url=$bak_repo_github_url
fi

current_path=`pwd`

cmd_cd="cd"
cmd_rm="rm"
cmd_git="git"
cmd_curl="curl"
cmd_grep="grep"

cmd_git_pull="$cmd_git pull"
cmd_git_push="$cmd_git push"
cmd_git_clone="$cmd_git clone"
cmd_git_branch="$cmd_git branch"
cmd_git_remote="$cmd_git remote"
cmd_curl_user="$cmd_curl -u $bak_repo_username:$bak_repo_password"


read -p "Backup Repo NAME : " bak_repo_name
if [ ! -n "bak_repo_name" ]; then
    echo "Backup Repo NAME required !!"
    exit
fi

local_path=$current_path/$bak_repo_name

# if local path NOT exist
if [ ! -d "$local_path" ]; then

    # set repo url
    read -p "Repo URL : " repo_url
    if [ ! -n "repo_url" ]; then
        echo "Repo URL required !!"
        exit
    fi

    $cmd_git_clone $repo_url $local_path
fi

if [ ! -d "$local_path/.git" ]; then
    echo "Not Repo Folder !!"
    exit
fi


$cmd_cd $local_path

$cmd_curl_user $bak_repo_api $bak_repo_api_params_prefix$bak_repo_name$bak_repo_api_params_suffix

$cmd_git_remote set-url --add --push origin $repo_url
$cmd_git_remote set-url --add --push origin $bak_repo_url$bak_repo_name.git

# create local branches by remote branches
for branch in `$cmd_git_branch -r | $cmd_grep -v HEAD | $cmd_grep -v master`
do
    $cmd_git_branch --track ${branch##*/} $branch
done

# git pull all branches
$cmd_git_pull --all

# git push all branches
$cmd_git_push --all

$cmd_cd ..

$cmd_rm -rf $local_path
