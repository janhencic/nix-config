local jan_telescope = require('jan.telescope')

require('telescope').setup(jan_telescope.setup)
jan_telescope.command_history_keymap()
