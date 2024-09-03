# 🚀 My Neovim Configuration

Welcome to my Neovim configuration! This setup is designed to provide a powerful, efficient, and enjoyable coding experience. This config might be very opinionated and specific to my use-cases, but I hope it helps or inspires someone else as well!

> [!NOTE]
> Some parts of this setup work in conjunction with my general dotfile repository at [strayer/dotfiles](https://github.com/strayer/dotfiles), especially the auto dark/light mode feature.

## ✨ Features

- 🎨 Modern and sleek UI with carefully chosen colorschemes
- 🧠 Intelligent code completion powered by nvim-cmp
- 🔍 Fuzzy finding capabilities with fzf-lua
- 🌳 File explorer with oil.nvim and neo-tree
- 🔧 Robust LSP configuration for various languages (including Ansible, Bash, Docker, Python, Lua, Terraform, Vue, YAML, Ruby, JSON, Go, PowerShell, and more)
- 🧩 Syntax highlighting and advanced code analysis with Treesitter
- 🤖 AI-assisted coding integration with gp.nvim and avante.nvim
- 📊 Handy status line with lualine
- 🚀 Efficient plugin management with lazy.nvim
- 🌓 Automatic dark/light mode switching based on system preferences

## 🛠 Installation

> [!NOTE]
> Currently tested with Neovim v0.10.1

1. Clone this repository:
   ```sh
   git clone https://github.com/yourusername/neovim-config.git ~/.config/nvim
   ```
2. Start Neovim and let it install the plugins:
   ```sh
   nvim
   ```

## 🎮 Key Mappings

This configuration uses which-key as a central part of the key binding setup, providing an interactive menu for discovering and using keybindings. Here are some of the main custom mappings related to core features:

- `<Leader>f`: Fuzzy find files (fzf-lua)
- `<Leader>s`: Various search operations (buffers, git branches, diagnostics, etc.)
- `<Leader>e`: File explorer operations (neo-tree)
- `<Leader>l`: LSP-related commands
- `<Leader>d`: Debugging commands
- `<C-h/j/k/l>`: Navigate between splits (works across both Neovim and Wezterm splits)

Press `<Leader>` (space key) to bring up the which-key menu and explore more available commands.

## 📜 License

Copyright 2024 Sven Grunewaldt

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
