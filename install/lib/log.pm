package Log;

use strict;
use warnings;
use POSIX qw(strftime);

my $log_fh;

sub init {
    # Only initialize the logfile once
    return if defined $log_fh;

    # Create a log directory if it doesn't exist
    my $logdir = $ENV{'HOME'} . "/tmp/dotfiles";
    mkdir $logdir unless -d $logdir;

    # Create a logfile for this run
    my $logfile = $ENV{'LOGFILE'} // $logdir . "/" . strftime("%Y-%m-%d-%H-%M-%S", localtime) . ".log";
    open($log_fh, ">>", $logfile) or die "Could not open log file $logfile: $!";
    # Make sure the log file is flushed after every write
    $log_fh->autoflush(1);
}

# Log only to the logfile
sub l {
    my ($class, $message) = @_;
    unless (defined $log_fh) {
        $class->init();
    }

    print $log_fh "$message\n";
}

# Log to the logfile and print to STDOUT
sub p {
    my ($class, $message) = @_;
    $class->l($message);
    print "$message\n";
}

# Log to the logfile and print to STDERR
sub e {
    my ($class, $message) = @_;
    $class->l($message);
    print STDERR "$message\n";
}

# Log to the logfile and print a temporary line to STDOUT 
# (will be overwritten by the next line)
sub t {
    my ($class, $message) = @_;
    $class->l($message);
    print "$message\r";
}

# Make sure the logfile is closed when the script ends
END {
    close $log_fh if defined $log_fh;
}

1;

