#!/bin/bash

TARGET_DIR="/home/$USER"

GIT_USER=
GIT_PASS=
GIT_BRANCH="release"

ENABLE_OPENGL=1

AUTORUN_ARGS=()

#--------------------------------------------------------------------------------------------------

SCRIPT_SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "$SCRIPT_SRC_DIR/install"

#--------------------------------------------------------------------------------------------------

for ARG in "$@" ; do
    case "$ARG" in
        -d*) DELETE_IF_EXISTS=1         ;;
        -s*) SKIP_DEPS=1                ;;
        -t*) TARGET_DIR="${ARG#*=}"     ;;
        -u*) GIT_USER="${ARG#*=}"       ;;
        -p*) GIT_PASS="${ARG#*=}"       ;;
        -b*) GIT_BRANCH="${ARG#*=}"     ;;
        -m*) MAKEONLY=1                 ;;
        -e*) ENABLE_OPENGL=1            ;;
        -d*) unset ENABLE_OPENGL        ;;
        -r*) eval 'for UE4_ARG in '"${ARG#*=}"'; do AUTORUN_ARGS+=("$UE4_ARG"); done' ;;
        *)
            echo ""
            echo "    Invalid argument: "${ARG#*=}" !"
            echo ""

            exit 1 ;;
    esac
done

#--------------------------------------------------------------------------------------------------

if ! [[ $SKIP_DEPS ]] ; then

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
fi

if ! pushd "$TARGET_DIR" ; then

    echo ""
    echo "    Target dir is not exists!"
    echo ""

    exit 2
fi
    echo ""
    echo "    Installation path: $TARGET_DIR/UnrealEngine-$GIT_BRANCH"
    echo ""

    if [ -d "UnrealEngine-$GIT_BRANCH" ] ; then
        if [[ $DELETE_IF_EXISTS ]] ; then

            echo ""
            echo "    Remove existing sources and do a clean install: UnrealEngine-$GIT_BRANCH"
            echo ""

            rm -rf "UnrealEngine-$GIT_BRANCH"
        else
            echo ""
            echo "    Update existing sources: UnrealEngine-$GIT_BRANCH"
            echo ""

            git fetch --all

            git submodule foreach --recursive "git clean -dfx"
            git clean -dfx
            git submodule foreach --recursive "git reset --hard HEAD"
            git reset --hard HEAD

            git pull
        fi
    fi

    if ! [ -d "UnrealEngine-$GIT_BRANCH" ] ; then
        if ! ( git clone "https://$GIT_USER:$GIT_PASS@github.com/EpicGames/UnrealEngine.git" "UnrealEngine-$GIT_BRANCH" ) ; then

            echo ""
            echo "    Can't clone UnrealEngine from remote branch!"
            echo ""

            exit 3
        fi
    fi

    pushd "UnrealEngine-$GIT_BRANCH"

        if ! [[ $MAKEONLY ]] ; then

            if ! ( git checkout "$GIT_BRANCH" ) ; then

                echo ""
                echo "    Can't switch to $GIT_BRANCH branch!"
                echo ""

                exit 4
            fi

            if ! ( ./Setup.sh ) ; then

                echo ""
                echo "    Setup was Failed!"
                echo ""

                exit 5
            fi

            if ! ( ./GenerateProjectFiles.sh ) ; then

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

        if [[ $ENABLE_OPENGL ]] ; then

            # enable OpenGL target
            sed -i 's/.*;.*+TargetedRHIs=GLSL_430/+TargetedRHIs=GLSL_430/g' "Engine/Config/BaseEngine.ini"

            # disable warning
            sed -i 's/FMessageDialog.*LinuxDynamicRHI.*OpenGLDeprecated.*OpenGL.*deprecated.*;//g' "Engine/Source/Runtime/RHI/Private/Linux/LinuxDynamicRHI.cpp"
        fi

        if [[ $IS_KDE_NEON ]] ; then qdbus org.kde.KWin /Compositor suspend ; fi

        if ! ( make ) ; then

            echo ""
            echo "    Making process was Failed!"
            echo ""

            exit 7
        fi

        if [[ $AUTORUN_ARGS ]] ; then exec "Engine/Binaries/Linux/UE4Editor" $AUTORUN_ARGS ; fi

        if [[ $IS_KDE_NEON ]] ; then qdbus org.kde.KWin /Compositor resume ; fi

    popd

popd
