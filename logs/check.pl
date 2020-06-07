#! /usr/bin/env perl
#
# Short description for check.pl
#
# Author Shlomi Fish <shlomif@cpan.org>
# Version 0.0.1
# Copyright (C) 2020 Shlomi Fish <shlomif@cpan.org>
#
use strict;
use warnings;
use 5.014;
use autodie;

my $fn = shift;
die qq{Not empty!} if ( -s $fn );
print "OK.\n";
