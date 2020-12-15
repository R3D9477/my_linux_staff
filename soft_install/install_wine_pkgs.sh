#!/bin/bash

SCRIPT_SRC_DIR="$(dirname "$(realpath -s "$0")")"
source "$SCRIPT_SRC_DIR/install"

#------------------------------------------------------------------------------------------------------

exportdefvar WINEPREFIX "${HOME}/.wine32"
exportdefvar WINEARCH   "win32"

rm -rf ~/.wine
rm -rf ~/.wine32

function wt() {
    echo ""
    echo "    winetricks $@"
    echo ""
    winetricks -q $@
}

#wt win10

#ln -s "${HOME}/.wine32" "${HOME}/.wine"

wt ie6
wt ie7
wt ie8
# wt ie8_kb2936068 # freezes at the end

#wt cmd
## wt setupapi # 00c4:fixme:wintrust:WinVerifyTrust unimplemented for 4
## wt crypt32  # 00c4:fixme:wintrust:WinVerifyTrust unimplemented for 4
#wt secur32
#t winhttp
#wt wininet
#wt webio

## wt msxml3 # failed
#wt msxml4
#wt msxml6

#wt mfc40
#wt mfc42

#wt vb2run
#wt vb3run
#wt vb4run
#wt vb5run
#wt vb6run

#wt vcrun6
#wt vcrun6sp6

wt vcrun2003
wt vcrun2005
wt vcrun2008
wt vcrun2010
wt vcrun2012
wt vcrun2013
# wt vcrun2016 # unknown vcrun2016
wt vcrun2017

wt winxp
wt wmp10 # requires winxp
wt windowscodecs # requires winxp

wt win10

wt d3dx9
wt d3dx10
wt d3dx11_43

wt dotnet20
wt dotnet20sp1
wt dotnet20sp2
wt dotnet30
wt dotnet30sp1
wt dotnet35
wt dotnet35sp1
wt dotnet40
wt dotnet45
wt dotnet452
wt dotnet46
wt dotnet461
wt dotnet462

exit 0

#--------------------------------------------------------------------------------------------------

if [ -d "${HOME}/.wine" ] && ! [ -d "${HOME}/.wine64" ] ; then mv "${HOME}/.wine" "${HOME}/.wine64" ; fi

export WINEPREFIX="${HOME}/.wine32"
export WINEARCH="win32"

winetricks win10

ln -s "${HOME}/.wine32" "${HOME}/.wine"

winetricks cmd
# winetricks setupapi # 00c4:fixme:wintrust:WinVerifyTrust unimplemented for 4
# winetricks crypt32  # 00c4:fixme:wintrust:WinVerifyTrust unimplemented for 4
winetricks secur32
winetricks winhttp
winetricks wininet
winetricks webio

# winetricks msxml3 # failed
winetricks msxml4
winetricks msxml6

winetricks mfc40
winetricks mfc42

winetricks vb2run
winetricks vb3run
winetricks vb4run
winetricks vb5run
winetricks vb6run

winetricks vcrun6
winetricks vcrun6sp6

winetricks vcrun2003
winetricks vcrun2005
winetricks vcrun2008
winetricks vcrun2010
winetricks vcrun2012
winetricks vcrun2013
# winetricks vcrun2016 # unknown vcrun2016
winetricks vcrun2017

winetricks ie6
winetricks ie7
# winetricks ie8
# winetricks ie8_kb2936068 # freezes at the end

winetricks wmp10
winetricks windowscodecs

winetricks d3dx9
winetricks d3dx10
winetricks d3dx11_43

winetricks dotnet20sp2
winetricks dotnet462

winetricks winetricks win10
