#include <cstdio>

[[nodiscard]] int func();

int main() {
    if (1) {
        func();
    }
    return 0;
}
