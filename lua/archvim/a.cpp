// Copyright 2022 archibate
#include <cstdint>
#include <cstdio>

int func1();

int main() {
    if (1) {
        int64_t x = func1();
    }
    return 0;
}
