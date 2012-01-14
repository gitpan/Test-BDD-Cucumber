
use strict;
use warnings;



use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'Feature-complete Cucumber-style testing in Perl',
  'AUTHOR' => '[\'Peter Sergeant <pete@clueball.com>\']',
  'BUILD_REQUIRES' => {},
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.31'
  },
  'DISTNAME' => 'Test-BDD-Cucumber',
  'EXE_FILES' => [
    'bin/pherkin'
  ],
  'LICENSE' => 'perl',
  'NAME' => 'Test::BDD::Cucumber',
  'PREREQ_PM' => {
    'File::Find::Rule' => '0',
    'File::Slurp' => '0',
    'FindBin::libs' => '0',
    'List::Util' => '0',
    'Method::Signatures' => '0',
    'Moose' => '0',
    'Ouch' => '0',
    'Path::Class' => '0',
    'Storable' => '0',
    'Term::ANSIColor' => '0',
    'Test::Builder' => '0',
    'Test::Differences' => '0',
    'Test::More' => '0',
    'YAML::Syck' => '0'
  },
  'VERSION' => '0.04',
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



