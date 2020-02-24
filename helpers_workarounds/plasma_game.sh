#!/bin/bash

SCRIPT_SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "$SCRIPT_SRC_DIR/install"

#--------------------------------------------------------------------------------------------------

"$SCRIPT_SRC_DIR/plasma_game_before_start.sh"

bash -c "$@"

"$SCRIPT_SRC_DIR/plasma_game_after_stop.sh"
