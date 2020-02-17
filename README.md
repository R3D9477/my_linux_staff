# my_linux_staff
set of scripts and some workarounds to keep life easier

## What is it?

Just a set of script to install automate installation of some useful software and automate some workarounds for KDE Plasma.

## Helpers/Workarounds

* [nvidia_maxperf.sh](helpers_workarounds/nvidia_maxperf.sh) -- add it to "Autostart" to get always your Nvidia in max perfomance mode

* [plasma_fix_after_suspending.sh](helpers_workarounds/plasma_fix_after_suspending.sh) -- add it to "Autostart" to avoid some of annoying trouble after system was suspended and woked up:
  * Plasma -- destop artefacts after system woke up (actual for Plasma 5.16 and oldest)
  * [SmartVideoWallpaper](https://store.kde.org/p/1316299/) -- avoid annoying transition (black screen) in video loop playback after system woke up, even option "Use double player" already checked
  * kwin -- freezes while OpenGL/Vulkan application is running after system woke up
  * Qt applications -- artefacts with some Qt applications after system woke up (like Latte-Dock, Viber, MellowPlayer, etc)

* [plasma_game_after_stop.sh](helpers_workarounds/plasma_game_after_stop.sh) -- launch it before game (or other "heavy" to GPU application) has been started to avoid:
  * Plasma Dekstop shortcuts -- can be moved and mixed on your desktop when application in "FullScreen" mode have a differen screen resolution than your current desktop
  * kwin -- freezes while OpenGL/Vulkan application is running after system woke up
  * non-US keyboard layout -- a lot of games and applications (like Unreal Engine 4) requires US keyboard layout, and switching to it sometimes is problematic while that application already started; so, better to do it before apllication has been started

* [plasma_game_after_stop.sh](helpers_workarounds/plasma_game_after_stop.sh) -- launch it after game (or other "heavy" to GPU application) has been stopped to avoid:
  * Plasma Dekstop Chortcuts -- they can be moved and mixed on your desktop when application in "FullScreen" mode have a differen screen resolution than your current desktop

## Installers

* [install](soft_install/install) -- base installation script, required by all installers; provies some of installation functions (local and remote packages) and environment variables
* [install_gpu_nvidia.sh](soft_install/install_gpu_nvidia.sh) -- automatic installation of Nvidia drivers (by default latest LTS version)
* [install_systools.sh](soft_install/install_systools.sh) -- automatic installation of some of useful tools and libraries to manage your system
* [install_kwin-lowlatency.sh](soft_install/install_kwin-lowlatency.sh) -- automatic making and installation of [kwin-lowlatency](https://github.com/tildearrow/kwin-lowlatency)
* [install_usertools.sh](soft_install/install_tools.sh) -- automatic installation of some of usefull tools for dekstop like messengers, office packages, etc.
* [install_virt.sh](soft_install/install_devtools.sh) -- automatic installation of some of virtualization systems to run software of different platforms
* [install_win.sh](soft_install/install_win.sh) -- automatic installation of tools to run games and Windows-applications
* [install_graphictools.sh](soft_install/install_graphictools.sh) -- automation installation of some of graphic-development tools
* [install_UnrealEngine4.sh](soft_install/install_UnrealEngine4.sh) -- automatic making and installation of latest [Unreal Engine 4](https://github.com/EpicGames/UnrealEngine)
