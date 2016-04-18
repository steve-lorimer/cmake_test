#define BOOST_TEST_MAIN
#include <boost/test/included/unit_test.hpp>
#include <boost/test/unit_test.hpp>
#include "foo/foo.h"

BOOST_AUTO_TEST_CASE(foo_test)
{
    BOOST_REQUIRE_EQUAL(foo(), "foo");
}
