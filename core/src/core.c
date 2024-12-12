#include <stdio.h>

int main() {
    #if defined(__GNUC__)
        printf("Compiler: GCC, Version: %d.%d\n", __GNUC__, __GNUC_MINOR__);
    #elif defined(__clang__)
        printf("Compiler: Clang, Version: %d.%d\n", __clang_major__, __clang_minor__);
    #endif
    return 0;
}
