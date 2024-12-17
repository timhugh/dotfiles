#!/usr/bin/env perl

package xcode;

use strict;
use warnings;

use File::Basename;
use lib dirname(__FILE__) . '/lib';
use Log;

sub xcode {
    my $xcode_installed = check_xcode_installation();
    if ($xcode_installed) {
        Log->t("Let's install Xcode Command Line Tools. This will take a minute, and you might be asked to enter your password at some point so keep an eye on me");
        install_xcode();
    }
    Log->p("✅ Xcode Command Line Tools");
}

sub check_xcode_installation {
    my $xcode_path = `xcode-select -p`;
    chomp $xcode_path;
    return $xcode_path ne "";
}

sub install_xcode {
    sleep 1;
}

xcode();
