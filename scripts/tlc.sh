#!/bin/bash

tlc() {
    local input="$1"
    local output="${input,,}"
    echo "$output"
}

# Passando o primeiro argumento da linha de comando para a função
tlc "$1"

