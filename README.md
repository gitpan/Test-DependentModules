# NAME

Test::DependentModules - Test all modules which depend on your module

# VERSION

version 0.20

# SYNOPSIS

    use Test::DependentModules qw( test_all_dependents );

    test_all_dependents('My::Module');

    # or ...

    use Test::DependentModules qw( test_module );
    use Test::More tests => 3;

    test_module('Exception::Class');
    test_module('DateTime');
    test_module('Log::Dispatch');

# DESCRIPTION

**WARNING**: The tests this module does should **never** be included as part of
a normal CPAN install!

This module is intended as a tool for module authors who would like to easily
test that a module release will not break dependencies. This is particularly
useful for module authors (like myself) who have modules which are a
dependency of many other modules.

## How It Works

Internally, this module will download dependencies from CPAN and run their
tests. If those dependencies in turn have unsatisfied dependencies, they are
installed into a temporary directory. These second-level (and third-, etc)
dependencies are _not_ tested.

In order to avoid prompting, this module sets `$ENV{PERL_AUTOINSTALL}` to
`--defaultdeps` and sets `$ENV{PERL_MM_USE_DEFAULT}` to a true value.

Nonetheless, some ill-behaved modules will _still_ wait for a
prompt. Unfortunately, because of the way this module attempts to keep output
to a minimum, you won't see these prompts. Patches are welcome.

## Running Tests in Parallel

If you're testing a lot of modules, you might benefit from running tests in
parallel. You'll need to have [Parallel::ForkManager](https://metacpan.org/pod/Parallel::ForkManager) installed for this to
work.

Set the `$ENV{PERL_TEST_DM_PROCESSES}` env var to a value greater than 1 to
enable parallel testing.

# FUNCTIONS

This module optionally exports three functions:

## test\_all\_dependents( $module, { exclude => qr/.../ } )

Given a module name, this function uses [MetaCPAN::Client](https://metacpan.org/pod/MetaCPAN::Client) to find all its
dependencies and test them. It will set a test plan for you.

If you want to exclude some dependencies, you can pass a regex which will be
used to exclude any matching distributions. Note that this will be tested
against the _distribution name_, which will be something like "Test-DependentModules"
(note the lack of colons).

Additionally, any distribution name starting with "Task" or "Bundle" is always
excluded.

## test\_modules(@names)

Given a list of module names, this function will test them all. You can use
this if you'd prefer to hard code a list of modules to test.

In this case, you will have to handle your own test planning.

## test\_module($name)

**DEPRECATED**. Use the `test_modules()` sub instead, so you can run
optionally run tests in parallel.

Given a module name, this function will test it. You can use this if you'd
prefer to hard code a list of modules to test.

In this case, you will have to handle your own test planning.

# PERL5LIB FOR DEPENDENCIES

If you want to include a module-to-be-released in the path seen by
dependencies, you must make sure that the correct path ends up in
`$ENV{PERL5LIB}`. If you use `prove -l` or `prove -b` to run tests, then
that will happen automatically.

# WARNINGS, LOGGING AND VERBOSITY

By default, this module attempts to quiet down CPAN and the module building
toolchain as much as possible. However, when there are test failures in a
dependency it's nice to see the output.

In addition, if the tests spit out warnings but still pass, this will just be
treated as a pass.

If you enable logging, this module log all successes, warnings, and failures,
along with the full output of the test suite for each dependency. In addition,
it logs what prereqs it installs, since you may want to install some of them
permanently to speed up future tests.

To enable logging, you must provide a directory to which log files will be
written. The log file names are of the form `test-my-deps-$$-$type.log`,
where `$type` is one of "status", "error", or "prereq".

The directory should be provided in `$ENV{PERL_TEST_DM_LOG_DIR}`. The
directory must already exist.

You also can enable CPAN's output by setting the
`$ENV{PERL_TEST_DM_CPAN_VERBOSE}` variable to a true value.

# BUGS

Please report any bugs or feature requests to `bug-test-mydeps@rt.cpan.org`,
or through the web interface at [http://rt.cpan.org](http://rt.cpan.org).  I will be notified,
and then you'll automatically be notified of progress on your bug as I make
changes.

# DONATIONS

If you'd like to thank me for the work I've done on this module, please
consider making a "donation" to me via PayPal. I spend a lot of free time
creating free software, and would appreciate any support you'd care to offer.

Please note that **I am not suggesting that you must do this** in order for me
to continue working on this particular software. I will continue to do so,
inasmuch as I have in the past, for as long as it interests me.

Similarly, a donation made in this way will probably not make me work on this
software much more, unless I get so many donations that I can consider working
on free software full time, which seems unlikely at best.

To donate, log into PayPal and send money to autarch@urth.org or use the
button on this page: [http://www.urth.org/~autarch/fs-donation.html](http://www.urth.org/~autarch/fs-donation.html)

# AUTHOR

Dave Rolsky <autarch@urth.org>

# COPYRIGHT AND LICENSE

This software is Copyright (c) 2014 by Dave Rolsky.

This is free software, licensed under:

    The Artistic License 2.0 (GPL Compatible)
