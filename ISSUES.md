# Issues

## Bash

- [x] If the ~/.bash_profile.d symlink already exists, another one will be created inside the directory.
- [x] I haven't actually tested, but I suspect the install script will shit the bed if you run it outside the `/bash` directory.

## Vim

- [x] The install script doesn't install .vimrc.
- [x] The install script doesn't install the neovim init script.
- [x] Again, I think this will do crazy stuff if run outside the `/vim` directory.


## Misc

- [x] No install script for ctags, tmux.conf, gitconfig.
- [ ] Tmux open-pane-in-same-dir seems to have stopped working.

## Not actually issues, but still TODOs

- [x] Consolidated install script for all files.
- [ ] Reduce duplication in install scripts (backup, ln loops are essentially identical).
- [ ] Improve logging.
- [ ] Make user agnostic template for gitconfig and interpolate env variables on install.
- [ ] Install script for homebrew and packages.
- [ ] Init script for git, hub credentials.
- [ ] Init for .env file
  - [ ] Name, email for git
  - [ ] Github token for hub
  - [ ] Default ruby version
- [ ] ???
