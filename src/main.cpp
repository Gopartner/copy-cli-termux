#include <iostream>
#include <fstream>
#include <sstream>

int main(int argc, char* argv[]) {
    // Cek apakah ada argumen nama file
    if (argc < 2) {
        std::cerr << "Penggunaan: copy <namafile>" << std::endl;
        return 1;
    }

    std::ifstream file(argv[1]);
    if (!file) {
        std::cerr << "File tidak ditemukan: " << argv[1] << std::endl;
        return 1;
    }

    // Membaca isi file
    std::ostringstream buffer;
    buffer << file.rdbuf();
    std::string content = buffer.str();

    // Buka proses untuk `termux-clipboard-set`
    FILE* pipe = popen("termux-clipboard-set", "w");
    if (!pipe) {
        std::cerr << "Gagal membuka pipe ke termux-clipboard-set." << std::endl;
        return 1;
    }

    // Kirim isi file ke `termux-clipboard-set`
    fwrite(content.c_str(), sizeof(char), content.size(), pipe);
    pclose(pipe);

    std::cout << "Isi file '" << argv[1] << "' telah disalin ke clipboard." << std::endl;
    return 0;
}

