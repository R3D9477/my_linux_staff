#!/bin/bash

SCRIPT_SRC_DIR="$(dirname "$(realpath -s "$0")")"
source "$SCRIPT_SRC_DIR/install"

#------------------------------------------------------------------------------------------------------

exportdefvar TARGET_DIR         "${HOME}"

exportdefvar GIT_USER           ""
exportdefvar GIT_PASS           ""
exportdefvar GIT_REPO           "github.com/EpicGames/UnrealEngine.git"
exportdefvar GIT_BRANCH         "release"
exportdefvar GIT_REVISION       ""

exportdefvar SKIP_DEPS          n
exportdefvar ANDROID_SUPPORT    y
exportdefvar ENABLE_OPENGL      n
exportdefvar DELETE_IF_EXISTS   y
exportdefvar GIT_RESET          y
exportdefvar SDK_RESET          y
exportdefvar ADD_UE4GITPLUGIN   y
exportdefvar CLEAN_BUILD        n
exportdefvar FINAL_RM_GIT       y
exportdefvar FINAL_RM_IMT       y
exportdefvar FINAL_RM_MAC       y
exportdefvar FINAL_RM_WIN       y
exportdefvar AUTORUN_EDITOR     y
exportdefvar AUTORUN_ARGS       ""

#------------------------------------------------------------------------------------------------------

if [[ $SKIP_DEPS != "y" ]] ; then

  #  update_system

    install_lpkg                \
        wget                    \
        clang                   \
        cmake                   \
        build-essential         \
        mono-complete           \
        mono-devel              \
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

if ! pushd "${TARGET_DIR}" ; then

    show_message "Target dir is not exists!"
    goto_exit 2
fi
    show_message "Installation path: ${TARGET_DIR}/UnrealEngine-${GIT_BRANCH}"

    if [ -d "UnrealEngine-${GIT_BRANCH}" ] ; then
        if [[ ${DELETE_IF_EXISTS} == "y" ]] ; then

            show_message "Remove existing sources and do a clean install: UnrealEngine-${GIT_BRANCH}"

            rm -rf "UnrealEngine-${GIT_BRANCH}"

        else

            show_message " Update existing sources: UnrealEngine-${GIT_BRANCH}"
            show_message " Source URL: https://${GIT_USER}:@${GIT_REPO}"

            pushd "UnrealEngine-${GIT_BRANCH}"

                if [[ ${GIT_RESET} == "y" ]] ; then
                    git init
                    git remote remove origin
                    git remote add origin "https://${GIT_USER}:${GIT_PASS}@${GIT_REPO}"
                    git fetch origin
                    git submodule foreach --recursive "git clean -dfx"
                    git clean -dfx
                    git submodule foreach --recursive "git reset --hard HEAD"
                    git reset --hard origin/${GIT_BRANCH}
                    git pull origin ${GIT_BRANCH}
                fi

                if [[ ${SDK_RESET} == "y" ]] ; then
                    rm -rf "Engine/Extras/ThirdPartyNotUE/SDKs"
                    rm -rf ".git/ue4-gitdeps"
                    rm -rf ".git/ue4-sdks"
                fi
            popd
        fi
    fi

    if ! [ -d "UnrealEngine-${GIT_BRANCH}" ] ; then
        git clone --depth 1 --single-branch -b "${GIT_BRANCH}" "https://${GIT_USER}:${GIT_PASS}@${GIT_REPO}" "UnrealEngine-${GIT_BRANCH}"
    fi

    pushd "UnrealEngine-${GIT_BRANCH}"

        # parse file and print version
        # /Engine/Build/Build.version

        if [[ $MAKEONLY != "y" ]] ; then

            rm ".git/index.lock"
            sed -i "s#if which curl 1>/dev/null; then#if [ '' ] ; then#g" "Engine/Build/BatchFiles/Linux/SetupToolchain.sh"

            if ! ( eval "echo y | ./Setup.sh" ) ; then

                show_message "Setup was Failed!"
                goto_exit 6
            fi

            sleep 3s ; sync

            if ! ( ./GenerateProjectFiles.sh ) ; then

                show_message "GenerateProjectFiles was Failed!"
                goto_exit 7
            fi

            sleep 3s ; sync

        else show_message "Make only!" ; fi

        if [[ ${ENABLE_OPENGL} == "y" ]] ; then

            # enable OpenGL target
            sed -i 's/.*;.*+TargetedRHIs=GLSL_430/+TargetedRHIs=GLSL_430/g' "Engine/Config/BaseEngine.ini"

            # disable warning
            sed -i 's/FMessageDialog.*LinuxDynamicRHI.*OpenGLDeprecated.*OpenGL.*deprecated.*;//g' "Engine/Source/Runtime/RHI/Private/Linux/LinuxDynamicRHI.cpp"
        fi

        if [[ ${ADD_UE4GITPLUGIN} == "y" ]] ; then
            pushd "Engine/Plugins/Developer"
                rm -rf "GitSourceControl"
                git clone "https://github.com/SRombauts/UE4GitPlugin.git" "GitSourceControl"
                # DISABLE HOT-RELOADING FEATURE
                sed -i 's/UPackageTools::ReloadPackages/\/\/&/' "GitSourceControl/Source/GitSourceControl/Private/GitSourceControlMenu.cpp"
            popd
        fi

        if [[ ${IS_KDE} ]] ; then qdbus org.kde.KWin /Compositor suspend ; fi

        TC_VER=`realpath Engine/Extras/ThirdPartyNotUE/SDKs/HostLinux/Linux_x64/v*clang*`/ToolchainVersion.txt
        if ! [ -f "${TC_VER}" ] ; then echo `ls "Engine/Extras/ThirdPartyNotUE/SDKs/HostLinux/Linux_x64"` > "${TC_VER}" ; fi

        if [[ $CLEAN_BUILD == "y" ]] ; then make ARGS=-clean ; fi

        if ! ( make ) ; then

            show_message "Making process was Failed!"
            goto_exit 8
        fi

        if ! ( make ShaderCompileWorker ) ; then

            show_message "Making process was Failed!"
            goto_exit 9
        fi

        chmod +x "Engine/Binaries/Linux/UE4Editor"

        if [[ ${ANDROID_SUPPORT} == "y" ]] ; then
            pushd "$SCRIPT_SRC_DIR"
                ./install_tools_dev_android.sh
            popd
            if ! [ -d "${HOME}/android-studio" ] ; then
                ANDROID_STUDIO_DIR=`realpath /opt/android-studio*/android-studio`
                if [ -d "${ANDROID_STUDIO_DIR}" ] ; then
                    ln -s "${ANDROID_STUDIO_DIR}" "${HOME}/android-studio"
                fi
            fi
            pushd "Engine/Extras/Android"
                ./SetupAndroid.sh
            popd
        fi

        if [[ ${FINAL_RM_GIT} == "y" ]] ; then rm -rf ".git" ; fi

        if [[ ${FINAL_RM_IMT} == "y" ]] ; then rm -rf "Engine/Intermidiate" ; fi

        function rm_by_mask() {
            find "$1" -type d -iname "$2" -exec sh -c 'x=$(realpath "{}"); rm -rf "$x";' \;
        }

        if [[ ${FINAL_RM_MAC} == "y" ]] ; then
            rm_by_mask "Engine/Binaries"            "mac"
            rm_by_mask "Engine/Binaries"            "ios"
            rm_by_mask "Engine/Source/ThirdParty"   "mac"
            rm_by_mask "Engine/Source/ThirdParty"   "ios"
        fi

        if [[ $FINAL_RM_WIN == "y" ]] ; then
            rm_by_mask "Engine/Binaries"            "windows"
            rm_by_mask "Engine/Binaries"            "win32"
            rm_by_mask "Engine/Binaries"            "win64"
            rm_by_mask "Engine/Source/ThirdParty"   "windows"
            rm_by_mask "Engine/Source/ThirdParty"   "win32"
            rm_by_mask "Engine/Source/ThirdParty"   "win64"
            rm_by_mask "Engine/Plugins"             "windows"
            rm_by_mask "Engine/Plugins"             "win32"
            rm_by_mask "Engine/Plugins"             "win64"
        fi

        echo "#!/usr/bin/env xdg-open
[Desktop Entry]
Name=UE4Editor
Comment=Unreal Engine 4 Editor
Exec=${TARGET_DIR}/UnrealEngine-${GIT_BRANCH}/Engine/Binaries/Linux/UE4Editor
Icon=${TARGET_DIR}/UnrealEngine-${GIT_BRANCH}/Engine/Content/Slate/Testing/UE4Icon.png
Terminal=false
Type=Application
Categories=Development;Games" | tee "${DESKTOP_DIR}/UE4Editor.desktop"
        chmod +x "${DESKTOP_DIR}/UE4Editor.desktop"

        if [[ ${ENABLE_OPENGL} == "y" ]] ; then

            echo "#!/usr/bin/env xdg-open
[Desktop Entry]
Name=UE4Editor (OpenGL)
Comment=Unreal Engine 4 Editor (OpenGL)
Exec=${TARGET_DIR}/UnrealEngine-${GIT_BRANCH}/Engine/Binaries/Linux/UE4Editor -opengl4
Icon=${TARGET_DIR}/UnrealEngine-${GIT_BRANCH}/Engine/Content/Slate/Testing/UE4Icon.png
Terminal=false
Type=Application
Categories=Development;Games" | tee "${DESKTOP_DIR}/UE4EditorOGL.desktop"
            chmod +x "${DESKTOP_DIR}/UE4EditorOGL.desktop"

            if ! [[ "${AUTORUN_ARGS}" =~ "-opengl4" ]] && ! [[ "${AUTORUN_ARGS}" =~ "-vulkan" ]] ; then
                export AUTORUN_ARGS="-opengl4 ${AUTORUN_ARGS}"
            fi
        fi

        if [[ ${IS_KDE} ]] ; then qdbus org.kde.KWin /Compositor resume ; fi

        if [[ ${AUTORUN_EDITOR} == "y" ]] ; then eval "Engine/Binaries/Linux/UE4Editor ${AUTORUN_ARGS}" ; fi

    popd

popd
