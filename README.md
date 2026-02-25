# dotfiles

## Intro

Some time ago, my beautiful bash profile was lost in a tragic backup accident, and I was forced to start fresh. With very little memory of what was actually in the original, I am now on a journey to terminal re-enlightenment, and you can follow along.

## Usage

I've removed the old steps because they were wildly out of date, but there isn't really an updated guide yet outside of the following notes.

There are basically four packages at the moment:
- macos for mac-specific configuration and applications
- linux, which is currently arch-specific configuration and applications
- base, which is the majority of this repo, and contains application setup and config that I would want anywhere
- extras, which contains non-work stuff that is really just for my personal laptop

Actual installation right now requires cloning the repo and running the installer. For the most part the packages install correctly first try, but there are some kinks to work out with dependencies being out of order or parts of the installer depending on environment setup that hasn't taken effect yet. Most errors can be resolved by starting a new terminal session and running the installer again.

## Todo

In addition to trying to automate some of the manual post-install steps, here are some other things I would like to do automatically (in no particular order):

- [ ] Automate github ssh key upload this with GH CLI: `gh auth login --hostname github.com --git-protocol ssh --web`
- [ ] OS settings I would like to add to packages/macos/settings.install:
  - [ ] show battery percentage in menu bar
  - [ ] set display scale to "more space"
  - [ ] turn off true tone
- [ ] Implement package dependencies
  - I actually tried to do this initially and scrapped it to keep things simple, but I think the packages get a little bit too big the way it is now, and there are a lot of cross-cutting dependencies (e.g. a lot of things depend on node). It would be nice to just say "install nvim" and have it install nvim plus all of the tools required for the LSPs, etc
  - [ ] there's an issue right now with circular dependencies as well -- nvim.install depends on node, python, and ruby, but they all depend on mise
  - In the meantime, going to add `.depends` files to packages just to keep track of those dependencies

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

