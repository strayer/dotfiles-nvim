# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a modern Neovim configuration built around lazy.nvim for plugin management, featuring AI-assisted coding, comprehensive LSP support, and automatic dark/light mode switching that integrates with system preferences.

## Common Commands

### Plugin Management

```bash
just update          # Pull latest changes and restore plugins
just upgrade          # Update all plugins, commit lock file, and push
nvim --headless "+Lazy! restore" +qa    # Restore plugins from lazy-lock.json
nvim --headless "+Lazy! update" +qa     # Update all plugins
```

### Code Formatting and Linting

The configuration uses conform.nvim for formatting and nvim-lint for linting:

- `:Format` - Format current buffer or selection
- `:FormatToggle` - Toggle autoformat-on-save globally
- `:FormatToggle!` - Toggle autoformat-on-save for current buffer only

Supported formatters: stylua (Lua), prettierd (HTML/JSON/Markdown), shfmt (shell), terraform_fmt, prettier_yaml

### AI Assistance

Two AI systems are configured:

- **CodeCompanion**: `<leader>ac` to toggle chat, `<C-a>` for actions, `ga` to add selection to chat
- **Copilot**: Integrated via blink.cmp for completions

## Architecture & Key Components

### Configuration Structure

- `init.lua` - Entry point, sets up lazy.nvim and loads core modules
- `lua/basics.lua` - Basic Vim settings, keymaps, and autocmds
- `lua/plugins.lua` - Main plugin specification using lazy.nvim format
- `lua/config-*.lua` - Individual plugin configurations
- `lua/auto-dark-mode.lua` - System theme integration reading from `~/.cache/system-theme.txt`

### Theme Management

The configuration automatically switches between light/dark modes by:

1. Reading system theme from `~/.cache/system-theme.txt` (managed by external dotfiles)
2. Setting `vim.o.background` accordingly
3. Reconfiguring lualine and tiny-inline-diagnostic for the new theme
4. Using tokyonight colorscheme with storm (dark) and day (light) variants

### LSP and Completion Setup

- **LSP**: Configured in `config-lsp.lua` with support for multiple languages
- **Completion**: Uses blink.cmp with Copilot integration
- **Formatting**: conform.nvim handles format-on-save with language-specific formatters
- **Linting**: nvim-lint provides additional diagnostics for Dockerfile, Markdown

### Key Plugin Integrations

- **File Explorer**: Neo-tree (main) and Oil.nvim (alternative)
- **Fuzzy Finding**: fzf-lua for files, buffers, diagnostics, symbols
- **Git Integration**: Fugitive, Gitsigns for git operations and diff viewing
- **Navigation**: Leap.nvim for quick movement, nvim-navigator for split navigation
- **Session Management**: mini.sessions with project-based session naming

### Which-Key Keybinding Structure

The configuration uses which-key for discoverable keybindings organized by prefix:

- `<leader>a` - AI operations (CodeCompanion)
- `<leader>c` - Code operations (formatting, etc.)
- `<leader>d` - Debug operations (DAP integration)
- `<leader>e` - Explore (Neo-tree file/buffer/git views)
- `<leader>f` - Find files (fzf-lua)
- `<leader>l` - LSP operations (diagnostics, symbols, actions)
- `<leader>s` - Search operations (buffers, text, branches, etc.)
- `<leader>S` - Session management
- `<leader>t` - Terminal operations
- `<leader>w` - Window management

### Environment-Specific Features

- **Neovide**: Custom font, cursor effects, and macOS-style keybindings
- **Tmux Integration**: Cursor shape changes for insert/normal mode
- **Python Development**: Dedicated DAP configuration and virtual environment support
- **Terminal Integration**: Works with both native terminal and FloatTerm

## Development Workflow

When working on this configuration:

1. Plugin changes should be made in `lua/plugins.lua`
2. Plugin-specific configuration goes in separate `lua/config-*.lua` files
3. Use `:Lazy` to manage plugins interactively
4. Test theme switching by manually changing `~/.cache/system-theme.txt` and sending SIGUSR1 signal
5. Session management follows git repository structure for naming

