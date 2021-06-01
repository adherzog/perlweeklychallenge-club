#!/usr/bin/env perl

########################################################################
#
# Task #1 - String Chain
#
# You are given an array of strings.
#
# Write a script to find out if the given strings can be chained to form
# a circle. Print 1 if found otherwise 0.
#
# A string $S can be put before another string $T in circle if the last
# character of $S is same as first character of $T.
#
########################################################################

use strict;
use warnings;

use Test::More;

if (@ARGV) {
    print is_string_chain(@ARGV), "\n";
}
else {
    my @tests = (
        { input => [qw/abc dea cd/],  output => 1, },    # example given
        { input => [qw/ade cbd fgh/], output => 0, },    # example given

        { input => [qw/aba ada/],                 output => 1, },
        { input => [qw/abc cde efg gha ade efa/], output => 1, },
        { input => [qw/abc dea cd efe/],          output => 0, }, # two chains
        { input => [qw/abc dea cd fgh hij jkf/],  output => 0, }, # two chains
    );

    for my $test (@tests) {
        is( is_string_chain( @{ $test->{'input'} } ), $test->{'output'} );
    }

    done_testing();
}

exit;

########################################################################
#
# In order for the list of strings to form a chain, a list of the first
# character in each string must contain the same characters as a list of
# the final character in each string.
#
# One approach is to generate a list of the first characters, and a list
# of the last characters, and then just check if both lists contain the
# same characters (in any order.)
#
# That's necessary, but not sufficient. That approach doesn't detect
# situations where we have multiple chains that don't connect to each
# other.
#
########################################################################

sub is_string_chain {
    my @input = @_;

    my ( @start, @end );
    for my $input (@input) {
        push @start, substr $input, 0,  1;
        push @end,   substr $input, -1, 1;
    }

    return 0
        unless ( join( '', sort @start ) eq join( '', sort @end ) );

    return 1;
}
