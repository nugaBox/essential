#!/bin/bash

USERID=`whoami`
cd /Users/${USERID}/Documents
mkdir -p brew
cd brew
curl -O -L https://github.com/nugaBox/essential/blob/main/brew/common.Brewfile
echo "test success"