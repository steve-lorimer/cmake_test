#include <iostream>
#include "version.h"
#include "lib1/lib1.h"
#include "lib2/lib2.h"

int main()
{
    std::cout << app_version() << '\n'
              << '\n'
              << "lib1: " << lib1() << '\n'
              << "lib2: " << lib2() << '\n';

    return 0;
}
