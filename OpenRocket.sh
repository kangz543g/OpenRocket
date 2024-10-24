#!/bin/bash

# OpenRocket JAR 파일의 경로를 설정합니다. 파일 경로를 적절히 변경하세요.
JAR_PATH="$HOME/다운로드/OpenRocket-23.09.jar"

# Java 버전 확인 함수
check_java_version() {
    JAVA_VERSION=$(java -version 2>&1 | awk -F[\".] '{print $2}')
    
    # Java 17 이상이 설치되어 있는지 확인
    if [ "$JAVA_VERSION" -lt 17 ]; then
        echo "Java 17 이상이 필요합니다. 현재 설치된 버전은 Java $JAVA_VERSION입니다."
        exit 1
    fi
}

# OpenRocket 실행 함수
run_openrocket() {
    check_java_version
    # OpenRocket 실행
    if [ -f "$JAR_PATH" ]; then
        java -jar "$JAR_PATH"
    else
        echo "OpenRocket JAR 파일을 찾을 수 없습니다: $JAR_PATH"
        exit 1
    fi
}

# 설치 함수
install_openrocket() {
    sudo apt update
    sudo apt install openjdk-17-jdk -y
    sudo update-alternatives --config java
    echo "Java 17 설치 및 설정 완료."
}

# 도움말 함수
show_help() {
    echo "사용법: $0 {install|run|help}"
    echo
    echo "옵션:"
    echo "  install    Java 17을 설치하고 OpenRocket 실행 환경을 설정합니다."
    echo "  run        OpenRocket을 실행합니다."
    echo "  help       스크립트 사용법을 출력합니다."
}

# 스크립트 실행 시 옵션 처리
case "$1" in
    install)
        install_openrocket
        ;;
    run)
        run_openrocket
        ;;
    help)
        show_help
        ;;
    *)
        echo "알 수 없는 옵션입니다: $1"
        show_help
        exit 1
        ;;
esac
