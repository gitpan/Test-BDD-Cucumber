package Test::BDD::Cucumber::StepFile;
BEGIN {
  $Test::BDD::Cucumber::StepFile::VERSION = '0.15';
}

=head1 NAME

Test::BDD::Cucumber::StepFile - Functions for creating and loading Step Definitions

=head1 VERSION

version 0.15

=cut

use strict;
use warnings;
use File::Find;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(Given When Then Step);

our @definitions;

=head1 DESCRIPTION

Provides the Given/When/Then functions, and a method for loading Step Definition
files and returning the steps.

=head1 SYNOPSIS

Defining steps:

 #!perl

 use strict; use warnings; use Test::More;

 use Test::BDD::Cucumber::StepFile;
 use Method::Signatures; # Allows short-hand func method

 Given 'something',          func ($c) { print "YEAH!" }
 When  qr/smooooth (\d+)/,   func ($c) { print "YEEEHAH $1" }
 Then  qr/something (else)/, func ($c) { print "Meh $1" }
 Step  qr/die now/,          func ($c) { die "now" }

Loading steps, in a different file:

 use Test::BDD::Cucumber::StepFile;
 my @steps = Test::BDD::Cucumber::StepFile->load('filename_steps.pl');

=head1 EXPORTED FUNCTIONS

=head2 Given

=head2 When

=head2 Then

=head2 Step

Accept a regular expression or string, and a coderef. Some cute tricks ensure
that when you call the C<load()> method on a file with these statements in,
these are returned to it...

=cut

sub Given { push( @definitions, [ Given => @_ ] ) }
sub When  { push( @definitions, [ When  => @_ ] ) }
sub Then  { push( @definitions, [ Then  => @_ ] ) }

sub Step  { push( @definitions, [ Step  => @_ ] ) }

=head2 load

Loads a file containing step definitions, and returns a list of the steps
defined in it, of the form:

 (
  [ 'Given', qr/abc/, sub { etc } ],
  [ 'Step',  'asdf',  sub { etc } ]
 )

=cut

sub load {
    my ( $class, $filename ) = @_;
    {
        local @definitions;
        do $filename;
        die "Step file [$filename] failed to load: $@" if $@;
        return @definitions;
    }

}

=head1 AUTHOR

Peter Sergeant C<pete@clueball.com>

=head1 LICENSE

Copyright 2011, Peter Sergeant; Licensed under the same terms as Perl

=cut

1;