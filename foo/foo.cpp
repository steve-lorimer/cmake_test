#include "foo.h"

FooT foo()
{
    // uncomment to test that unused-local-typedefs are an error
    // byte = unsigned char;

    // uncomment to test that memory leaks break the build
	// purposeful memory leak to get valgrind to barf
	// const char* s = new char[5];
	// (void)s;


    FooT f;

    // uncomment to test that failing tests break the build
    // return f;

    f.push_back(1);
    f.push_back(2);
    f.push_back(3);

	return f;
}
