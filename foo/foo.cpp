#include "foo.h"

FooT foo()
{
	// purposeful memory leak to get valgrind to barf
	// const char* s = new char[5];
	// (void)s;

	//return "error";

    FooT f;
    f.push_back(1);
    f.push_back(2);
    f.push_back(3);

	return f;
}
