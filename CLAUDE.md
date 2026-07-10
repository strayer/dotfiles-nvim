# CLAUDE.md

This file provides repository guidance for coding agents working on this Neovim
configuration.

## Repository overview

This is a focused Neovim 0.12 configuration managed by lazy.nvim. The durable
design brief, plugin decisions, implementation ledger, and deferred experiments
are in `NEOVIM-CHARACTER.md`; read it before changing plugin ownership or the
editor's intended character.

The resolved graph has 26 lockfile entries: 23 direct plugins including
bootstrapped Lazy and three Neo-tree dependencies.

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
- `lua/basics.lua` owns editor options, general autocmds, and native filetype
  additions.
- `lua/keymaps.lua` owns normal mappings for native editor, LSP, terminal, and
  window actions.
- `lua/plugins.lua` is the plugin specification and most focused setup.
- `lua/config-*.lua` contains larger retained plugin configurations.
- `lua/config-which-key.lua` contains only WhichKey group labels; plugin-backed
  mappings live with their plugin specifications or setup.
- `lua/auto-dark-mode.lua` reads `~/.cache/system-theme.txt` and switches themes.
- `NEOVIM-CHARACTER.md` is the source of truth for design and cleanup status.

## Current system ownership

- **Completion:** Blink uses LSP, path, and buffer sources. Lua buffers in this
  repository additionally use LazyDev; snippets are not configured.
- **LSP:** `config-lsp.lua` uses `vim.lsp.config` and `vim.lsp.enable`. Fidget is
  the only LSP-progress display, and Tiny Inline Diagnostic owns inline
  diagnostic presentation.
- **Formatting and linting:** Conform handles format-on-save and `:Format`.
  nvim-lint loads only for Markdown and Dockerfile buffers and runs
  markdownlint-cli2 or Hadolint.
- **Exploration and picking:** Neo-tree remains the primary filesystem, buffer,
  and Git explorer. MiniFiles is enabled explicitly on `<leader>em` for a
  post-cleanup workflow trial and does not replace the default directory
  explorer. FzfLua owns pickers and `vim.ui.select` after it loads.
- **Input and notifications:** MiniInput owns `vim.ui.input`; MiniNotify owns
  `vim.notify` with LSP progress disabled.
- **Native messages and command line:** Neovim UI2 is enabled with default
  options as an experimental post-cleanup trial. It owns native command-line,
  message, dialog, and pager presentation; do not treat its private
  `vim._core.ui2` API as stable.
- **Editing and UI:** Mini.nvim provides the start screen, sessions,
  indentation, icons, surrounds, trailing-space highlighting, pairs, task-word
  highlighting, input, notifications, Git signs, and the explicit MiniFiles
  trial. Lualine remains the global statusline.
- **Git:** Fugitive owns Git commands and buffers; MiniDiff owns sign-column
  change visualization.
- **Markdown:** Markview renders Markdown, Quarto, and R Markdown in Neovim.
- **Themes:** Tokyonight is the dark theme and Catppuccin Latte is the light
  theme.

## Key mapping structure

- `<CR>` / `g<CR>` - Leap in the current window / across windows.
- `<leader>c` - code operations, primarily formatting.
- `<leader>e` - explorer views; `<leader>em` opens MiniFiles while the existing
  Neo-tree mappings remain primary.
- `<leader>f` - find files with FzfLua.
- `<leader>l` - LSP diagnostics, symbols, code actions, and native operations.
- `<leader>s` - FzfLua searches.
- `<leader>S` - session selection and creation.
- `<leader>t` - terminal operations.
- `<leader>w` - window operations.

WhichKey remains the current mapping discovery layer, but it does not create
action mappings. It observes their `desc` metadata and supplies group labels
only. The mapping architecture is normalized. MiniClue was reassessed after
normalization and rejected because WhichKey's automatic discovery for built-in
prefixes such as `g` and `z` is part of the desired workflow.

## Development rules

1. Preserve unrelated working-tree changes and stage explicit paths or hunks.
2. Keep functional plugin removals, their dependencies, stale mappings,
   orphaned files, and lockfile entries in the same commit.
3. Before enabling a new plugin or Mini module, read its current official
   installation, configuration, migration, and health documentation. Record the
   URL and retrieval date in `NEOVIM-CHARACTER.md`.
4. Keep `NEOVIM-CHARACTER.md` synchronized whenever implementation status or
   commit grouping changes.
5. Run StyLua, `git diff --check`, headless startup, and focused runtime checks
   before each functional commit. Run the full acceptance checklist before final
   handoff.
6. Do not modify or commit ignored private configuration without explicit user
   direction.

## Environment-specific behavior

- Neovide receives a custom font, cursor effect, focus workaround, and macOS
  command-key mappings.
- Tmux sessions receive insert/normal cursor-shape escape sequences.
- Theme changes are driven by `~/.cache/system-theme.txt` and the `Signal`
  autocmd.
- Native filetype rules cover `Caddyfile`, `*.Caddyfile`, `*.caddyfile`, and
  `Caddyfile.*`; built-in Neovim support handles Fish, Kitty, YAML, and Python.
- UI2 is intentionally a default-options trial. Test native messages, paging,
  shell output, prompts, Tmux, and Neovide before making it permanent or adding
  routing customization.
