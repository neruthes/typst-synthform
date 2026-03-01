#!/bin/bash

function _die() {
    echo "$2" > /dev/stderr
    exit "$1"
}


command -v tomlq || _die 1 "ERROR: Make target 'install_local' requires tomlq"
command -v rsync || _die 1 "ERROR: Make target 'install_local' requires rsync"

export VER="$(tomlq -r .package.version src/typst.toml)"

case "$1" in
    pr | submit)
        universe_dir_pref=../typst-packages-universe/packages/preview/synthform
        universe_dir=../typst-packages-universe/packages/preview/synthform/"$VER"
        [[ -d ../typst-packages-universe ]] &&
        [[ -d "$universe_dir_pref" ]] &&
        # [[ ! -d "$universe_dir" ]] &&
        rsync --dry-run -av ./src/ --exclude components "$universe_dir/" &&
        echo "Seems that we can do this!" &&
        echo '    ' rsync -av ./src/ --exclude components "$universe_dir/"

        ;;
    install_local | i )
        
        rsync -auv --delete --mkpath --exclude components       src/     "$HOME"/.local/share/typst/packages/local/synthform/"$VER"
        ;;
    fast | f)
        ./make.sh install_local
        ;;
    '' )
        ./make.sh fast
        ;;
    * )
        die 1 "WARNING: No rule to make target '$1'"
        ;;
esac
