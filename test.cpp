#include <clocale>
#include <cwchar>
#include <cstdio>
#include <iostream>

int main() {
    std::setlocale(LC_ALL, "");
    /* std::ios::sync_with_stdio(false); */
    /* std::fwide(stdout, 1); */
    std::wcout << L"宽你好，世界" << std::endl;
    std::cout << "窄你好，世界" << std::endl;
    std::wprintf(L"宽老你好，世界\n");
    std::printf("窄老你好，世界\n");
    return 0;
}
