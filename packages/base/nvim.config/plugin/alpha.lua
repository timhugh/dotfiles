vim.pack.add({
  'https://github.com/goolord/alpha-nvim'
})

local theme = require('alpha.themes.dashboard')
theme.section.header.val = {
  '          /\\',
  '         /**\\',
  '        /****\\   /\\',
  '       /      \\ /**\\',
  '      /  /\\    /    \\        /\\    /\\  /\\      /\\            /\\/\\/\\  /\\',
  '     /  /  \\  /      \\      /  \\/\\/  \\/  \\  /\\/  \\/\\  /\\  /\\/ / /  \\/  \\',
  '    /  /    \\/ /\\     \\    /    \\ \\  /    \\/ /   /  \\/  \\/  \\  /    \\   \\',
  '   /  /      \\/  \\/\\   \\  /      \\    /   /    \\',
  '__/__/_______/___/__\\___\\__________________________________________________',
}
theme.section.buttons.val = {
  theme.button("D", "Dotfiles", ":cd $DOT_ROOT | edit .<cr>")
}

require('alpha').setup(
  theme.config
)
