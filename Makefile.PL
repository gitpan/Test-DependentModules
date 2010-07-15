
use strict;
use warnings;



use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'Test all modules which depend on your module',
  'AUTHOR' => 'Dave Rolsky <autarch@urth.org>',
  'BUILD_REQUIRES' => {
    'Test::More' => '0.88'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.31'
  },
  'DISTNAME' => 'Test-DependentModules',
  'EXE_FILES' => [],
  'LICENSE' => 'artistic_2',
  'NAME' => 'Test::DependentModules',
  'PREREQ_PM' => {
    'CPAN' => '1.9402',
    'CPANDB' => '0.12',
    'Cwd' => '0',
    'Exporter' => '0',
    'File::Path' => '0',
    'File::Spec' => '0',
    'File::Temp' => '0',
    'File::chdir' => '0',
    'IO::Handle::Util' => '0',
    'IPC::Run3' => '0',
    'Test::More' => '0',
    'autodie' => '0'
  },
  'VERSION' => '0.07',
  'test' => {
    'TESTS' => 't/*.t'
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



