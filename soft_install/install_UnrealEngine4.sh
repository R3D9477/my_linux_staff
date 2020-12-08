#!/bin/bash

SCRIPT_SRC_DIR="$(dirname "$(realpath -s "$0")")"
source "$SCRIPT_SRC_DIR/install"

#------------------------------------------------------------------------------------------------------

exportdefvar TARGET_DIR         "$HOME"

exportdefvar GIT_USER           ""
exportdefvar GIT_PASS           ""
exportdefvar GIT_REPO           "github.com/EpicGames/UnrealEngine.git"
exportdefvar GIT_BRANCH         "release"

exportdefvar SKIP_DEPS          ""
exportdefvar ENABLE_OPENGL      n
exportdefvar DELETE_IF_EXISTS   n
exportdefvar GIT_RESET          n
exportdefvar SDK_RESET          n
exportdefvar CLEAN_BUILD        n
exportdefvar CLEAN_RELEASE      y
exportdefvar AUTORUN_EDITOR     y
exportdefvar AUTORUN_ARGS       ""

#------------------------------------------------------------------------------------------------------

if ! [[ $SKIP_DEPS ]] ; then

  #  update_system

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

    # FIX for: Engine/Binaries/Linux/UE4Editor: error while loading shared libraries: libfbxsdk.so: cannot open shared object file: No such file or directory
    bash "${SCRIPT_SRC_DIR}/install_fbxsdk.sh"
fi

if ! pushd "$TARGET_DIR" ; then

    show_message "Target dir is not exists!"
    goto_exit 2
fi
    show_message "Installation path: $TARGET_DIR/UnrealEngine-$GIT_BRANCH"

    if [ -d "UnrealEngine-$GIT_BRANCH" ] ; then
        if [[ $DELETE_IF_EXISTS == "y" ]] ; then

            show_message "Remove existing sources and do a clean install: UnrealEngine-$GIT_BRANCH"

            rm -rf "UnrealEngine-$GIT_BRANCH"

        else

            show_message " Update existing sources: UnrealEngine-$GIT_BRANCH"
            show_message " Source URL: https://$GIT_USER:$GIT_PASS@$GIT_REPO"

            pushd "UnrealEngine-$GIT_BRANCH"

                if [[ $GIT_RESET == "y" ]] ; then
                    git init
                    git remote remove origin
                    git remote add origin "https://$GIT_USER:$GIT_PASS@$GIT_REPO"
                    git fetch origin
                    git submodule foreach --recursive "git clean -dfx"
                    git clean -dfx
                    git submodule foreach --recursive "git reset --hard HEAD"
                    git reset --hard origin/$GIT_BRANCH
                    git pull origin $GIT_BRANCH
                fi

                if [[ $SDK_RESET == "y" ]] ; then
                    rm -rf "Engine/Extras/ThirdPartyNotUE/SDKs"
                    rm -rf ".git/ue4-gitdeps"
                    rm -rf ".git/ue4-sdks"
                fi
            popd
        fi
    fi

    if ! [ -d "UnrealEngine-$GIT_BRANCH" ] ; then
        if ! ( git clone -b "$GIT_BRANCH" --single-branch "https://$GIT_USER:$GIT_PASS@$GIT_REPO" "UnrealEngine-$GIT_BRANCH" ) ; then

            show_message "Can't clone UnrealEngine from remote branch!"
            goto_exit 3
        fi
    fi

    pushd "UnrealEngine-$GIT_BRANCH"

        # parse file and print version
        # /Engine/Build/Build.version

        if [[ $MAKEONLY != "y" ]] ; then

            rm ".git/index.lock"
            if ! ( git checkout "$GIT_BRANCH" ) ; then

                show_message "Can't switch to $GIT_BRANCH branch!"
                goto_exit 4
            fi

            # don't use curl to avoid:
            #Installing a bundled clang toolchain
            #Downloading toolchain: http://cdn.unrealengine.com/Toolchain_Linux/native-linux-v16_clang-9.0.1-centos7.tar.gz
            #% Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
            #                                Dload  Upload   Total   Spent    Left  Speed
            #0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
            #Extracting toolchain.
            #tar: This does not look like a tar archive
            #gzip: stdin: unexpected end of file
            #tar: Child returned status 1
            #tar: Error is not recoverable: exiting now
            sed -i "s#if which curl 1>/dev/null; then#if [ '' ] ; then#g" "Engine/Build/BatchFiles/Linux/SetupToolchain.sh"

            if ! ( eval "echo y | ./Setup.sh" ) ; then

                show_message "Setup was Failed!"
                goto_exit 5
            fi

            sleep 3s ; sync

            if ! ( ./GenerateProjectFiles.sh ) ; then

                show_message "GenerateProjectFiles was Failed!"
                goto_exit 6
            fi

            sleep 3s ; sync

        else show_message "Make only!" ; fi

        if [[ $ENABLE_OPENGL == "y" ]] ; then

            # enable OpenGL target
            sed -i 's/.*;.*+TargetedRHIs=GLSL_430/+TargetedRHIs=GLSL_430/g' "Engine/Config/BaseEngine.ini"

            # disable warning
            sed -i 's/FMessageDialog.*LinuxDynamicRHI.*OpenGLDeprecated.*OpenGL.*deprecated.*;//g' "Engine/Source/Runtime/RHI/Private/Linux/LinuxDynamicRHI.cpp"
        fi

        if [[ $IS_KDE ]] ; then qdbus org.kde.KWin /Compositor suspend ; fi

        TC_VER=`realpath Engine/Extras/ThirdPartyNotUE/SDKs/HostLinux/Linux_x64/v*clang*`/ToolchainVersion.txt
        if ! [ -f "$TC_VER" ] ; then echo `ls Engine/Extras/ThirdPartyNotUE/SDKs/HostLinux/Linux_x64` > "$TC_VER" ; fi

        if [[ $CLEAN_BUILD == "y" ]] ; then make ARGS=-clean ; fi

        if ! ( make ) ; then

            show_message "Making process was Failed!"
            goto_exit 7
        fi

        if ! ( make ShaderCompileWorker ) ; then

            show_message "Making process was Failed!"
            goto_exit 8
        fi

        if [[ $CLEAN_RELEASE == "y" ]] ; then

            show_message "Remove Intermidiate Files..."

            #rm -rf "$TARGET_DIR/UnrealEngine-$GIT_BRANCH/.git"
            #rm -rf "$TARGET_DIR/UnrealEngine-$GIT_BRANCH/Engine/Source"
            #rm -rf "$TARGET_DIR/UnrealEngine-$GIT_BRANCH/Engine/Intermidiate"
        fi

        echo "#!/usr/bin/env xdg-open
[Desktop Entry]
Name=UE4Editor
Comment=Unreal Engine 4 Editor
Exec=$TARGET_DIR/UnrealEngine-$GIT_BRANCH/Engine/Binaries/Linux/UE4Editor
Icon=$TARGET_DIR/UnrealEngine-$GIT_BRANCH/Engine/Content/Slate/Testing/UE4Icon.png
Terminal=false
Type=Application
Categories=Game" | tee "$DESKTOP_PATH/UE4Editor.desktop"
        chmod +x "$DESKTOP_PATH/UE4Editor.desktop"

        if [[ $ENABLE_OPENGL == "y" ]] ; then

            echo "#!/usr/bin/env xdg-open
[Desktop Entry]
Name=UE4Editor (OpenGL)
Comment=Unreal Engine 4 Editor (OpenGL)
Exec=$TARGET_DIR/UnrealEngine-$GIT_BRANCH/Engine/Binaries/Linux/UE4Editor -opengl4
Icon=$TARGET_DIR/UnrealEngine-$GIT_BRANCH/Engine/Content/Slate/Testing/UE4Icon.png
Terminal=false
Type=Application
Categories=Game" | tee "$DESKTOP_PATH/UE4EditorOGL.desktop"
            chmod +x "$DESKTOP_PATH/UE4EditorOGL.desktop"

            if ! [[ "$AUTORUN_ARGS" =~ "-opengl4" ]] && ! [[ "$AUTORUN_ARGS" =~ "-vulkan" ]] ; then
                export AUTORUN_ARGS="-opengl4 $AUTORUN_ARGS"
            fi
        fi

        if [[ $IS_KDE ]] ; then qdbus org.kde.KWin /Compositor resume ; fi

        if [[ $AUTORUN_EDITOR == "y" ]] ; then exec "Engine/Binaries/Linux/UE4Editor" $AUTORUN_ARGS ; fi

    popd

popd
