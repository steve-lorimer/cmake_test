#include <iostream>
#include "version.h"
#include "foo/foo.h"
#include "bar/bar.h"

int main()
{
    std::cout << app_version() << '\n'
              << '\n'
              << "foo: " << foo() << '\n'
              << "bar: " << bar() << '\n';

    return 0;
}
