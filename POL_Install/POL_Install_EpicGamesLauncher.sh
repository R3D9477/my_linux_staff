#!/bin/bash
# Date : (12-06-2020)
# Distribution used to test : Ubuntu 20.04 x64
# Author : r3d9u11
# Licence : WTFPLv2
# PlayOnLinux: 4.3.4

source "$PLAYONLINUX/lib/sources"

ARCH="x64"
PREFIX="EpicGamesLauncher"
WINEVERSION="5.22-staging"
TITLE="Epic Games Laucnher"
GAME_URL="https://www.playonlinux.com/"
EDITOR=""
AUTHOR=""

#------------------------------------------------------------------------------------------------------

SCRIPT_SRC_DIR="$(dirname "$(realpath -s "$0")")"
source "$SCRIPT_SRC_DIR/install_POL"

#------------------------------------------------------------------------------------------------------

#Initialization
POL_SetupWindow_Init
POL_SetupWindow_SetID 3251

POL_Debug_Init

# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Create prefix and temporary download folder
POL_System_SetArch    "$ARCH"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
POL_System_TmpCreate  "$PREFIX"

Set_OS "win7"

POL_SetupWindow_wait "Install: vcredist 2010 - 2019"
POL_download_and_install "https://download.microsoft.com/download/3/2/2/3224B87F-CFA0-4E70-BDA3-3DE650EFEBA5/vcredist_x64.exe"          "vcredist_2010_x64.exe"
POL_download_and_install "https://download.microsoft.com/download/E/C/C/ECCD0A46-78BF-4580-804C-CE0B61CF921E/VSU4/vcredist_x64.exe"     "vcredist_2012_x64.exe"
POL_download_and_install "https://download.microsoft.com/download/4/9/B/49BAC912-B6EF-4A34-A17C-06673338A7FC/vcredist_x64.exe"          "vcredist_2013_x64.exe"
POL_download_and_install "https://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/vc_redist.x64.exe"         "vcredist_2015_x64.exe"
POL_download_and_install "https://aka.ms/vs/16/release/vc_redist.x64.exe"                                                               "vcredist_2019_x64.exe"

POL_SetupWindow_wait "Install: msxml 3.0 - 6.0"
POL_download_and_install "https://download.microsoft.com/download/3/1/a/31aa8e2d-fc46-46fb-bbdf-25c7c60eaf8b/msxml6_x64.msi"            "msxml3_x64.msi"
POL_download_and_install "https://download.microsoft.com/download/A/2/D/A2D8587D-0027-4217-9DAD-38AFDB0A177E/msxml.msi"                 "msxml4_x64.msi"
POL_download_and_install "https://download.microsoft.com/download/3/1/a/31aa8e2d-fc46-46fb-bbdf-25c7c60eaf8b/msxml6_x64.msi"            "msxml6_x64.msi"

POL_SetupWindow_wait "Install: Internet Explorer 6"
POL_Call POL_Install_vcrun6
POL_winetricks_install ie6 #POL_Call POL_Install_ie6 <-- DOESN'T WORK
POL_Wine_OverrideDLL builtin urlmon

Set_OS "win7"

POL_SetupWindow_wait "Install: POL packages"
POL_Call POL_Install_corefonts
POL_Call POL_Install_tahoma
POL_Call POL_Install_tahoma2
POL_Call POL_Install_FontsSmoothRGB
POL_Call POL_Install_gecko
POL_Call POL_Install_gdiplus
POL_Call POL_Install_riched20
POL_Call POL_Install_riched30
POL_Call POL_Install_mspatcha

POL_Wine_OverrideDLL "native,builtin" "riched20"
POL_Wine_OverrideDLL "native,builtin" "riched30"
POL_Wine_OverrideDLL "native,builtin" "gdiplus"

POL_Call POL_Install_d3dx9
POL_Call POL_Install_directx9
POL_Call POL_Install_dxfullsetup
POL_Call POL_Install_d3dx10
POL_Call POL_Install_d3dx11

POL_SetupWindow_wait "Install: .Net 2.0 SP2"
POL_Wine uninstaller --remove '{E45D8920-A758-4088-B6C6-31DBB276992E}' || true
POL_winetricks_install dotnet20
POL_winetricks_install dotnet20sp1
POL_winetricks_install dotnet20sp2

Set_OS "win10"

POL_Wine_OverrideDLL "native,builtin" "dnsapi"
POL_Wine_OverrideDLL "native,builtin" "netapi32"

POL_SetupWindow_wait "Install: Epic Games Launcher"
POL_download_and_install "https://launcher-public-service-prod06.ol.epicgames.com/launcher/api/installer/download/EpicGamesLauncherInstaller.msi" "EpicGamesLauncherInstaller.msi" -SkipBuildPatchPrereq

# All done
POL_Wine_WaitBefore "$TITLE"
POL_Shortcut "EpicGamesLauncher.exe" "Epic Games Launcher"
POL_System_TmpDelete
POL_SetupWindow_message "ALL DONE!"
POL_SetupWindow_Close

exit 0
