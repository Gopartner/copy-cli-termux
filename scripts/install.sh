#!/bin/bash

set -e

# Pastikan sedang dalam direktori proyek
PROJECT_DIR=$(dirname "$(realpath "$0")")/..
BIN_DIR="$PROJECT_DIR/bin"
APP_NAME="copy"

# Pastikan bin folder ada
mkdir -p "$BIN_DIR"

# Build program
echo "Mengompilasi program..."
g++ -O2 "$PROJECT_DIR/src/main.cpp" -o "$BIN_DIR/$APP_NAME"

# Instalasi ke lokasi yang sesuai
if [ "$PREFIX" ]; then
    echo "Menginstal ke Termux..."
    cp "$BIN_DIR/$APP_NAME" "$PREFIX/bin/"
else
    echo "Menginstal ke Linux biasa..."
    sudo cp "$BIN_DIR/$APP_NAME" /usr/local/bin/
fi

echo "Instalasi selesai! Gunakan '$APP_NAME' untuk menyalin teks ke clipboard."

