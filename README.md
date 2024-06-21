# dotfiles

## Intro

Some time ago, my beautiful bash profile was lost in a tragic backup accident, and I was forced to start fresh. With very little memory of what was actually in the original, I am now on a journey to terminal re-enlightenment, and you can follow along.

## Installation

Before getting into it, some notes:

- I wouldn't actually recommend running this installer unless you want your laptop set up exactly like mine
- This is super mac-specific, and will probably remain as such for a while

To run the installer, you don't have to clone this repo (the installer does that!), just run this command:

```
/usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/timhugh/dotfiles/HEAD/install.sh)"
```

It will occasionally ask for your password for sudo things, and anything installed using `mas` (App Store) will require logging into an Apple account, if you haven't already.

The installer is grouped into packages, represented by each directory in `/packages`. The installer will install the `base`, `office`, and `macos` packages by default. For more eccentric setups, the installer can be given other packages as command line arguments: 

```
/usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/timhugh/dotfiles/HEAD/install.sh)" <package1> <package2> ...
```

Note the `base` package is always installed because it contains required dependencies for the installer. Also, the installer _intends_ to be idempotent, so it should be safe to run multiple time for the same package.

There are some manual steps after running the installer. Hopefully some of these can be automated later. Skip over ones that aren't relevant, depending on your packages:

- [ ] 1password login
- [ ] Firefox login
- [ ] Chrome login
- [ ] Velja config
- [ ] Dropbox login
- [ ] Upload generated ssh key to Github (`cat ~/.ssh/github_key.pub | pbcopy`)
- [ ] Notion calendar login
- [ ] Spark login
- [ ] Slack login
- [ ] Zoom login
- [ ] Spotify login
- [ ] Rectangle setup (I use the old Spectacle bindings -- old habits)
- [ ] Jetbrains toolbox login
- [ ] Intellij settings sync
- [ ] Goland settings sync
- [ ] Clion settings sync
- [ ] Rubymine settings sync
- [ ] Docker login
- [ ] Set default browser
- [ ] Set Spark as default mail
- [ ] Set Notion Calendar as default calendar
- [ ] Configure login items:
    - 1Password
    - Caffeine
    - Rectangle
    - Velja

## History

Previously, all of this configuration was scattered across separate repos and gists:

- [bash_profile](https://github.com/timhugh/bash_profile)
- [.vim/ and .vimrc](https://github.com/timhugh/vim)
- [.gitconfig](https://gist.github.com/timhugh/9b6303ffcc00fbc2b84a)
- [.tmux.conf](https://gist.github.com/timhugh/b39ae27a39c4d3aca4040b38b1e7f911)

I finally put in the time to make my bash_profile applicable to my personal laptop and my work laptop, and keeping the disparate repos/gists in sync became a pain point.

There's a little bit of inspiration from JackDanger's [apple_store](https://github.com/JackDanger/apple_store), too, because--let's be honest--I don't actually need to be able to setup a dev environment on a random system at any given moment, but the idea is cool!

## Resources

Here are some of the excellent resources I've used to build this.

- https://macos-defaults.com/
- https://www.defaults-write.com/

