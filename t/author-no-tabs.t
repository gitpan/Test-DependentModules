
BEGIN {
  unless ($ENV{AUTHOR_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for testing by the author');
  }
}

use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::NoTabs 0.09

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'lib/Test/DependentModules.pm',
    't/00-compile.t',
    't/00-report-prereqs.dd',
    't/00-report-prereqs.t',
    't/01-basic.t',
    't/02-run-tests.t',
    't/author-no-tabs.t',
    't/author-pod-spell.t',
    't/release-all-my-deps.t',
    't/release-configure-requires.t',
    't/release-cpan-changes.t',
    't/release-eol.t',
    't/release-pod-coverage.t',
    't/release-pod-linkcheck.t',
    't/release-pod-no404s.t',
    't/release-pod-spell.t',
    't/release-pod-syntax.t',
    't/release-portability.t',
    't/release-single-distros.t',
    't/release-two-distros.t'
);

notabs_ok($_) foreach @files;
done_testing;
