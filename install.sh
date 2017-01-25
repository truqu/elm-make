#!/bin/sh

# Define the latest version
VERSION="0.18.0-truqu"
readonly VERSION

#####################################################################
# 1. Download to a temporary file
#    GitHub redirects to S3 (-L follows redirects)
# 2. Move & fix exec rights
#####################################################################

function download {
    temp_file=$(mktemp)
    curl -o "$temp_file" -L https://github.com/truqu/elm-make/releases/download/$VERSION/$1.$2.$3
    mkdir -p ${PWD}/.bin
    mv "$temp_file" ${PWD}/.bin/$1
    chmod 755 ${PWD}/.bin/$1
}

case "$(uname -s)" in
    Darwin)
        echo 'Getting macOS version of elm 0.18.0-truqu...'
        download "elm-make" "x86" "darwin"
        download "elm-package" "x86" "darwin"
        download "elm" "x86" "darwin"
        echo 'Done'
        ;;

    Linux)
        echo "Getting Linux $arch version of elm 0.18.0-truqu..."
        download "elm-make" "x86" "linux"
        download "elm-package" "x86" "linux"
        download "elm" "x86" "linux"
        echo "Done"
        ;;

    *)
        echo 'other OS'
        echo 'Not supported ...'
        ;;
    esac
