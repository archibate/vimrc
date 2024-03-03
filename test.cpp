#include <clocale>
#include <iostream>

int main() {
    std::setlocale(LC_ALL, ".utf8");
    std::string s = "Hello, World!";

    for (size_t i = 0; i < s.size(); i++) {
        std::cout << s[i] << std::endl;
    }
    
    return 0;
}
