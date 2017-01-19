#include "app2.h"
#include <boost/program_options.hpp>
#include "version.h"
#include "foo/foo.h"
#include <iostream>

int App2::run(int argc, char** argv)
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
		"build variant : " << app2::bin::variant() << '\n' <<
		"build date    : " << app2::bin::date() << '\n' <<
		"version       : " << app2::bin::version() << '\n' <<
		"num_commits   : " << app2::bin::num_commits() << '\n' <<
		"branch        : " << app2::bin::branch() << '\n' <<
		"ahead_by      : " << app2::bin::ahead_by() << '\n' <<
		"num_untracked : " << app2::bin::num_untracked() << '\n' <<
		"user          : " << app2::bin::user() << '\n' <<
		"hostname      : " << app2::bin::hostname() << '\n';

	if (vm.count("version"))
		exit(0);

	std::cout << "foo.size: " << foo().size() << '\n';
	return 0;
}
