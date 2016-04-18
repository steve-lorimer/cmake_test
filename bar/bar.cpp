#include "bar.h"
#include "foo/foo.h"

std::string bar()
{
	return foo() + " bar";
}
