#!perl

################################################################################
=comment

Trie

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;

#===============================================================================
package Node;
#===============================================================================

#-------------------------------------------------------------------------------
sub new
#-------------------------------------------------------------------------------
{
    my ($class, $parent, $letter) = @_;
    my  %self =
    (
        parent   => $parent,
        letter   => $letter,
        children => [],
    );

    return bless \%self, $class;
}

#-------------------------------------------------------------------------------
sub add_child
#-------------------------------------------------------------------------------
{
    my ($self, $child) = @_;

    push $self->{children}->@*, $child;
}

#-------------------------------------------------------------------------------
sub get_parent
#-------------------------------------------------------------------------------
{
    my ($self) = @_;

    return $self->{parent};
}

#-------------------------------------------------------------------------------
sub get_letter
#-------------------------------------------------------------------------------
{
    my ($self) = @_;

    return $self->{letter};
}

#-------------------------------------------------------------------------------
sub get_child
#-------------------------------------------------------------------------------
{
    my ($self, $letter) = @_;

    for my $child ( $self->{children}->@* )
    {
        return $child if defined $child && $child->{letter} eq $letter;
    }

    return undef;
}

#-------------------------------------------------------------------------------
sub num_children
#-------------------------------------------------------------------------------
{
    my ($self) = @_;

    return scalar $self->{children}->@*;
}

#===============================================================================
package Trie;
#===============================================================================

#-------------------------------------------------------------------------------
sub new
#-------------------------------------------------------------------------------
{
    my ($class) = @_;
    my  %self   = (root => Node->new(undef, ''));

    return bless \%self, $class;
}

#-------------------------------------------------------------------------------
sub insert_word
#-------------------------------------------------------------------------------
{
    my ($self, $word) = @_;

    my $node = $self->{root};

    for my $letter (split //, $word)
    {
        my $child = $node->get_child($letter);

        if (defined $child)
        {
            $node = $child;
        }
        else
        {
            my $new_child = Node->new($node, $letter);

            $node->add_child($new_child);

            $node = $new_child;
        }
    }

    return $node;
}

################################################################################
1;
################################################################################
