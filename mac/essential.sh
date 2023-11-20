#!/bin/bash

USER_ID=`whoami`
USER_DIR=/Users/$(whoami)/.essential
USER_PW=""
GIT_RAW="https://raw.githubusercontent.com"
GIT_REPO="/nugaBox/essential"
GIT_BRANCH="main"
OS_VER=`sw_vers -productVersion`


function install_brew(){
    if ! which brew
    then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo "HomeBrew가 정상적으로 설치되었습니다"
    else
        echo "HomeBrew가 이미 설치되어 있습니다"
    fi   
}

function set_user_dir(){
    mkdir -p ${USER_DIR}
    cd ${USER_DIR}
    curl -O -L ${GIT_RAW}/${GIT_REPO}/${GIT_BRANCH}/mac/brew/common.Brewfile
    curl -O -L ${GIT_RAW}/${GIT_REPO}/${GIT_BRANCH}/mac/brew/office.Brewfile
    curl -O -L ${GIT_RAW}/${GIT_REPO}/${GIT_BRANCH}/mac/brew/develop.Brewfile

    read -r -s -p "[sudo] '$(whoami)'의 비밀번호를 입력하세요: " USER_PW
}

function choice_option(){
    echo ""
    echo -e "\033[1m어떤 작업을 실행하시겠습니까?"
    echo -e "\033[34m[1]\033[0m 전체 설치 (필수+오피스+개발)"
    echo -e "\033[34m[2]\033[0m Homebrew 설치"
    echo -e "\033[34m[3]\033[0m 필수 App 설치"
    echo -e "\033[34m[4]\033[0m 오피스 App 설치"
    echo -e "\033[34m[5]\033[0m 개발용 패키지 & App 설치"
    echo -e "\033[34m[0]\033[0m 종료"
    echo ""
    # 사용자 입력 받기
    read -p "번호 입력: " choice

    # 선택에 따라 작업 수행
    case $choice in
        1)
            # 전체 설치
            install_brew
            set_user_dir
            brew bundle --file=${USER_DIR}/common.Brewfile
            brew bundle --file=${USER_DIR}/office.Brewfile
            brew bundle --file=${USER_DIR}/develop.Brewfile
            ;;
        2)
            # Homebrew 설치
            install_brew
            ;;
        3)
            # 필수 App 설치
            install_brew
            set_user_dir
            brew bundle --file=${USER_DIR}/common.Brewfile
            echo "$USER_PW" | sudo -S xattr -dr com.apple.quarantine /Applications/Google\ Chrome.app
            ;;
        4)
            # 오피스 App 설치
            install_brew
            set_user_dir
            brew bundle --file=${USER_DIR}/office.Brewfile
            ;;
        5)
            # 개발용 패키지 & App 설치
            install_brew
            set_user_dir
            brew bundle --file=${USER_DIR}/develop.Brewfile
            echo "$USER_PW" | sudo -S xattr -dr com.apple.quarantine /Applications/Docker.app
            echo "$USER_PW" | sudo -S xattr -dr com.apple.quarantine /Applications/iTerm.app
            ;;
        0)
            # 종료
            echo "Thank You :)"
            rm "$0"
            exit 0
            ;;
        *)
            # 잘못된 입력인 경우
            echo "올바른 옵션을 선택해주세요."
            ;;
    esac

    choice_option
}

# Welcome Message
echo "  _   _  _    _   _____            ____    ____  __   __ "
echo " | \ | || |  | | / ____|    /\    |  _ \  / __ \ \ \ / / "
echo " |  \| || |  | || |  __    /  \   | |_) || |  | | \ V / "
echo " | . \` || |  | || | |_ |  / /\ \  |  _ < | |  | |  > < "
echo " | |\  || |__| || |__| | / ____ \ | |_) || |__| | / . \ "
echo " |_| \_| \____/  \_____|/_/    \_\|____/  \____/ /_/ \_\ "
echo ""
echo "=== Supported By Nuga Jang"
echo "=== OS Version : macOS "${OS_VER}
echo ""
choice_option
