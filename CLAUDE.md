# CLAUDE.md

This file provides repository guidance for coding agents working on this Neovim
configuration.

## Repository overview

This is a focused Neovim 0.12 configuration managed by lazy.nvim. Each
recurring workflow has one clear owner, described below; preserve that
ownership when changing plugins or behavior.

## Common commands

```sh
just update                              # Pull and restore lazy-lock.json
just upgrade                             # Update, commit the lockfile, and push
nvim --headless "+Lazy! restore" +qa     # Restore exact locked revisions
nvim --headless "+Lazy! update" +qa      # Update all eligible plugins
prek run --all-files                     # Run repository checks
stylua --check .                         # Check Lua formatting
```

## Configuration structure

- `init.lua` bootstraps Lazy and loads core configuration.
- `lua/basics.lua` owns editor options and general autocmds.
- `lua/keymaps.lua` owns normal mappings for native editor, LSP, terminal, and
  window actions.
- `lua/plugins.lua` is the plugin specification and most focused setup.
- `lua/config-*.lua` contains larger retained plugin configurations.
- `lua/config-which-key.lua` contains only WhichKey group labels; plugin-backed
  mappings live with their plugin specifications or setup.
- `lua/auto-dark-mode.lua` reads `~/.cache/system-theme.txt` and switches themes.

## System ownership

- **Completion:** Blink uses LSP, path, and buffer sources. Lua buffers in this
  repository additionally use LazyDev; snippets are not configured.
- **LSP:** `config-lsp.lua` uses `vim.lsp.config` and `vim.lsp.enable`. Fidget is
  the only LSP-progress display, and Tiny Inline Diagnostic owns inline
  diagnostic presentation.
- **Formatting and linting:** Conform handles format-on-save and `:Format`.
  nvim-lint loads only for Markdown and Dockerfile buffers and runs
  markdownlint-cli2 or Hadolint.
- **Exploration and picking:** Neo-tree is the primary filesystem, buffer, and
  Git explorer. MiniFiles is a secondary explorer on `<leader>em`, currently
  under evaluation; it does not replace the default directory explorer. FzfLua
  owns pickers and `vim.ui.select` after it loads.
- **Input and notifications:** MiniInput owns `vim.ui.input`; MiniNotify owns
  `vim.notify` with LSP progress disabled.
- **Native messages and command line:** Neovim's native UI2 is enabled
  experimentally, with `cmdheight=0` so the command line is visible only while
  in use. It owns native command-line, message, dialog, and pager presentation;
  do not treat its private `vim._core.ui2` API as stable.
- **Editing and UI:** Mini.nvim provides the start screen, sessions,
  indentation, icons, surrounds, trailing-space highlighting, pairs, task-word
  highlighting, input, notifications, Git signs, and MiniFiles. Lualine is the
  global statusline.
- **Git:** Fugitive owns Git commands and buffers; MiniDiff owns sign-column
  change visualization.
- **Markdown:** Markview renders Markdown, Quarto, and R Markdown in Neovim.
- **Themes:** Tokyonight is the dark theme and Catppuccin Latte is the light
  theme.

## Key mapping structure

- `<CR>` / `g<CR>` - Leap in the current window / across windows.
- `<leader>c` - code operations, primarily formatting.
- `<leader>e` - explorer views; `<leader>em` opens MiniFiles while the Neo-tree
  mappings remain primary.
- `<leader>f` - find files with FzfLua.
- `<leader>l` - LSP diagnostics, symbols, code actions, and native operations.
- `<leader>s` - FzfLua searches.
- `<leader>S` - session selection and creation.
- `<leader>t` - terminal operations.
- `<leader>w` - window operations.

WhichKey is the mapping discovery layer, but it does not create action
mappings: it observes their `desc` metadata and supplies group labels only.
WhichKey is deliberately preferred over alternatives such as MiniClue because
its automatic discovery of built-in prefixes like `g` and `z` is part of the
desired workflow.

## Development rules

1. Preserve unrelated working-tree changes and stage explicit paths or hunks.
2. Keep functional plugin removals, their dependencies, stale mappings,
   orphaned files, and lockfile entries in the same commit.
3. Before enabling a new plugin or Mini module, read its current official
   installation, configuration, migration, and health documentation. Record
   durable ownership or operational changes in this file and `README.md`.
4. Run StyLua, `git diff --check`, headless startup, and focused runtime checks
   before each functional commit.
5. Do not modify or commit ignored private configuration without explicit user
   direction.

## Environment-specific behavior

- Neovide receives a custom font, cursor effect, focus workaround, and macOS
  command-key mappings.
- Tmux sessions receive insert/normal cursor-shape escape sequences.
- Theme changes are driven by `~/.cache/system-theme.txt` and the `Signal`
  autocmd.
- Built-in Neovim support covers Fish, Kitty, YAML, and Python; no extra
  filetype plugins are needed for them.
- UI2 with `cmdheight=0` is an intentionally scoped experiment. Test native
  messages, paging, shell output, prompts, Tmux, and Neovide before making it
  permanent or adding message-routing customization.
