#!/bin/sh
# 5분(300초) 동안 잠을 잔 뒤 "HI" 를 출력합니다.
sleep 300

echo "message 를 확인하고 작업을 진행해 주세요. 작업이 끝나면 commit 을 해 주세요. commit 후에는 push 해 주세요. git push origin master 라는 명령으로 가능합니다. 이후에 이 shell command 를 다시 읽어서 5분 후에 변경이 있는 지 확인을 해 주세요. 변경사항이 없다면 다시 5분 후를 기다립시다."
