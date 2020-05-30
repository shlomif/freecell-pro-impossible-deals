#! /usr/bin/env perl
#
# Short description for list-intractables.pl
#
# Author Shlomi Fish <shlomif@cpan.org>
# Version 0.0.1
# Copyright (C) 2020 Shlomi Fish <shlomif@cpan.org>
#
use strict;
use warnings;
use 5.014;
use autodie;

use Path::Tiny qw/ path tempdir tempfile cwd /;

my @previously_int = qw(
    219837216
    1252215044
    2255988055
    2901685480
    2902413565
    4260084873
    6687921694
    6825625742
    7489392343
);
my %previously_intractable = ( map { $_ => 1 } @previously_int );

my @out;
foreach
    my $l ( path("summary-fc-solve--scan-over-impossible-4fc-deals--log.txt")
    ->lines_raw )
{
    if ( my ($deal_idx) = $l =~ m{\A([0-9]+) = Verdict: Intractable ;}ms )
    {
        if ( not exists $previously_intractable{$deal_idx} )
        {
            push @out, $deal_idx;
        }
        else
        {
            delete $previously_intractable{$deal_idx};
        }
    }
    elsif ( $l !~ m{\A([0-9]+) = Verdict: Unsolved ;}ms )
    {
        die "wrong '$l'";
    }
}
die if keys(%previously_intractable) > 0;
path("intractable1.txt")->spew_raw( map { "$_\n" } @out );
