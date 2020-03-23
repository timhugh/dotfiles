# Issues

## Bash

- [x] If the ~/.bash_profile.d symlink already exists, another one will be created inside the directory.
- [x] I haven't actually tested, but I suspect the install script will shit the bed if you run it outside the `/bash` directory.
- [x] New dmc-set command will happily write the name of a nonexistent machine to the config file.

## Vim

- [x] The install script doesn't install .vimrc.
- [x] The install script doesn't install the neovim init script.
- [x] Again, I think this will do crazy stuff if run outside the `/vim` directory.
- [ ] The Y, <leader>p, and <leader>P clipboard mappings seem to be inconsistent.
  - *Think I need to read about the difference between the + and * clipboard buffers to understand this better.*
- [ ] Fix/finish the "search for todo" feature
- [ ] Write a list of all mappings and come up with a better system for less-used ones
- [ ] Rebuild YCM in the install script

## Misc

- [x] No install script for ctags, tmux.conf, gitconfig.
- [x] Tmux open-pane-in-same-dir seems to have stopped working.

## Bin
- [ ] Bin install script doesn't actually backup old files (because it uses absolute paths)

## Not actually issues, but still TODOs

- [ ] I'm not convinced that install script is actually safe to run...
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
- [ ] Install powerline fonts (https://github.com/powerline/fonts)
- [ ] ???
