#!/bin/bash

TARGET_DIR=

GIT_USER=
GIT_PASS=
GIT_BRANCH="release"

ENABLE_OPENGL=1

AUTORUN_ARGS=()

#--------------------------------------------------------------------------------------------------

SCRIPT_SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "$SCRIPT_SRC_DIR/install"

#--------------------------------------------------------------------------------------------------

while getopts "t:u:p:b:m:e:d:r" opt; do
    case "$opt" in
        t) TARGET_DIR=${OPTARG}     ;;
        u) GIT_USER=${OPTARG}       ;;
        p) GIT_PASS=${OPTARG}       ;;
        b) GIT_BRANCH=${OPTARG}     ;;
        m) MAKEONLY=1               ;;
        e) ENABLE_OPENGL=1          ;;
        d) unset ENABLE_OPENGL      ;;
        r) IFS=' ' read -r -a AUTORUN_ARGS <<< ${OPTARG} ;;
        *)
            echo ""
            echo "    Invalid argument(s)!"
            echo ""

            exit 1 ;;
    esac
done

#--------------------------------------------------------------------------------------------------

if ! pushd "$TARGET_DIR" ; then

    echo ""
    echo "    Target dir is not exists!"
    echo ""

    exit 2
fi
    update_system

    install_lpkg                \
        build-essential         \
        mono-complete           \
        mono-devel              \
        clang                   \
        cmake                   \
        dos2unix                \
        xdg-user-dirs           \
        git-all                 \
        libcogl20               \
        libglew-dev             \
        libcheese8              \
        libcheese-gtk25         \
        libclutter-1.0-0        \
        libclutter-gtk-1.0-0    \
        libclutter-gst-3.0-0    \
        xserver-xorg-input-all

    if [ ! -d "UnrealEngine-$GIT_BRANCH" ]; then
        if ! git clone "https://$GIT_USER:$GIT_PASS@github.com/EpicGames/UnrealEngine.git" "UnrealEngine-$GIT_BRANCH" ; then

            echo ""
            echo "    Can't clone UnrealEngine from remote branch!"
            echo ""

            exit 3
        fi
    fi

    pushd "UnrealEngine-$GIT_BRANCH"

        if [ ! $MAKEONLY ]; then

            git submodule foreach --recursive "git clean -dfx"
            git clean -dfx
            git submodule foreach --recursive "git reset --hard"
            git reset --hard

            if ! git checkout "$GIT_BRANCH"; then

                echo ""
                echo "    Can't switch to $GIT_BRANCH branch!"
                echo ""

                exit 4
            fi

            if ! ./Setup.sh ; then

                echo ""
                echo "    Setup was Failed!"
                echo ""

                exit 5
            fi

            if ! ./GenerateProjectFiles.sh ; then

                echo ""
                echo "    GenerateProjectFiles was Failed!"
                echo ""

                exit 6
            fi
        else
            echo ""
            echo "    Make only!"
            echo ""
        fi

        if [ $ENABLE_OPENGL ]; then

            # enable OpenGL target
            sed -i 's/.*;.*+TargetedRHIs=GLSL_430/+TargetedRHIs=GLSL_430/g' "Engine/Config/BaseEngine.ini"

            # disable warning
            sed -i 's/FMessageDialog.*LinuxDynamicRHI.*OpenGLDeprecated.*OpenGL.*deprecated.*;//g' "Engine/Source/Runtime/RHI/Private/Linux/LinuxDynamicRHI.cpp"
        fi

        if [ $IS_KDE_NEON ]; then qdbus org.kde.KWin /Compositor suspend ; fi

        if ! make ; then

            echo ""
            echo "    Making process was Failed!"
            echo ""

            exit 7
        fi

        if [ $AUTORUN_ARGS ]; then exec "Engine/Binaries/Linux/UE4Editor" $AUTORUN_ARGS ; fi

        if [ $IS_KDE_NEON ]; then qdbus org.kde.KWin /Compositor resume ; fi

    popd

popd