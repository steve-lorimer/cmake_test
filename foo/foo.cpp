#include "foo.h"

std::string foo()
{
	// purposeful memory leak to get valgrind to barf
	// const char* s = new char[5];
	// (void)s;

	//return "error";
	return "foo";
}
