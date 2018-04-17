# vim-bang-terminal
Remap :! to run the terminal on Vim or Neovim.

If requirements are satisfied, then the plugin uses `cnoremap <CR>` to remap on command execution. When the user executes a bang command, the command is executed on the terminal instead.

# Requirements
- Vim 8
    - `+terminal`
    - 8.0.1108+ for bugfixes and mappings (ex. `tmap`, `tnoremap`)
- Neovim
    - 0.2.1 for Windows support

# License

Apache License 2.0
