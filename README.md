# dotfiles

## Intro

Some time ago, my beautiful bash profile was lost in a tragic backup accident, and I was forced to start fresh. With very little memory of what was actually in the original, I am now on a journey to terminal re-enlightenment, and you can follow along.

## Prerequisites

Mostly the installer tries to install everything it needs as it goes, and it has been tested on fresh macOS installations so everything it needs should already be there, however:

- You must already be logged into the App Store for mas recipes to work
  - I haven't really been able to test this, but it seems like mas can't install apps that aren't already "purchased" on your account, so you might run into errors from that. I don't have a workaround yet
- `curl` and `zsh` have to be present (but they should already be)

## Installation

Before getting into it, some notes:

- I wouldn't actually recommend running this installer unless you want your laptop set up exactly like mine
- This is super mac-specific, and will probably remain as such for a while

To run the installer, you don't have to clone this repo (the installer does that!), just run this command:

```
/usr/bin/env zsh -c "$(curl -fsSL https://raw.githubusercontent.com/timhugh/dotfiles/HEAD/install.sh)"
```

It will occasionally ask for your password for sudo things (this is all coming from homebrew, not from this installer).

The installer is grouped into packages, represented by each directory in `/packages`. The installer will install the `base`, `office`, and `macos` packages by default. For more eccentric setups, the installer can be given other packages as command line arguments: 

```
/usr/bin/env zsh -c "$(curl -fsSL https://raw.githubusercontent.com/timhugh/dotfiles/HEAD/install.sh)" <package1> <package2> ...
```

Generally speaking, most packages will at least depend on something from the `base` package, though, so it's recommended (but not strictly required) to always install that.

There are some manual steps after running the installer. Hopefully some of these can be automated later. Skip over ones that aren't relevant, depending on your packages:

- [ ] App logins
  - [ ] 1password login
  - [ ] Firefox login
  - [ ] Notion calendar login
  - [ ] Spark login
  - [ ] Slack login
- [ ] Raycast setup
  - [ ] Disable Spotlight shortcut
  - [ ] Login for sync
- [ ] Upload generated ssh key to Github (`cat ~/.ssh/github_key.pub | pbcopy`)
- [ ] Default apps
  - [ ] Set Velja as default browser
  - [ ] Set Spark as default mail
  - [ ] Set Notion Calendar as default calendar
- [ ] Configure login items:
  - [ ] Raycast
  - [ ] Scroll reverser

## Todo

In addition to trying to automate some of the manual post-install steps, here are some other things I would like to do automatically (in no particular order):

- [x] Installer should check if the dotfiles repo remote is set before setting it (right now it just sets it every time)
- [ ] Automate github ssh key upload this with GH CLI: `gh auth login --hostname github.com --git-protocol ssh --web`
- [ ] OS settings I would like to add to packages/macos/settings.install:
  - [x] disable clicking on wallpaper to open expose or whatever its called
  - [ ] show battery percentage in menu bar
  - [x] set clock to 24hr time
  - [ ] set display scale to "more space"
  - [ ] turn off true tone
- [ ] Set default browser automatically
    - maybe use https://github.com/kerma/defaultbrowser ?
    - [ ] figure out a way to sync Velja config (or replace it)
- [ ] Implement package dependencies
  - I actually tried to do this initially and scrapped it to keep things simple, but I think the packages get a little bit too big the way it is now, and there are a lot of cross-cutting dependencies (e.g. a lot of things depend on node). It would be nice to just say "install nvim" and have it install nvim plus all of the tools required for the LSPs, etc
  - [ ] there's an issue right now with circular dependencies as well -- nvim.install depends on node, python, and ruby, but they all depend on mise
  - In the meantime, going to add `.depends` files to packages just to keep track of those dependencies
- [x] zsh autocomplete is case sensitive now because I ditched oh-my-zsh. I think that's the only thing I miss

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

I've also included some fonts, which I've patched with the [nerd fonts font-patcher script](https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#font-patcher):
- [Intel One Mono](https://github.com/intel/intel-one-mono)
- [Google Space Mono](https://fonts.google.com/specimen/Space+Mono)

