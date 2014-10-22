package App::pherkin;
BEGIN {
  $App::pherkin::VERSION = '0.04';
}

use strict;
use warnings;
use FindBin::libs;

=head1 NAME

App::pherkin - Run Cucumber tests from the command line

=head1 VERSION

version 0.04

=head1 SYNOPSIS

 pherkin
 pherkin some/path/features/

=head1 DESCRIPTION

C<pherkin> will search the directory specified (or C<./features/>) for
feature files (any file matching C<*.feature>) and step definition files (any
file matching C<*_steps.pl>), loading the step definitions and then executing
the features.

Steps that pass will be printed in green, those that fail in red, and those
for which there is no step definition as yellow (for TODO).

=cut

use Test::BDD::Cucumber::Loader;
use Test::BDD::Cucumber::Harness::TermColor;

=head1 METHODS

=head2 run

The C<App::pherkin> class, which is what the C<pherkin> command uses, makes
use of the C<run()> method, which accepts currently a single path as a string,
or nothing.

=cut

sub run {
    my ( $class, @arguments ) = @_;
    my ( $executor, @features ) = Test::BDD::Cucumber::Loader->load(
        $arguments[0] || './features/'
    );
    warn "No feature files found\n" unless @features;

    my $harness  = Test::BDD::Cucumber::Harness::TermColor->new();
    $executor->execute( $_, $harness ) for @features;
}

=head1 AUTHOR

Peter Sergeant C<pete@clueball.com>

=head1 LICENSE

Copyright 2011, Peter Sergeant; Licensed under the same terms as Perl

=cut

1;