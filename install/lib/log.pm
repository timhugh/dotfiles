package Log;

use strict;
use warnings;
use Curses;
use POSIX qw(strftime);

sub new {
    my ($class, $title) = @_;
    my $logdir = $ENV{'HOME'} . 'tmp/dotfiles';
    my $self = {
        title => $title,
        steps => [],
        log_fh => undef,
        logfile => $ENV{LOGFILE} || "$logdir/dotfiles" . strftime("%Y-%m-%d-%H-%M-%S", localtime) . ".log",
        win => undef,
        win_x => 0,
        win_y => 0,
    };
    bless $self, $class;

    initscr();
    cbreak();
    noecho();
    curs_set(0);

    $self->{win} = newwin(0, 0, 0, 0);
    $self->{win_x} = 0;
    $self->{win_y} = 0;

    open($self->{log_fh}, '>', $self->{logfile}) or die "Could not open file '$self->{logfile}' $!";
    $self->{log_fh}->autoflush(1);

    return $self;
}

sub p {
    my ($self, $msg) = @_;

    my $win = $self->{win};
    printw("  - $msg\n");

    print {$self->{log_fh}} "  - $msg\n";

    $self->{win_y}++;
    refresh();
}

