#!/bin/bash
# Date : (12-07-2020)
# Distribution used to test : Ubuntu 20.04 x64
# Author : r3dnu77
# Licence : WFTPLv2
# PlayOnLinux: 4.3.4

# Adobe links:
# https://prodesigntools.com/adobe-cc-2019-direct-download-links.html

# Based on RoninDusette's script
# from https://www.playonlinux.com/en/app-2316-Adobe_Photoshop_CS6.html

source "$PLAYONLINUX/lib/sources"

ARCH="x86"
PREFIX="CreativeCloud2019"
WINEVERSION="5.22-staging"
TITLE="Adobe Creative Cloud"
EDITOR="Adobe Systems Inc."
GAME_URL="http://www.adobe.com"
AUTHOR="r3dnu77"

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
download_and_install "https://download.microsoft.com/download/5/B/C/5BC5DBB3-652D-4DCE-B14A-475AB85EEF6E/vcredist_x86.exe"          "vcredist_2010_x86.exe"
download_and_install "https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe"    "vcredist_2012_x86.exe"
download_and_install "https://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x86.exe"          "vcredist_2013_x86.exe"
download_and_install "https://download.microsoft.com/download/0/6/4/064F84EA-D1DB-4EAA-9A5C-CC2F0FF6A638/vc_redist.x86.exe"         "vcredist_2015_x86.exe"
download_and_install "https://aka.ms/vs/16/release/vc_redist.x86.exe"                                                               "vcredist_2019_x86.exe"

POL_SetupWindow_wait "Install: msxml 3.0 - 6.0"
download_and_install "https://download.microsoft.com/download/9/8/b/98b7efee-20c6-4cab-9ce0-6587280644d5/xmlsdk.msi"                "msxml3_x86.msi"
download_and_install "https://download.microsoft.com/download/A/2/D/A2D8587D-0027-4217-9DAD-38AFDB0A177E/msxml.msi"                 "msxml4_x86.msi"
download_and_install "https://download.microsoft.com/download/e/a/f/eafb8ee7-667d-4e30-bb39-4694b5b3006f/msxml6_x86.msi"            "msxml6_x86.msi"

POL_SetupWindow_wait "Install: Internet Explorer 6"
POL_Call POL_Install_vcrun6
winetricks_install ie6 #POL_Call POL_Install_ie6 <-- DOESN'T WORK
POL_Wine_OverrideDLL builtin urlmon

Set_OS "win7"

POL_SetupWindow_wait "Install: Internet Explorer 11"
download_and_install "https://download.microsoft.com/download/9/0/8/908B5C6B-F23E-4DED-9906-77CE4E9E8528/EIE11_EN-US_MCM_WIN7.EXE"

POL_SetupWindow_wait "Install: POL packages"
POL_Call POL_Install_AdobeAir
POL_Call POL_Install_flashplayer
POL_Call POL_Install_atmlib
POL_Call POL_Install_corefonts
POL_Call POL_Install_tahoma
POL_Call POL_Install_tahoma2
POL_Call POL_Install_FontsSmoothRGB
POL_Call POL_Install_gdiplus

Set_OS "win7"

#POL_SetupWindow_wait "Install: Creative Cloud"
#download_and_install "https://ccmdl.adobe.com/AdobeProducts/KCCC/CCD/4_9/win32/ACCCx4_9_0_504.zip" "Set-up.exe"

POL_SetupWindow_wait "Install: AI2019"
download_and_install "http://prdl-download.adobe.com/Illustrator/160936BD5B104622BB9B90349EE49E5F/1546591230620/AdobeIllustrator23_HD_win32.zip" "Set-up.exe"

# All done
#POL_Wine_WaitBefore "$TITLE"
#POL_Shortcut "Creative Cloud.exe" "Adobe Creative Cloud"
#POL_System_TmpDelete
POL_SetupWindow_message "ALL DONE !"
POL_SetupWindow_Close

exit 0
