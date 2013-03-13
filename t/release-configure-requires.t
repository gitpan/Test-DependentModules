
BEGIN {
  unless ($ENV{RELEASE_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for release candidate testing');
  }
}

use strict;
use warnings;

use Class::Load qw( load_class );

use Test::DependentModules qw( test_module );
use Test::More;

if ( eval { load_class('Pod::Readme') } ) {
    plan skip_all => 'This test requires that Pod::Readme _not_ be installed';
}

plan skip_all =>
    q{MooseX::Semantic is not installable on my machine for some weird reason};

test_module('MooseX::Semantic');

done_testing();
