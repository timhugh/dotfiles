# dotfiles

## Intro

Some time ago, my beautiful bash profile was lost in a tragic backup accident, and I was forced to start fresh. With very little memory of what was actually in the original, I am now on a journey to terminal re-enlightenment, and you can follow along.

## Installation
I've been testing this on a VM running Debian 10.6.0. The installation process is decidedly not cross-platform yet.
Right now, the steps for installation are:

1. Install linux
2. Add your user to sudo group
3. Install git, make, sudo
4. Clone this repo
5. Run make inside this repo

A couple steps are having issues still because they depend on environment setup by previous steps and the easiest fix is just logging out and back in, then running it again (if you're running a window system, a new terminal session should be adequate)

On debian, those steps look like this (skipping #1):
```
su -
apt update && apt install -y git make sudo
usermod -aG sudo tim
exit # back to user
exit # log out
# log back in with new permissions
git clone https://github.com/timhugh/dotfiles.git ~/.dotfiles
make -C .dotfiles
exit
```
Log back in, et voila!

## Issues

[ISSUES.md](https://github.com/timhugh/dotfiles/blob/master/ISSUES.md)

## History

Previously, all of this configuration was scattered across separate repos and gists:

- [bash_profile](https://github.com/timhugh/bash_profile)
- [.vim/ and .vimrc](https://github.com/timhugh/vim)
- [.gitconfig](https://gist.github.com/timhugh/9b6303ffcc00fbc2b84a)
- [.tmux.conf](https://gist.github.com/timhugh/b39ae27a39c4d3aca4040b38b1e7f911)

I finally put in the time to make my bash_profile applicable to my personal laptop and my work laptop, and keeping the disparate repos/gists in sync became a pain point.

There's a little bit of inspiration from JackDanger's [apple_store](https://github.com/JackDanger/apple_store), too, because--let's be honest--I don't actually need to be able to setup a dev environment on a random system at any given moment, but the idea is cool!
