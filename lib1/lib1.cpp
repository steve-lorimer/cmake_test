#include "lib1.h"

std::string lib1()
{
	// purposeful memory leak to get valgrind to barf
	const char* s = new char[5];
	(void)s;

	return "lib1";
}
