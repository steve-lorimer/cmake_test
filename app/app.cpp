#include "app.h"
#include <boost/program_options.hpp>
#include "version.h"
#include "foo/foo.h"
#include "bar/bar.h"
#include <iostream>

int App::run(int argc, char** argv)
{
    namespace po = boost::program_options;

    po::options_description desc("allowed options");
    desc.add_options()
        ("help,h"    , "show this help message")
        ("version,v" , "print version information - then quits");

    po::variables_map vm;
    po::store(po::command_line_parser(argc, argv).options(desc).allow_unregistered().run(), vm);
    po::notify(vm);

    if (vm.count("help"))
    {
        std::cout << desc << std::endl;
        exit(0);
    }

	std::cout <<
		"build variant : " << app::bin::variant() << '\n' <<
		"build date    : " << app::bin::date() << '\n' <<
		"version       : " << app::bin::version() << '\n' <<
		"num_commits   : " << app::bin::num_commits() << '\n' <<
		"branch        : " << app::bin::branch() << '\n' <<
		"ahead_by      : " << app::bin::ahead_by() << '\n' <<
		"num_untracked : " << app::bin::num_untracked() << '\n' <<
		"user          : " << app::bin::user() << '\n' <<
		"hostname      : " << app::bin::hostname() << '\n';

	if (vm.count("version"))
		exit(0);

	std::cout << "foo.size: " << foo().size() << '\n'
              << "bar: "      << bar() << '\n';
    return 0;
}
