#!/usr/bin/env bash

set -e

function red() {
    echo -e "\e[00;31m$1\e[00m"
}

./bin/rspec || { red "Failed specs"; exit 1; }
