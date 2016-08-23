#define BOOST_TEST_MAIN
#include <boost/test/included/unit_test.hpp>
#include <boost/test/unit_test.hpp>
#include "foo/foo.h"

BOOST_AUTO_TEST_CASE(foo_test)
{
    std::cout << "testing foo\n";

    FooT f = foo();

    BOOST_REQUIRE_EQUAL(f.size(), 3);
    BOOST_REQUIRE_EQUAL(f[0], 1);
    BOOST_REQUIRE_EQUAL(f[1], 2);
    BOOST_REQUIRE_EQUAL(f[2], 3);
}
