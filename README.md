# dotfiles

## Intro

Some time ago, my beautiful bash profile was lost in a tragic backup accident, and I was forced to start fresh. With very little memory of what was actually in the original, I am now on a journey to terminal re-enlightenment, and you can follow along.

## Installation

This is decidedly mac-specific at the moment and will probably remain as such for a while. Generally I wouldn't actually suggest running the installer unless you wanted your computer set up exactly how I like mine, but if you wanted to do that:

```
/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/timhugh/dotfiles/HEAD/install.sh)"
```

## History

Previously, all of this configuration was scattered across separate repos and gists:

- [bash_profile](https://github.com/timhugh/bash_profile)
- [.vim/ and .vimrc](https://github.com/timhugh/vim)
- [.gitconfig](https://gist.github.com/timhugh/9b6303ffcc00fbc2b84a)
- [.tmux.conf](https://gist.github.com/timhugh/b39ae27a39c4d3aca4040b38b1e7f911)

I finally put in the time to make my bash_profile applicable to my personal laptop and my work laptop, and keeping the disparate repos/gists in sync became a pain point.

There's a little bit of inspiration from JackDanger's [apple_store](https://github.com/JackDanger/apple_store), too, because--let's be honest--I don't actually need to be able to setup a dev environment on a random system at any given moment, but the idea is cool!
