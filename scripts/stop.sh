#!/usr/bin/env bash

ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)  # 현재 stop.sh가 속해 있는 경로를 찾음. 하단의 profile.sh의 경로를 찾기 위해 사용
source ${ABSDIR}/profile.sh # 일종의 import구문, stop.sh에서도 profile.sh의 여러 function을 사용할 수 있게 됨.

IDLE_PORT=$(find_idle_port)

echo "> $IDLE_PORT에서 구동 중인 애플리케이션 pid 확인"
IDLE_PID=$(lsof -ti tcp:${IDLE_PORT})

if [ -z ${IDLE_PID} ]
then
  echo "현재 구동중인 애플리게이션이 없으므로 종료하지 않습니다."
else
  chmod +x $IDLE_PID

  echo "> kill -15 $IDLE_PID"
  kill -15 ${IDLE_PID}
  sleep 5
fi