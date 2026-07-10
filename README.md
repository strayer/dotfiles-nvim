# Neovim Configuration

A focused Neovim configuration for text editing and software development. It
targets Neovim 0.12 and keeps one clear tool for each recurring workflow.

Some environment integration, especially automatic theme switching, is managed
by the broader [dotfiles repository](https://github.com/strayer/dotfiles).

## Features

- Blink completion from LSP, paths, and open buffers, with LazyDev metadata only
  while editing this Neovim configuration.
- Native `vim.lsp.config`/`vim.lsp.enable` setup for the configured language
  servers.
- An experimental default-options trial of Neovim's native UI2 command-line,
  message, dialog, and pager presentation.
- Neo-tree filesystem, buffer, and Git views, with MiniFiles enabled for a
  focused post-cleanup workflow trial.
- FzfLua pickers for files, text, buffers, diagnostics, symbols, and other
  searchable editor state.
- Markview rendering for Markdown, Quarto, and R Markdown inside Neovim.
- Conform format-on-save and manual formatting, plus focused Markdown and
  Dockerfile diagnostics from nvim-lint.
- Fugitive for Git commands and MiniDiff signs for changed lines.
- Mini.nvim modules for sessions, the start screen, surrounding edits,
  indentation, trailing whitespace, pairs, highlighted task words, input,
  notifications, icons, diffs, and the MiniFiles trial.
- Lualine, Tiny Inline Diagnostic, Fidget LSP progress, CSVView, Illuminate, and
  FloatTerm for their focused workflows.
- Automatic Tokyonight dark and Catppuccin Latte light theme switching.

The resolved plugin graph contains 26 entries: 23 direct plugins including
bootstrapped Lazy, plus Neo-tree's three dependencies.

## Requirements

- Neovim 0.12 or newer.
- Git.
- Optional external formatters and linters used by the filetypes you edit, such
  as StyLua, Prettierd, shfmt, markdownlint-cli2, and Hadolint.
- `~/.cache/system-theme.txt` containing `dark` or `light` for automatic theme
  selection.

## Installation

```sh
git clone https://github.com/strayer/dotfiles-nvim.git ~/.config/nvim
cd ~/.config/nvim
nvim --headless "+Lazy! restore" +qa
nvim
```

Missing-plugin auto-installation is deliberately disabled. To restore the exact
versions in `lazy-lock.json` later:

```sh
nvim --headless "+Lazy! restore" +qa
```

## Key mappings

Space is the leader key. WhichKey observes the descriptions on normal and
plugin-owned mappings and displays the available groups. The main custom entry
points are:

- `<CR>` starts Leap in normal, visual, and operator-pending modes; `g<CR>`
  starts cross-window Leap. Quickfix, command, Neo-tree, and CSV buffers retain
  their local Enter behavior.
- `sa`, `sd`, and `sr` add, delete, and replace surroundings with MiniSurround.
- `<leader>e` opens explorer views: Neo-tree remains primary, while
  `<leader>em` opens the MiniFiles trial focused on the current file.
- `<leader>f` and `<leader>s` provide FzfLua file and search operations.
- `<leader>l` contains diagnostics, symbols, code actions, and native LSP
  operations.
- `<leader>S` manages sessions, `<leader>t` opens terminals, and `<leader>w`
  manages windows.
- `<leader>cf` formats through Conform; `:FormatToggle[!]` controls
  format-on-save globally or for the current buffer.

## Development

`NEOVIM-CHARACTER.md` records the configuration's design decisions, completed
cleanup commits, and deferred experiments. Read it before changing plugin
ownership or reintroducing a removed workflow.

Useful commands:

```sh
just update  # Pull and restore locked plugin versions
just upgrade # Update plugins, commit lazy-lock.json, and push
prek run --all-files
```

## License

See [LICENSE.txt](LICENSE.txt).
