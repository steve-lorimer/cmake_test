#include "bar.h"
#include "foo/foo.h"

std::string bar()
{
    FooT f = foo();

    std::string s;
    for (int i : f)
        s += std::to_string(i);
	return s + " bar";
}
