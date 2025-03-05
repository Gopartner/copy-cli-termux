#!/bin/bash

# Pastikan skrip berhenti jika ada kesalahan
set -e

# Nama aplikasi
APP_NAME="copy"

# Direktori proyek
PROJECT_DIR=$(dirname "$(realpath "$0")")/..
SRC_DIR="$PROJECT_DIR/src"
BIN_DIR="$PROJECT_DIR/bin"

# Pastikan bin folder ada
mkdir -p "$BIN_DIR"

# Fungsi untuk mode pengembangan
run_dev() {
    echo "Menjalankan dalam mode pengembangan..."
    g++ -g "$SRC_DIR/main.cpp" -o "$BIN_DIR/$APP_NAME"
    "$BIN_DIR/$APP_NAME" test.txt  # Contoh menjalankan dengan file test.txt
}

# Fungsi untuk build
run_build() {
    echo "Membangun proyek..."
    g++ -O2 "$SRC_DIR/main.cpp" -o "$BIN_DIR/$APP_NAME"
    echo "Build selesai. File output ada di $BIN_DIR/$APP_NAME"
}

# Fungsi untuk deploy
run_deploy() {
    echo "Membuat rilis dan mengunggah ke Git..."
    run_build
    cp "$BIN_DIR/$APP_NAME" /usr/local/bin/ 2>/dev/null || cp "$BIN_DIR/$APP_NAME" $PREFIX/bin/
    echo "Aplikasi '$APP_NAME' telah diinstal secara global."

    git add .
    git commit -m "Deploy versi terbaru"
    git push origin main
}

# Menjalankan perintah berdasarkan argumen
case "$1" in
    dev) run_dev ;;
    build) run_build ;;
    deploy) run_deploy ;;
    *) echo "Gunakan: $0 {dev|build|deploy}" ;;
esac

