# Neovim Character and Plugin Audit

This is the durable context for turning this configuration into a smaller,
intentional editor. Read this file before implementing the audited cleanup or
resuming related work in a fresh session.

## Authoritative handoff status

As of 2026-07-10, the plugin audit is complete and cleanup implementation is in
progress.

- All 63 resolved plugin entries have a verdict: 52 direct entries including
  `lazy.nvim`, plus 11 dependency-only entries.
- There are no unresolved plugin decisions and no further adversarial challenge
  is required. Later focused assessments supersede provisional batch wording.
- The target graph is 26 lockfile entries: 23 retained direct plugins including
  `lazy.nvim`, plus 3 retained dependency-only plugins. In `lua/plugins.lua`
  this means 22 retained direct specs because Lazy is bootstrapped separately.
- The Neo-tree migration is implemented in isolated commit `1bf68ef`
  (`chore(neo-tree): upgrade to v3`). The in-editor AI removal is implemented in
  isolated commit `8a6d89d` (`refactor(ai): remove in-editor AI plugins`), and
  completion simplification is implemented in `9296ec5`
  (`refactor(completion): simplify Blink and scope LazyDev`). UI consolidation
  is implemented in `a4d8f76`
  (`refactor(ui): consolidate UI helpers into mini.nvim`), and navigation
  cleanup is implemented in `16e125a`
  (`refactor(navigation): simplify movement and discovery mappings`). Browser
  Markdown preview removal is implemented in `101d600`
  (`refactor(markdown): remove browser preview`). Every remaining verdict is
  still a target-state decision, not a description of the current configuration.
- Leap and Lualine implementation edits were deliberately reverted before the
  Neo-tree commit to keep it isolated; their final decisions are now applied in
  `16e125a` and `a4d8f76`, respectively.
- MiniFiles, MiniClue, and Neovim UI2 are explicitly deferred future
  experiments. They must not block or expand the cleanup implementation.
- This audit document was added separately in `b84b8d1`
  (`docs(nvim): record plugin audit and cleanup plan`) so the Neo-tree migration
  stayed isolated.
- Keep this document synchronized with implementation progress. Record every
  completed functional commit and update the active group before starting the
  next one.

Source-of-truth precedence inside this document:

1. This handoff section, the final target manifest, and the implementation plan.
2. The direct and dependency ledgers.
3. Focused assessments I01-I08.
4. Earlier batch/decision-log wording, which is retained as history and may
   describe a provisional state that a later assessment superseded.

Do not restart the plugin debate from scratch. Re-open a decision only if
implementation reveals a concrete incompatibility that the recorded plan does
not cover.

### Implementation ledger

| Group | Status | Commit / current state |
| --- | --- | --- |
| Neo-tree v3 migration | Complete | `1bf68ef`; included in `main` and preserved on this branch. |
| Audit and cleanup plan | Complete | `b84b8d1`. |
| Remove in-editor AI plugins | Complete | `8a6d89d`; removed Copilot, BlinkCopilot, CodeCompanion, ClaudeCode, and Snacks plus their active mappings/configuration. |
| Simplify completion and LazyDev | Complete | `9296ec5`; removed Friendly Snippets and luvit-meta, narrowed Blink sources, and scoped LazyDev. |
| Consolidate UI helpers into Mini.nvim | Complete | `a4d8f76`; updated Mini.nvim, enabled the approved modules, and removed their standalone predecessors. |
| Simplify navigation and discovery | Complete | `16e125a`; moved Leap, restored context-specific Enter, removed navigation plugins, and fixed native LSP actions. |
| Remove browser Markdown preview | Complete | `101d600`; Markview remains the core Markdown renderer. |
| Prefer native filetype support | In progress | Remove six legacy language plugins and add native Caddy detection. |
| Remaining cleanup groups | Pending | Development tools and final documentation. |

The resolved lockfile contained 58 entries after the AI-removal commit, 56 after
completion simplification, 49 after UI consolidation, and 41 after navigation
cleanup. Browser-preview removal reduced it to 40. Before verifying the AI
commit, `:Lazy restore` reconciled the shared installed state to the committed
lockfile; Neo-tree and nvim-window-picker now match `1bf68ef` instead of their
stale pre-migration installed checkouts.

## Final target manifest

Retain these 23 direct plugins, counting bootstrapped Lazy:

| Plugin | Final responsibility | Required implementation action |
| --- | --- | --- |
| `lazy.nvim` | Plugin manager | No change; plugin-manager evolution remains a future topic. |
| `vim-fugitive` | Git command/buffer workflow | No change. |
| `leap.nvim` | Fast two-dimensional motion | Moved to `<CR>`/`g<CR>` and removed `vim-repeat` in `16e125a`. |
| `vim-floaterm` | Frequently used floating terminal | No change. |
| `lualine.nvim` | Polished global statusline | Stale `lsp_progress` removed and Neo-tree extension configured in `a4d8f76`. |
| `neo-tree.nvim` | Primary filesystem/buffer/Git explorer | Already upgraded to v3 in `1bf68ef`; preserve that commit. |
| `which-key.nvim` | Current keymap discovery UI | Kept; removal-specific stale mappings cleaned in `16e125a`. Full normalization is deferred. |
| `blink.cmp` | Completion | I05 provider/dependency refresh completed in `9296ec5`. |
| `tree-sitter-manager.nvim` | Parser management | No change. |
| `tokyonight.nvim` | Intentional dark theme | No change. |
| `catppuccin` | Intentional light theme | No change. |
| `fidget.nvim` | Sole LSP-progress display | Retained; MiniNotify LSP progress disabled in `a4d8f76`. |
| `nvim-lspconfig` | Server-specific LSP definitions | Modern architecture retained; native diagnostics and LuaLS settings fixed in `16e125a`. |
| `SchemaStore.nvim` | Frequently used JSON/YAML schemas | No change. |
| `nvim-lint` | Diagnostics where LSPs are missing/subpar | Narrow loading and explicitly schedule the initial lint. |
| `conform.nvim` | Format-on-save and manual formatting | Uses `vim.notify` after `a4d8f76`. |
| `mini.nvim` | Consolidation hub and editing utilities | Approved modules/configuration completed in `a4d8f76`. |
| `markview.nvim` | Core in-Neovim Markdown rendering | Kept; obsolete AI filetypes removed in `8a6d89d` and browser preview removed in `101d600`. |
| `fzf-lua` | Sole picker and `vim.ui.select` implementation | `ui_select = true` configured in `a4d8f76`; current interaction model retained. |
| `lazydev.nvim` | Neovim-config Lua metadata/completion | Neovim-config scope, bundled luv types, and Blink provider completed in `9296ec5`. |
| `tiny-inline-diagnostic.nvim` | Polished inline diagnostics | No change. |
| `csvview.nvim` | Occasional CSV table/navigation workflow | No change; retain command-lazy loading. |
| `vim-illuminate` | Semantic references with lexical fallback | No change. |

Retain exactly these dependency-only plugins:

| Dependency | Required by |
| --- | --- |
| `plenary.nvim` | Neo-tree |
| `nui.nvim` | Neo-tree |
| `nvim-window-picker` | Neo-tree split targeting; already upgraded to v2 in `1bf68ef` |

Every direct or dependency plugin not listed above is approved for removal or
replacement. The complete rationale remains in the ledgers below.

## Final Mini.nvim shape

Mini.nvim is one plugin with independent modules. The target module set is:

- Keep existing: `mini.starter`, `mini.sessions`, `mini.indentscope`,
  `mini.icons`, `mini.surround`, and `mini.diff`.
- Added in `a4d8f76`: `mini.trailspace`, `mini.pairs`, `mini.hipatterns`,
  `mini.input`, and `mini.notify`.
- Configure `mini.diff` with `view.style = "sign"` explicitly. Its default is
  number-column highlighting when line numbers are enabled, which would not
  satisfy the requested Gitsigns-style sign column.
- Configure MiniHipatterns for standalone `FIXME`, `HACK`, `TODO`, and `NOTE`
  words using the module's corresponding highlight groups.
- Configure MiniNotify with `lsp_progress.enable = false`; Fidget is the only
  LSP-progress owner. `MiniNotify.setup()` installs the `vim.notify` override.
- MiniInput owns `vim.ui.input`; FzfLua owns `vim.ui.select` via
  `require("fzf-lua").setup({ ui_select = true })`.
- The installed Mini checkout at audit time did not yet contain `mini.input`,
  although the fetched current `main` README does. `a4d8f76` updated Mini.nvim
  from `48555f1` to `4171fba` before enabling the module.
- Do not enable `mini.files`, `mini.clue`, `mini.statusline`, `mini.pick`, or
  `mini.jump2d` during this cleanup. They are either future experiments or were
  rejected in favor of a retained interaction system.

## Authoritative implementation plan

Continue implementing this plan; do not perform another plugin audit. Keep
unrelated user changes intact and do not undo Neo-tree commit `1bf68ef` or the
completed cleanup commits recorded above.

### Upstream documentation gate for new plugins/modules

Before installing or configuring any new plugin—or enabling a Mini.nvim module
that was not previously active—fetch its current official documentation first.
Do not configure from model memory, old local help, screenshots, search-result
snippets, or another distribution's copied configuration.

Required workflow:

1. Identify the canonical upstream documentation URL and verify that it belongs
   to the plugin/module's official project.
2. For an HTML documentation page, invoke the `scrape` skill on that specific
   URL with its freshness option because current documentation is required. The
   skill scrapes one page at a time; scrape every directly relevant page.
3. Follow the `scrape` skill's own routing rule for plain `.md`, `.txt`, JSON,
   or raw README URLs: fetch those directly with `curl` instead of spending a
   Firecrawl scrape. This still satisfies the documentation gate.
4. Read the relevant installation, requirements, configuration, lazy-loading,
   migration/breaking-change, and health-check sections before editing config.
5. Record the exact URL, retrieval date, and any version/branch assumptions in
   this document or the implementation notes. Cite the option/API that informed
   non-default configuration.
6. Only then add the plugin/module and its lockfile change. If current upstream
   documentation contradicts this audit, stop and present the concrete conflict
   instead of silently improvising.

For the present target this gate applies especially to newly enabled
MiniTrailspace, MiniPairs, MiniHipatterns, MiniInput, and MiniNotify. The Mini
README/module docs were fetched on 2026-07-10, but a future implementation
session should refresh them if upstream may have changed.

Implementation documentation log:

- 2026-07-10, current `main` branch: Blink source configuration at
  <https://raw.githubusercontent.com/Saghen/blink.cmp/main/doc/configuration/sources.md>.
  This confirms `sources.per_filetype.lua = { inherit_defaults = true,
  "lazydev" }` for adding LazyDev only to Lua completion.
- 2026-07-10, current `main` branch: LazyDev installation and configuration at
  <https://raw.githubusercontent.com/folke/lazydev.nvim/main/README.md>. This
  confirms `${3rd}/luv/library`, `opts.enabled(root_dir)`, provider module
  `lazydev.integrations.blink`, and `score_offset = 100`.
- 2026-07-10, current `main` branch: official Mini.nvim module documentation for
  [MiniTrailspace](https://raw.githubusercontent.com/nvim-mini/mini.nvim/main/doc/mini-trailspace.txt),
  [MiniPairs](https://raw.githubusercontent.com/nvim-mini/mini.nvim/main/doc/mini-pairs.txt),
  [MiniHipatterns](https://raw.githubusercontent.com/nvim-mini/mini.nvim/main/doc/mini-hipatterns.txt),
  [MiniInput](https://raw.githubusercontent.com/nvim-mini/mini.nvim/main/doc/mini-input.txt),
  [MiniNotify](https://raw.githubusercontent.com/nvim-mini/mini.nvim/main/doc/mini-notify.txt),
  and [MiniDiff](https://raw.githubusercontent.com/nvim-mini/mini.nvim/main/doc/mini-diff.txt).
  These confirm default setup for Trailspace/Pairs/Input, standalone frontier
  patterns and built-in groups for Hipatterns, `lsp_progress.enable = false`
  for Notify, and `view.style = "sign"` for Diff.

### 1. Reduce the plugin graph

Remove these direct specs from `lua/plugins.lua`:

- `vim-better-whitespace`, `nvim-navigator`, `todo-comments.nvim`,
  `markdown-preview.nvim`, `vim-fish`, `gitsigns.nvim`, `lspsaga.nvim`,
  `nvim-lightbulb`, `nvim-autopairs`, `nvim-neoclip.lua`, `trouble.nvim`,
  `tree-sitter-ghostty`, `nvim-dap`, `yaml.nvim`, `vim-caddyfile`, `nvim-ufo`,
  `noice.nvim`, `vim-python-pep8-indent`, `no-neck-pain.nvim`,
  `vim-startuptime`, `luvit-meta`, `oil.nvim`, `mise.nvim`, `dressing.nvim`,
  `vim-kitty`, `copilot.lua`, `codecompanion.nvim`, `claudecode.nvim`, and
  `grug-far.nvim`.

Remove these dependency specs when their parents/integrations disappear:

- `vim-repeat`, `friendly-snippets`, `blink-copilot`, `nvim-dap-python`,
  `promise-async`, `statuscol.nvim`, `nvim-notify`, and `snacks.nvim`.

Do not remove `plenary.nvim`, `nui.nvim`, or `nvim-window-picker`; Neo-tree still
requires them. Keep the Neo-tree/window-picker v3/v2 changes already committed.
The AI plugin subset and its dependency-only integrations were removed in
`8a6d89d`; Friendly Snippets and luvit-meta were removed in `9296ec5`. UI
consolidation entries were removed in `a4d8f76`. The entries in these lists
covered by navigation were removed in `16e125a`, and browser preview was removed
in `101d600`; filetype and development-tool entries remain pending.

### 2. Apply retained-plugin configuration decisions

- Leap:
  - Remove the `vim-repeat` dependency.
  - Map `<CR>` in normal, visual, and operator-pending modes to
    `<Plug>(leap)`.
  - Map normal `g<CR>` to `<Plug>(leap-from-window)`.
  - Add the already-agreed explanatory comment: Leap's `s` default collides
    with MiniSurround's `sa`/`sd`/`sr` namespace, and normal Enter is not used
    for line movement.
  - Restore ordinary buffer-local `<CR>` in quickfix buffers and the command
    window, following MiniJump2d's safeguards.
- Lualine:
  - Remove the stale/nonexistent `lsp_progress` component; do not substitute
    `lsp_status` because Fidget owns progress.
  - Change extension `nvim-tree` to `neo-tree`; retain `fugitive`.
- Blink:
  - Remove Friendly Snippets and BlinkCopilot dependencies.
  - General sources are exactly `lsp`, `path`, and `buffer`.
  - Remove snippet, Copilot, and CodeCompanion sources/providers/icons.
  - Add `lazydev` only for Lua with
    `per_filetype.lua = { inherit_defaults = true, "lazydev" }`, provider
    module `lazydev.integrations.blink`, and `score_offset = 100`.
  - Remove `appearance.use_nvim_cmp_as_default` and `opts_extend`.
  - Preserve Super-Tab, rounded menu/documentation windows, zero-delay docs,
    Nerd Font Mono mode, release version selection, and LSP capabilities.
- FzfLua: change setup to `{ ui_select = true }`; do not enable MiniPick.
- Markview: remove obsolete `Avante` and `codecompanion` entries from its
  filetype/preview lists; retain Markdown, Quarto, and R Markdown behavior.
- nvim-lint:
  - Lazy-load only for `markdown` and `dockerfile` filetypes.
  - Keep markdownlint-cli2 and Hadolint assignments.
  - Retain debounced `BufWritePost` and `InsertLeave` linting.
  - Remove the fragile `BufReadPost` dependency and schedule one
    `lint.try_lint()` after setup so the initially opened buffer is checked.
- LazyDev:
  - Keep `ft = "lua"` and add an `enabled(root_dir)` check restricted to the
    normalized `vim.fn.stdpath("config")` root.
  - Replace `"luvit-meta/library"` with
    `{ path = "${3rd}/luv/library", words = { "vim%.uv" } }`.
  - Its Blink integration is configured in Blink, not as another dependency.
- Retained LSP configuration:
  - Replace broken `[d`/`]d` calls to nonexistent
    `vim.lsp.diagnostic.goto_prev/goto_next` with Neovim 0.12
    `vim.diagnostic.jump({ count = -1 })` and
    `vim.diagnostic.jump({ count = 1 })` callbacks.
  - Correct the LuaLS settings shape to
    `settings = { Lua = { workspace = { checkThirdParty = false }, telemetry =
    { enable = false } } }`. The current config both misspells
    `checkThirdParty` and omits the required `Lua` wrapper.
  - Do not otherwise redesign the retained server list or LSP architecture.
- Conform: use `vim.notify(message, level, { title = "conform.nvim" })`
  instead of directly requiring nvim-notify.
- Caddy detection: after removing `vim-caddyfile`, add native filetype rules
  covering `Caddyfile`, `*.Caddyfile`, `*.caddyfile`, and `Caddyfile.*`, all as
  `caddyfile`. Tree-sitter Manager already owns the Caddy parser.

### 3. Normalize Mini.nvim configuration

Update Mini.nvim first so the checkout contains the current `mini.input`
module. Then configure the exact target module set described above. Keep module
setup together unless splitting it materially improves loading or readability.

Important behavior checks during implementation:

- MiniTrailspace replaces the highlight behavior. Do not recreate
  vim-better-whitespace's leader mappings; they collide with the existing
  `<leader>s` search namespace and were not part of the required workflow.
- `mini.diff` must show dedicated Git signs, not color the number column.
- MiniPairs' Insert-mode `<CR>` behavior must coexist with Blink completion.
- MiniSurround must keep its complete `s...` namespace. The user's frequent
  quote-change workflow is MiniSurround replace, e.g. `sr"'`.
- MiniNotify must replace `vim.notify` without displaying LSP progress.
- MiniInput must replace Dressing's `vim.ui.input` behavior used by session-name
  prompts.

### 4. Clean keymaps without doing the deferred architecture rewrite

Keep WhichKey for now. Do not migrate every mapping out of its spec during this
cleanup; that is a separate future project. Remove or replace only mappings
made stale by approved plugin removals:

- Remove AI (`<leader>a`, `<leader>C`), DAP (`<leader>d...`), rnvimr
  (`<leader>r`), Neoclip registers (`<leader>sr`), Trouble (`<leader>lt`), and
  No Neck Pain (`<leader>wf`) groups/mappings.
- Remove broken `NvimTreeFindFile` on `<leader>?`; `<leader>ee` already reveals
  and toggles the current file in Neo-tree.
- Replace Lspsaga rename/hover with normal mappings whose callbacks call
  `vim.lsp.buf.rename()` and `vim.lsp.buf.hover()`.
- Replace `LspTypeDefinition` with `vim.lsp.buf.type_definition()`.
- Remove the unexplained `LspVirtualTextToggle` mapping unless implementation
  adds a small, deliberate native diagnostics toggle. Tiny Inline deliberately
  keeps native virtual text disabled.
- Leave the overlapping FzfLua file-picker mappings unchanged for now; the user
  did not choose a canonical one. Full keymap normalization and MiniClue remain
  deferred.

### 5. Remove orphaned artifacts and update documentation

Delete these tracked files after their owning workflows are removed:

- `lua/config-cmp.lua` (obsolete pre-Blink nvim-cmp configuration)
- `lua/config-gp.lua` (gp.nvim is already absent)
- `lua/config-rnvimr.lua` (rnvimr is already absent)
- `lua/config-dap-python.lua`
- `lua/config-trouble.lua`
- `lua/config-codecompanion.lua`
- `debugpy-requirements.txt`

Do not automatically delete ignored `lua/config-codecompanion-private.lua` or
`lua/config-gp-private.lua`; they may contain user-specific credentials or
settings. They are outside the tracked target and can be archived/deleted only
with explicit user direction.

Update both `README.md` and `CLAUDE.md`. They currently describe removed AI,
Oil, Gitsigns, DAP, nvim-navigator, old completion, and stale keymaps. Document
the final retained systems and Neovim 0.12 baseline instead. Keep `Justfile`,
`ftdetect/ssh.vim`, `lua/utils.lua`, theme switching, and the LSP server list
unless a concrete implementation issue appears.

### 6. Reconcile and clean installed state

- Run a Lazy operation that updates Mini.nvim and removes absent specs from the
  lockfile/installation without upgrading unrelated retained plugins unless
  required.
- Expected final graph: 26 lockfile entries, consisting of 23 direct plugins
  including Lazy and the 3 dependency-only plugins listed above.
- Re-measure loaded-plugin counts and disk usage after cleanup. Treat the old
  numbers as baseline, not acceptance thresholds.
- Keep the audit document separate from unrelated commits unless the user asks
  for a combined commit.

## Commit strategy for the cleanup

Do not implement the entire audit as one commit, and do not create individual
commits for dependency-only removals. A dependency, its parent, the associated
configuration/keymaps, orphaned files, and their lockfile hunks belong in the
same functional commit.

General commit rules:

- Preserve existing Neo-tree commit `1bf68ef`; do not amend or rewrite it.
- Stage explicit paths or hunks. Do not use `git add .` in this worktree.
- Keep each intermediate commit loadable with headless Neovim. Run at least a
  startup smoke test and `git diff --check` before committing.
- Include only the lockfile changes caused by that commit's plugin group. Do not
  mix unrelated retained-plugin upgrades into a removal commit.
- Delete an orphaned tracked config file in the same commit that removes its
  owner. Dependency-only plugins never receive standalone commits.
- Do not commit ignored private AI configuration. Do not bypass hooks in a new
  session without current user authorization.

Recommended sequence after `1bf68ef`:

1. `docs(nvim): record plugin audit and cleanup plan` - complete in `b84b8d1`.
2. `refactor(ai): remove in-editor AI plugins` - complete in `8a6d89d`.
   - Removed Copilot, BlinkCopilot, CodeCompanion, ClaudeCode, and Snacks.
   - Removed their Blink/Markview integrations, AI mappings, and tracked
     CodeCompanion configuration while preserving ignored private files.
3. `refactor(completion): simplify Blink and scope LazyDev` - complete in
   `9296ec5`.
   - Removed Friendly Snippets and luvit-meta.
   - Applied the recorded Blink and LazyDev provider, source, and workspace-scope
     decisions.
4. `refactor(ui): consolidate UI helpers into mini.nvim` - complete in
   `a4d8f76`.
   - Update Mini.nvim and add Trailspace, Pairs, Hipatterns, Input, and Notify.
   - Make MiniDiff use sign style.
   - Remove vim-better-whitespace, Todo Comments, nvim-autopairs, Gitsigns,
     Noice, nvim-notify, and Dressing.
   - Update Conform notifications, FzfLua `ui_select`, and Lualine in the same
     commit because they are the consumers/replacements of this UI group.
5. `refactor(navigation): simplify movement and discovery mappings` - complete
   in `16e125a`.
   - Restore Leap on `<CR>`/`g<CR>` and remove vim-repeat.
   - Remove nvim-navigator, Oil, Neoclip, No Neck Pain, Lspsaga, Trouble, and
     nvim-lightbulb.
   - Clean only the mappings made stale by those removals, replace retained LSP
     actions with native callbacks, fix native diagnostic navigation, and delete
     tracked Trouble/rnvimr configuration.
6. `refactor(markdown): remove browser preview` - complete in `101d600`.
   - Remove `markdown-preview.nvim`; Markview remains the core in-editor Markdown
     renderer.
7. `refactor(filetypes): prefer native language support` - in progress.
   - Remove vim-fish, vim-kitty, vim-python-pep8-indent, vim-caddyfile,
     tree-sitter-ghostty, and yaml.nvim.
   - Add native Caddyfile detection and retain Tree-sitter Manager's Caddy
     parser path.
8. `refactor(dev-tools): remove unused tools and narrow linting`
   - Remove DAP/DAP Python, the UFO/promise-async/statuscol folding stack,
     Grug Far, Mise, and vim-startuptime.
   - Delete DAP configuration and `debugpy-requirements.txt`.
   - Apply the retained nvim-lint loading/initial-run change.
   - Delete already-orphaned `config-cmp.lua` and `config-gp.lua` here if they
     were not naturally removed by an earlier group.
9. `docs(nvim): describe the slimmed configuration`
   - Update `README.md`, `CLAUDE.md`, and this document's implementation status.
   - Record final graph/load/disk measurements and completed verification.

The exact subject wording may change, but these functional boundaries should
remain. If a group becomes too large to verify safely, split it by workflow
(for example, separate DAP from folding), never by individual transitive
dependency.

## Acceptance checklist for the implementation

The cleanup is not complete until these checks pass:

- `git diff --check` and the repository's normal Lua formatting checks pass.
- Lazy resolves exactly the intended 26-entry graph with no removed plugin
  remaining solely because of a stale dependency.
- Empty, Markdown, Lua, Dockerfile, Caddyfile, Fish, Kitty, and CSV buffers open
  without errors; built-in Fish/Kitty and native Caddy detection set the expected
  filetypes.
- `:checkhealth neo-tree`, `:checkhealth which-key`, and
  `:checkhealth blink.cmp` pass after the relevant plugin has loaded.
- Neo-tree reveal/buffer/Git views, window-picker splits, and auto-close still
  work after dependency cleanup.
- `<CR>` starts Leap, `g<CR>` starts cross-window Leap, MiniSurround `s...`
  mappings remain reachable, and ordinary Enter still selects entries in
  quickfix, command, Neo-tree, and CSV contexts.
- MiniDiff uses sign-column visualization. Fugitive remains the Git command UI.
- FzfLua files/grep/diagnostics/LSP pickers still work and
  `vim.ui.select` resolves through FzfLua.
- `vim.ui.input` works through MiniInput for the MiniSessions naming prompt.
- `[d` and `]d` use the native Neovim 0.12 diagnostic API, and LuaLS receives
  settings under the correct `Lua` key.
- MiniNotify displays normal/Conform notifications while Fidget remains the only
  LSP-progress display.
- Blink health is clean; its general sources are LSP/path/buffer, and LazyDev is
  added only for Lua. No snippets, Copilot, or CodeCompanion provider remains.
- LazyDev activates for this Neovim config, supplies `vim.uv` types from LuaLS's
  bundled library, and stays disabled for unrelated Lua workspaces.
- Synthetic Markdown and Dockerfile checks still produce the previously
  observed markdownlint/Hadolint diagnostics after nvim-lint is narrowed.
- Format-on-save, `:Format`, `:FormatToggle`, both retained themes, Lualine,
  Tiny Inline Diagnostic, Markview, Floaterm, CSVView, Illuminate, and sessions
  remain functional.
- A repository-wide search outside this historical audit document finds no live
  mappings, requires, docs, or configuration references to removed plugins.

## Explicitly deferred future work

These are not pending audit failures and must not be implemented as part of the
slimming pass:

- Trial `mini.files` alongside retained Neo-tree in real use.
- Move mapping creation out of WhichKey into canonical normal/plugin mappings,
  then reassess MiniClue as a discovery-only layer.
- Experiment with Neovim 0.12 UI2 only after Noice is removed and the native UI
  has been used normally; UI2 remains private/experimental.
- Reassess Lazy versus native package management when the user next reviews the
  plugin-management situation.
- Reconsider CodeCompanion only if the user intentionally restores an in-editor
  AI workflow. It is the recorded preferred candidate, not a plugin to keep
  dormant.

## Desired character

- Neovim should be a focused text editor and coding environment, not a second
  general-purpose desktop or an accumulation of experiments.
- Every plugin must support a concrete, recurring workflow. "Might be useful"
  is not sufficient.
- Prefer maintained Neovim-native functionality over compatibility plugins and
  prefer built-in functionality when its workflow is good enough.
- There should be one clear tool for each job unless two tools serve genuinely
  different, named workflows.
- External AI tools exist. An in-editor AI plugin must prove a distinct benefit
  rather than being retained by default.
- TUI coding agents belong outside Neovim. Editor integrations for those agents
  should not be retained unless they establish a distinctly better workflow.
- Rich Markdown rendering inside Neovim is a core workflow. Browser preview is
  not required when the in-editor view is available.
- Visual polish is part of the editor's character. Consolidation should not
  replace a small, well-understood plugin with a visibly worse experience or a
  larger pile of custom configuration merely to reduce the plugin count.
- A narrow command-lazy plugin may stay for an occasional but distinct workflow
  when its purpose is remembered and no existing component covers it cleanly.
- Broken former muscle-memory workflows should be removed from the active setup
  but recorded for a post-audit reassessment against current alternatives.
- Keymaps should eventually have one canonical definition as normal Neovim or
  plugin mappings. The discovery layer should observe descriptions rather than
  own a parallel mapping specification.
- Prefer consolidating suitable workflows into the already-installed
  `mini.nvim` modules instead of adding parallel standalone plugins.
- Removal is reversible. An old compatibility plugin with no remembered current
  purpose should be removed and restored only if a concrete regression appears.
- Dormant integrations should be removed even when they are the preferred tool
  in their category. Record the preferred reintroduction candidate instead of
  keeping an unconfigured plugin installed.
- Optimize for low maintenance and a coherent mental model first. Startup time
  and disk usage are supporting evidence, not the only criteria.

This is the current design brief. Update it only when a new user decision
reveals a stronger preference about how the editor should feel.

## Audit protocol

1. Every directly declared plugin must receive a verdict.
2. Dependencies are reviewed with their parent. A dependency that survives
   after its parent is removed must justify itself independently.
3. The first challenge asks what concrete workflow earns the plugin a place.
4. Codex may disagree once more. That counter-challenge must explain the cost
   and offer a built-in, plugin, CLI, or external workflow alternative.
5. After that response, record a final verdict without continuing the debate.
6. Do not remove plugins merely because they are lazy-loaded. Plugin count,
   maintenance, overlap, and conceptual weight still matter.
7. Do not edit the actual plugin specification until decisions are recorded and
   implementation is explicitly requested.

Statuses: `Pending`, `Asked`, `Counter-challenged`, `Deferred`, `Keep`, `Remove`,
`Replace`, or `Merge into another workflow`.

## Directly measured baseline (2026-07-10)

- 51 directly declared plugins, plus `lazy.nvim` and 11 dependency-only
  plugins: 63 lockfile entries.
- 62 plugins are eligible in terminal Neovim; `mise.nvim` is conditional on
  Neovide.
- An empty session including `VeryLazy` loads 36 plugins.
- Opening Markdown loads 39; opening Lua loads 40.
- A representative Lua editing workflow reaches roughly 42 plugins after
  entering Insert mode and 44-47 after formatting, searching, LSP UI, or the
  secondary explorer are used.
- Installed plugin footprint: 580 MB. `copilot.lua` accounts for 328 MB; the
  full AI-related set accounts for about 377 MB.
- Opening an ordinary file loads the three-plugin UFO stack. A YAML buffer also
  loaded `yaml.nvim`, `fzf-lua`, and `snacks.nvim` in the observed config.

Treat timings as directional because they came from headless profiling. Loaded
plugin relationships and disk sizes were repeatable.

## Current Mini.nvim module catalog

Fetched from the current `main` README on 2026-07-10:
<https://raw.githubusercontent.com/nvim-mini/mini.nvim/refs/heads/main/README.md>

The README currently describes 46 independent modules:

- Text editing: `mini.ai`, `mini.align`, `mini.comment`, `mini.completion`,
  `mini.keymap`, `mini.move`, `mini.operators`, `mini.pairs`, `mini.snippets`,
  `mini.splitjoin`, `mini.surround`.
- General workflow: `mini.basics`, `mini.bracketed`, `mini.bufremove`,
  `mini.clue`, `mini.cmdline`, `mini.deps`, `mini.diff`, `mini.extra`,
  `mini.files`, `mini.git`, `mini.input`, `mini.jump`, `mini.jump2d`,
  `mini.misc`, `mini.pick`, `mini.sessions`, `mini.visits`.
- Appearance: `mini.animate`, `mini.base16`, `mini.colors`, `mini.cursorword`,
  `mini.hipatterns`, `mini.hues`, `mini.icons`, `mini.indentscope`, `mini.map`,
  `mini.notify`, `mini.starter`, `mini.statusline`, `mini.tabline`,
  `mini.trailspace`.
- Other: `mini.doc`, `mini.fuzzy`, `mini.test`.

Relevant consolidation candidates confirmed from the current module READMEs:

| Existing workflow/plugin | Mini candidate | Coverage note |
| --- | --- | --- |
| `vim-better-whitespace` | `mini.trailspace` | Highlights trailing whitespace and provides trim functions. Current standalone plugin has no custom configuration. |
| `nvim-autopairs` | `mini.pairs` | Minimal autopairs with pair-aware Backspace and Enter behavior. Current standalone plugin uses defaults. |
| `which-key.nvim` | `mini.clue` | Reads mapping descriptions and shows next-key clues, but uses opt-in triggers and has documented buffer-local mapping/macro caveats. |
| `lualine.nvim` | `mini.statusline` | Customizable statusline; works with `mini.git`, `mini.diff`, and existing `mini.icons`. Fidget can own LSP progress. |
| `todo-comments.nvim` | `mini.hipatterns` | Can highlight TODO/FIXME/HACK/NOTE patterns, but does not itself provide Todo Comments' signs/search commands. |
| `vim-illuminate` | `mini.cursorword` | Highlights lexical word-under-cursor only; semantic LSP references would instead need native document-highlight autocmds. |
| `fzf-lua` | `mini.pick` + `mini.extra` | Covers current files, grep, buffers, diagnostics, Git branches, histories, marks, colorschemes, registers, and LSP navigation. Native code actions cover the missing direct code-action picker. |
| `neo-tree.nvim` / removed Oil | `mini.files` | File navigation and manipulation with a different, buffer-oriented column workflow; does not reproduce every sidebar/buffer/Git-status view. |
| Gitsigns sign-column use | `mini.diff` | Provides sign visualization, overlay, navigation, and hunk apply/reset. |
| `dressing.nvim` | `mini.input` + retained FzfLua | MiniInput implements `vim.ui.input`; configure FzfLua with `ui_select = true` for `vim.ui.select`. No need to retain Snacks solely for input. |
| `nvim-notify` | `mini.notify` | MiniNotify supplies `vim.notify`, update/remove/clear, history, and optional LSP progress. Disable its LSP progress when Fidget owns that job. Visual style remains the main reason to prefer nvim-notify. |

Planned upstream modules are not valid current replacements. In particular,
`mini.folds`, `mini.terminals`, `mini.quickfix`, and `mini.windows` are only
listed as future ideas in the current README.

## Completed batch: B01 - duplicates and obsolete compatibility

Reply using the IDs below. For each item, state `keep`, `remove`, `replace`, or
`unsure`, followed by the concrete workflow or behavior that matters.

| ID | Plugin(s) | First challenge | Status | Counter-challenge used? |
| --- | --- | --- | --- | --- |
| B01.1 | `neo-tree.nvim` / `oil.nvim` | Keep primary Neo-tree; remove Oil; record `mini.files` as a future experiment without adding a plugin now. | Decided | No |
| B01.2 | `gitsigns.nvim` / `mini.diff` | Remove Gitsigns. The user only needs sign-column visualization, which MiniDiff provides. | Remove Gitsigns | Yes |
| B01.3 | `markdown-preview.nvim` / `markview.nvim` | Keep Markview because in-Neovim rendering is a core workflow. Remove the rarely used browser preview. | Keep Markview; remove browser preview | Yes |
| B01.4 | `vim-fish` | Neovim 0.12 has sufficient built-in Fish support; no missing behavior remembered. | Remove | No |
| B01.5 | `vim-kitty` | Neovim 0.12 has sufficient built-in Kitty support; no missing behavior remembered. | Remove | No |
| B01.6 | `vim-python-pep8-indent` | Remove the old indentation workaround; restore only if a current newline-indent regression is observed. | Remove | No |
| B01.7 | `lspsaga.nvim` | Remove; current use is limited to rename and hover, both now native LSP operations. | Remove | No |
| B01.8 | `trouble.nvim` | Remove; the user normally uses an LSP diagnostics view and accepts FzfLua as its replacement. | Remove | No |
| B01.9 | `nvim-lightbulb` | Remove; the user does not depend on a persistent code-action indicator. | Remove | No |
| B01.10 | `fidget.nvim` | Keep; its larger progress display is preferred for verbose LSP output that does not fit the statusline. Review removal of Lualine's duplicate LSP-progress component later. | Keep | No |

## Completed batch: B02 - consolidate into Mini.nvim

Reply using the IDs below. For each item, state `keep standalone`, `replace
with Mini`, `remove without replacement`, or `unsure`, followed by the behavior
that matters.

| ID | Existing plugin / Mini alternative | First challenge | Status | Counter-challenge used? |
| --- | --- | --- | --- | --- |
| B02.1 | `vim-better-whitespace` / `mini.trailspace` | Replace with MiniTrailspace; current standalone behavior is covered. | Replace with Mini | No |
| B02.2 | `nvim-autopairs` / `mini.pairs` | Replace with MiniPairs; no advanced standalone integration is used. | Replace with Mini | No |
| B02.3 | `which-key.nvim` / `mini.clue` | Keep WhichKey now because it is elemental, small, lazy-loaded, and healthy. The user dislikes mixing ordinary mappings with WhichKey-owned mappings; normalize mappings in a future project, then reconsider MiniClue as an observer-only discovery layer. | Keep; future architecture revisit | No |
| B02.4 | `lualine.nvim` / `mini.statusline` | Keep Lualine after the completed I07 revisit because its polish matters and recreating it would increase custom-config maintenance. Remove its duplicate LSP-progress component in favor of Fidget. | Keep | Yes |
| B02.5 | `todo-comments.nvim` / `mini.hipatterns` | Replace with MiniHipatterns; only highlighting is used. | Replace with Mini | No |
| B02.6 | `vim-illuminate` / `mini.cursorword` or native LSP highlighting | Keep Illuminate. Its default provider priority is already LSP, Tree-sitter, then regex, which directly supplies semantic references with lexical fallback. | Keep Illuminate | No |
| B02.7 | `fzf-lua` / `mini.pick` + `mini.extra` | Keep FzfLua after picker-by-picker assessment. Mini covers the categories, but replacing a healthy, lazy-loaded, elemental interaction system offers little benefit. FzfLua also replaces Dressing's `vim.ui.select` role. | Keep FzfLua | No |

## Completed batch: B03 - AI, UI, and convenience surfaces

Reply using the IDs below with `keep`, `remove`, `replace`, or `unsure` and the
concrete recurring workflow.

| ID | Plugin(s) | First challenge | Status | Counter-challenge used? |
| --- | --- | --- | --- | --- |
| B03.1 | `copilot.lua` + `blink-copilot` | Remove; inline suggestions are not used. | Remove | No |
| B03.2 | `codecompanion.nvim` | Remove while dormant. Record it as the preferred candidate if in-editor AI is intentionally restored later. | Remove | Yes |
| B03.3 | `claudecode.nvim` + `snacks.nvim` | Remove; TUI agents are always run outside Neovim. Snacks is not needed for the Dressing replacement. | Remove | No |
| B03.4a | `noice.nvim` | Remove because of observed bugs and overlap with Neovim 0.12. Record UI2 as a post-audit experiment, not a current replacement, because it is explicitly experimental/private. | Remove | No |
| B03.4b | `nvim-notify` / `mini.notify` | Replace with MiniNotify; Fidget remains responsible for LSP progress. | Replace with Mini | Yes |
| B03.5 | `dressing.nvim` | Remove the archived plugin. Use `mini.input` for `vim.ui.input` and FzfLua's `ui_select = true` for `vim.ui.select`; do not keep Snacks only for input. | Replace | No |
| B03.6 | `vim-floaterm` | Keep; it is liked, frequently used, focused, and maintained. Current alternatives would add custom code or reverse consolidation decisions. | Keep | Yes |
| B03.7 | `no-neck-pain.nvim` | Remove; it has never been used. | Remove | No |
| B03.8 | `nvim-neoclip.lua` | Remove; register history has never been used. | Remove | No |

## Completed batch: B04 - specialist development tools

Reply with `keep`, `remove`, `replace`, or `unsure` and the concrete recurring
workflow. Rare use can still qualify, but "support might be useful" does not.

| ID | Plugin(s) | First challenge | Status | Counter-challenge used? |
| --- | --- | --- | --- | --- |
| B04.1 | `nvim-dap` + `nvim-dap-python` | Remove; debugging is not done inside Neovim. | Remove | No |
| B04.2 | `nvim-lint` | Keep after direct assessment. It explicitly owns live diagnostics where LSP coverage is missing or subpar. Restrict loading to Markdown/Dockerfile buffers and explicitly run initial lint after setup. | Keep; narrow loading | No |
| B04.3 | `conform.nvim` | Keep; format-on-save is a core editor responsibility. | Keep | No |
| B04.4 | `yaml.nvim` | Remove; its specialized commands are not used. | Remove | No |
| B04.5 | `csvview.nvim` | Keep; its distinct CSV table/navigation workflow is used sometimes and is command-lazy. | Keep | No |
| B04.6 | `vim-caddyfile` | Remove the legacy Vim plugin. Add a built-in `vim.filetype.add()` rule for `Caddyfile` and use Tree-sitter Manager's existing `tree-sitter-caddy` support. | Replace | Yes |
| B04.7 | `tree-sitter-ghostty` | Remove; dedicated Ghostty parsing is not valued. | Remove | No |
| B04.8 | `mise.nvim` | Remove; the Neovide-only integration is not used. | Remove | No |
| B04.9 | `lazydev.nvim` + `luvit-meta` | Keep LazyDev, scoped to the Neovim-config workspace. Remove luvit-meta and use LuaLS's bundled `${3rd}/luv/library`, loaded only on `vim.uv`. Both upstream projects are maintained, but the separate metadata repository is no longer needed for this use. | Keep LazyDev; remove luvit-meta | No |
| B04.10 | `vim-startuptime` | Remove; no remembered use and built-in/Lazy profiling alternatives exist. | Remove | No |

## Completed batch: B05 - navigation, Git, folding, and project editing

Reply with `keep`, `remove`, `replace`, or `unsure` and the concrete recurring
workflow.

| ID | Plugin(s) | First challenge | Status | Counter-challenge used? |
| --- | --- | --- | --- | --- |
| B05.1 | `vim-fugitive` | Keep; Fugitive is used frequently and is the established Git interface. | Keep | No |
| B05.2 | `nvim-navigator` | Remove; tiling window managers replaced the cross-pane workflow, it does not work with Ghostty, and Neovim splits are now uncommon. | Remove | No |
| B05.3 | `leap.nvim` + `vim-repeat` | Initial removal was superseded by I06: keep Leap on `<CR>`/`g<CR>` after diagnosing its MiniSurround collision, and remove unused `vim-repeat`. | Keep Leap; remove vim-repeat | No |
| B05.4 | `nvim-ufo` + `promise-async` + `statuscol.nvim` | Remove; enhanced folding is not used deliberately enough to justify a three-plugin per-file stack. | Remove | No |
| B05.5 | `grug-far.nvim` | Remove; it was used once and no longer has a recurring project-replacement workflow. | Remove | No |
| B05.6 | `tree-sitter-manager.nvim` | Keep; parser management is actively tracked and intentionally remains centralized here for now. | Keep | No |

## Completed batch: B06 - core editor foundation

Reply with `keep`, `remove`, `replace`, `defer`, or `unsure` and the concrete
workflow. These are foundational choices, so deferring an elemental interaction
for a dedicated assessment is acceptable.

| ID | Plugin(s) | First challenge | Status | Counter-challenge used? |
| --- | --- | --- | --- | --- |
| B06.1 | `lazy.nvim` | Keep for now; plugin management changes in Neovim are being actively tracked. | Keep | No |
| B06.2 | `blink.cmp` | Keep; completion works and is foundational. I05 completed the current-config assessment; apply that refresh when removing Copilot/snippets. | Keep; configuration action recorded | No |
| B06.3 | `friendly-snippets` | Remove; snippets have never been used. Remove Blink's snippet provider as part of implementation. | Remove | No |
| B06.4 | `tokyonight.nvim` / `catppuccin` | Keep both; the exact dark/light theme pairing is intentional. | Keep both | No |
| B06.5 | `nvim-lspconfig` | Keep. Neovim supplies the client/API, while nvim-lspconfig supplies server-specific configs merged by `vim.lsp.config`. The current config already uses the modern API; enabled configs start only for matching filetypes/roots. | Keep | No |
| B06.6 | `SchemaStore.nvim` | Keep; schema validation is used very often. | Keep | No |
| B06.7 | `tiny-inline-diagnostic.nvim` | Keep after comparison with native Neovim 0.12 diagnostics; its no-shift, polished inline presentation remains preferred. | Keep | Yes |

## Direct plugin ledger

| ID | Plugin | Primary role | Status | Decision rationale |
| --- | --- | --- | --- | --- |
| P00 | `lazy.nvim` | Plugin manager | Keep | Keep while actively tracking Neovim's plugin-management evolution |
| P01 | `vim-better-whitespace` | Whitespace highlighting/cleanup | Replace | Use `mini.trailspace` |
| P02 | `vim-fugitive` | Git commands and buffers | Keep | Frequently used established Git interface |
| P03 | `nvim-navigator` | Navigation across Neovim and terminal multiplexer panes | Remove | Tiling WM replaced workflow; broken with Ghostty; splits uncommon |
| P04 | `todo-comments.nvim` | TODO/FIXME highlighting | Replace | Use `mini.hipatterns`; only highlighting is needed |
| P05 | `markdown-preview.nvim` | Browser Markdown preview | Remove | In-Neovim Markview rendering is the required workflow |
| P06 | `vim-fish` | Fish language support | Remove | Built-in Neovim 0.12 support is sufficient |
| P07 | `leap.nvim` | Motion/navigation | Keep | Restored on `<CR>`/`g<CR>` without conflicting with MiniSurround |
| P08 | `vim-floaterm` | Floating terminal | Keep | Liked, frequently used, focused, and currently maintained |
| P09 | `lualine.nvim` | Statusline | Keep | I07 final: its polish justifies 2.6 MB; remove stale progress/extension config |
| P10 | `neo-tree.nvim` | Sidebar file/buffer/Git explorer | Keep | Primary file explorer; v3 migration implemented in `1bf68ef` |
| P11 | `gitsigns.nvim` | Git signs and hunks | Remove | MiniDiff supplies the only used feature: sign-column visualization |
| P12 | `which-key.nvim` | Keymap discovery | Keep | Keep now; normalization and observer-only MiniClue are deferred future work |
| P13 | `blink.cmp` | Completion | Keep | Foundational; apply the completed I05 configuration refresh during cleanup |
| P14 | `lspsaga.nvim` | Enhanced LSP UI | Remove | Native LSP covers configured rename and hover actions |
| P15 | `nvim-lightbulb` | Code-action availability indicator | Remove | Indicator is not used |
| P16 | `nvim-autopairs` | Automatic character pairs | Replace | Use `mini.pairs`; no advanced integration is used |
| P17 | `nvim-neoclip.lua` | Clipboard/register history | Remove | Never used |
| P18 | `trouble.nvim` | Diagnostics/list UI | Remove | Use FzfLua diagnostics |
| P19 | `tree-sitter-ghostty` | Ghostty parser | Remove | Dedicated Ghostty parsing is not valued |
| P20 | `tree-sitter-manager.nvim` | Tree-sitter parser management | Keep | Actively tracked intentional parser manager |
| P21 | `tokyonight.nvim` | Dark colorscheme | Keep | Intentional dark half of exact theme pairing |
| P22 | `catppuccin` | Light colorscheme | Keep | Intentional light half of exact theme pairing |
| P23 | `nvim-dap` | Debug adapter client | Remove | Debugging is not done inside Neovim |
| P24 | `fidget.nvim` | LSP progress/notifications | Keep | Preferred display for verbose LSP progress |
| P25 | `nvim-lspconfig` | LSP server configurations | Keep | Supplies server definitions; current config already uses modern native API |
| P26 | `SchemaStore.nvim` | JSON/YAML schemas | Keep | Schema validation is used frequently |
| P27 | `nvim-lint` | External linting | Keep | Diagnostics where LSPs are missing/subpar; restrict to configured filetypes |
| P28 | `conform.nvim` | Formatting | Keep | Format-on-save is a core editor responsibility |
| P29 | `yaml.nvim` | YAML-specific inspection/yanking | Remove | Specialized commands are not used |
| P30 | `mini.nvim` | Consolidated editor utilities | Keep | Six current modules plus Trailspace, Pairs, Hipatterns, Input, and Notify; explicit sign-style Diff |
| P31 | `vim-caddyfile` | Caddyfile language support | Replace | Native filetype rule plus Tree-sitter Manager Caddy parser |
| P32 | `nvim-ufo` | Enhanced folding | Remove | No deliberate use; remove three-plugin per-file stack |
| P33 | `noice.nvim` | Command/message/LSP UI | Remove | Buggy in practice; native 0.12 UI2 experiment deferred until after audit |
| P34 | `vim-python-pep8-indent` | Python indentation | Remove | Old workaround; restore only for an observed current regression |
| P35 | `no-neck-pain.nvim` | Centered/focused editing layout | Remove | Never used |
| P36 | `markview.nvim` | In-buffer Markdown rendering | Keep | Core in-Neovim Markdown preview workflow |
| P37 | `fzf-lua` | Files, grep, buffers, symbols, diagnostics | Keep | Elemental, healthy, lazy-loaded single picker; also owns `vim.ui.select` |
| P38 | `vim-startuptime` | Startup profiling | Remove | No remembered use; Lazy and built-in startup profiling exist |
| P39 | `lazydev.nvim` | Neovim Lua development metadata | Keep | Scope to this config; bundled luv library and Lua-only Blink provider |
| P40 | `luvit-meta` | `vim.uv` type metadata | Replace | Use LuaLS bundled `${3rd}/luv/library` with `vim.uv` word trigger |
| P41 | `tiny-inline-diagnostic.nvim` | Inline diagnostic display | Keep | Polished no-shift inline presentation is preferred over native handlers |
| P42 | `oil.nvim` | Buffer-oriented file explorer | Remove | Keep Neo-tree; defer any `mini.files` trial until after cleanup |
| P43 | `mise.nvim` | Mise integration under Neovide | Remove | Neovide-only integration is not used |
| P44 | `dressing.nvim` | Enhanced `vim.ui` selectors/input | Replace | Archived; use `mini.input` plus FzfLua `ui_select = true` |
| P45 | `vim-kitty` | Kitty configuration support | Remove | Built-in Neovim 0.12 support is sufficient |
| P46 | `copilot.lua` | AI completion backend | Remove | Inline suggestions are not used; saves 328 MB |
| P47 | `codecompanion.nvim` | In-editor AI chat/actions/inline edits | Remove | Dormant; preferred candidate if in-editor AI is restored later |
| P48 | `claudecode.nvim` | Claude Code terminal/editor integration | Remove | TUI agents are always run outside Neovim |
| P49 | `grug-far.nvim` | Interactive project-wide replacement | Remove | One remembered use; no recurring workflow |
| P50 | `csvview.nvim` | CSV visualization/navigation | Keep | Distinct table/navigation workflow is used sometimes; command-lazy |
| P51 | `vim-illuminate` | Reference highlighting | Keep | LSP then Tree-sitter then regex providers give semantic references with fallback |

## Dependency-only ledger

| ID | Plugin | Parent/workflow | Status | Decision rationale |
| --- | --- | --- | --- | --- |
| D01 | `plenary.nvim` | Todo Comments, Neo-tree, Gitsigns, CodeCompanion | Keep | Required by retained Neo-tree; revisit if its parents change |
| D02 | `vim-repeat` | Leap repeat support | Remove | The user has never dot-repeated operations that use Leap as their motion |
| D03 | `nui.nvim` | Neo-tree, Noice, Lspsaga | Keep | Required by retained Neo-tree; revisit if its parents change |
| D04 | `nvim-window-picker` | Neo-tree split targeting | Keep | Retained and upgraded to v2 with Neo-tree in `1bf68ef` |
| D05 | `friendly-snippets` | Blink snippet source | Remove | Snippets have never been used; remove Blink snippet provider |
| D06 | `blink-copilot` | Copilot source for Blink | Remove | Follow removed Copilot backend |
| D07 | `nvim-dap-python` | Python DAP integration | Remove | Follow removed DAP workflow |
| D08 | `promise-async` | UFO folding | Remove | Follow removed UFO |
| D09 | `statuscol.nvim` | UFO/status column | Remove | Follow removed UFO |
| D10 | `nvim-notify` | Noice; also directly required by Conform toggle UI | Replace | Use `mini.notify`; update Conform toggle notifications |
| D11 | `snacks.nvim` | ClaudeCode; observed as an optional YAML picker | Remove | ClaudeCode removed; MiniInput/FzfLua replace Dressing without Snacks |

## Decision log

### 2026-07-10 - B01 user response

- Keep Neo-tree as the primary explorer. Remove Oil and record `mini.files` as
  a future alternative-file-workflow trial without adding another plugin now.
- Remove `vim-fish`, `vim-kitty`, `vim-python-pep8-indent`, `lspsaga.nvim`,
  `trouble.nvim`, and `nvim-lightbulb`.
- Keep Fidget because its larger display is useful for verbose LSP progress;
  later challenge Lualine's duplicate LSP-progress component.
- Gitsigns versus MiniDiff and the two Markdown renderers received their single
  counter-challenges; their final decisions are recorded below.

### 2026-07-10 - B01 final decisions and current Mini.nvim review

- Remove Gitsigns; MiniDiff's sign view covers the only used behavior.
- Keep Markview as a core in-Neovim Markdown preview. Remove
  `markdown-preview.nvim` because browser preview is not needed.
- Fetched the current upstream Mini.nvim `main` README and relevant module
  READMEs. Recorded all 46 current modules and opened B02 for plausible
  standalone-plugin replacements. Planned modules are explicitly excluded from
  replacement decisions.

### 2026-07-10 - B02 user response

- Replace `vim-better-whitespace`, `nvim-autopairs`, and `todo-comments.nvim`
  with `mini.trailspace`, `mini.pairs`, and `mini.hipatterns` respectively.
- Defer WhichKey and FzfLua to individual, interaction-focused assessments
  because both are elemental to the user's workflow.
- Keep Illuminate: its default LSP, Tree-sitter, then regex provider order
  already implements the requested semantic-reference behavior with word-match
  fallback.
- Lualine received its single counter-challenge. MiniStatusline covers the data,
  but a custom recreation of Lualine's polish may be worse for maintainability
  than keeping the standalone plugin.

### 2026-07-10 - B02 final statusline decision

- This was the provisional decision. I07 later made it final: keep Lualine
  because its current visual polish is preferred.
- Remove Lualine's `lsp_progress` component so retained Fidget has sole
  responsibility for verbose LSP progress.
- The required Lualine versus MiniStatusline revisit is complete; see I07.

### 2026-07-10 - B03 user response and upstream verification

- Remove Copilot and BlinkCopilot; inline suggestions are not used. Remove
  ClaudeCode and Snacks because TUI agents are always run outside Neovim.
- CodeCompanion is the only liked in-editor AI surface but is currently dormant;
  it received its single counter-challenge to remove now while recording it as
  the preferred future candidate.
- Remove Noice. The upstream repository is not archived, but its last code push
  observed through GitHub was 2025-11-03. Neovim 0.12 UI2 covers much of the
  configured behavior, but remains an explicitly experimental private API and
  is deferred until after the audit.
- Dressing was archived by its maintainer on 2025-02-12. Replace it with
  `mini.input` for `vim.ui.input` and FzfLua `ui_select = true` for
  `vim.ui.select`; do not retain Snacks solely for input.
- nvim-notify's visual presentation is liked, but MiniNotify covers its core
  notification/history role. This received the single counter-challenge.
- Defer frequently used Floaterm for a dedicated workflow assessment. Remove
  never-used No Neck Pain and Neoclip.

Sources reviewed:

- <https://tduyng.com/blog/neovim-drop-noice-ui2/>
- <https://github.com/stevearc/dressing.nvim/issues/190>
- <https://raw.githubusercontent.com/nvim-mini/mini.nvim/refs/heads/main/readmes/mini-input.md>
- <https://raw.githubusercontent.com/nvim-mini/mini.nvim/refs/heads/main/readmes/mini-notify.md>
- <https://raw.githubusercontent.com/folke/snacks.nvim/main/docs/input.md>

### 2026-07-10 - B03 final decisions

- Remove dormant CodeCompanion. It remains the preferred candidate if a future
  deliberate decision restores AI inside Neovim.
- Replace nvim-notify with `mini.notify`, configured without LSP progress so
  retained Fidget remains the single owner of that display.

### 2026-07-10 - B04 user response and maintenance check

- Remove DAP/DAP Python, yaml.nvim, tree-sitter-ghostty, mise.nvim, and
  vim-startuptime. Keep Conform and command-lazy CSVView.
- Defer nvim-lint for an individual assessment because live diagnostics are
  core but the need for the configured standalone linters is unclear.
- LazyDev and luvit-meta were both unarchived and had upstream pushes in March
  2026. Keep the 908 KB LazyDev integration, limit it to the Neovim config
  workspace, and replace the 1.7 MB luvit-meta repository with LuaLS's bundled
  `${3rd}/luv/library` triggered only by `vim.uv`, as current LazyDev upstream
  documentation recommends.
- Caddy receives its single counter-challenge: Tree-sitter Manager already
  registers `tree-sitter-caddy`, so replace the 204 KB legacy Vim plugin with a
  small built-in Caddyfile filetype rule and the existing parser manager.

Sources reviewed:

- <https://github.com/folke/lazydev.nvim>
- <https://github.com/Bilal2453/luvit-meta>
- <https://raw.githubusercontent.com/folke/lazydev.nvim/main/README.md>

### 2026-07-10 - B04 final Caddy decision

- Remove `vim-caddyfile`.
- Add native `vim.filetype.add()` detection for `Caddyfile` during
  implementation.
- Use Tree-sitter Manager's existing `tree-sitter-caddy` parser definition for
  syntax support.

### 2026-07-10 - B05 decisions

- Keep heavily used Fugitive and intentionally retained Tree-sitter Manager.
- Remove nvim-navigator because the tiling-WM workflow replaced cross-pane
  navigation and the plugin is currently ineffective with Ghostty.
- The initial removal of Leap was superseded by I06: keep Leap and move it from
  conflicting `s`/`S` mappings to `<CR>`/`g<CR>`. Remove its optional
  `vim-repeat` integration because the user has never used that workflow.
- Remove the UFO/promise-async/statuscol folding stack, Grug Far, and their
  mappings/configuration because none has a deliberate recurring workflow.

### 2026-07-10 - B06 user response and current LSP/diagnostic review

- Keep Lazy while actively tracking Neovim's plugin-management evolution.
- Keep Blink, but require a post-audit configuration refresh against current
  upstream. Remove Copilot and snippet providers, remove Friendly Snippets, and
  evaluate adding the LazyDev completion provider.
- Keep the exact Tokyo Night dark / Catppuccin light pairing.
- Keep nvim-lspconfig. Neovim core owns the LSP client and modern
  `vim.lsp.config`/`vim.lsp.enable` APIs; nvim-lspconfig remains an actively
  maintained data repository supplying server commands, filetypes, root markers,
  and defaults. The current configuration already uses the modern API.
- Keep SchemaStore because schema validation is frequently required.
- Native Neovim 0.12 diagnostics now support virtual text and virtual lines,
  current-line filtering, inline/eol placement, severity filtering, prefixes,
  and formatting. Tiny Inline still adds a more polished no-line-shift overlay,
  multiline handling, overflow behavior, counts, related information, and
  styling. It received its single counter-challenge.

Sources reviewed:

- <https://github.com/neovim/nvim-lspconfig>
- <https://neovim.io/doc/user/diagnostic/>
- <https://github.com/rachartier/tiny-inline-diagnostic.nvim>

### 2026-07-10 - B06 final diagnostic decision

- Keep Tiny Inline Diagnostic after its native Neovim 0.12 comparison. Visual
  polish and stable no-line-shift presentation justify the dedicated plugin.

### 2026-07-10 - I01 nvim-lint assessment

- `hadolint`, `markdownlint-cli2`, and `docker-langserver` are all installed.
- A synthetic Markdown buffer produced markdownlint diagnostics for first-line
  heading format and duplicate headings.
- A synthetic Dockerfile produced Hadolint diagnostics for an unpinned image and
  missing apt-list cleanup. These are useful policy diagnostics beyond generic
  syntax support.
- Keep nvim-lint. Replace eager loading with Markdown/Dockerfile filetype
  loading, retain write/InsertLeave triggers, and explicitly schedule an
  initial lint after setup so the old BufReadPost ordering problem cannot recur.

### 2026-07-10 - I02 Floaterm assessment

- Floaterm is not abandoned: its repository was unarchived and last pushed on
  2026-05-07. The workflow is frequently used.
- ToggleTerm was last pushed on 2025-03-09, so switching is not a maintenance
  modernization.
- Snacks Terminal is current and supports split/float terminals, toggle/focus,
  command/cwd/environment identity, and multiple instances. It would, however,
  reintroduce the 34 MB Snacks suite that was deliberately removed elsewhere.
- A native floating-terminal toggle is possible but transfers terminal buffer,
  window, process, cwd, and reuse behavior into custom configuration code.
- Recommendation: keep Floaterm. It is a focused, maintained plugin serving a
  frequent workflow; replacing it would optimize plugin count at the expense of
  maintenance or reverse an earlier dependency decision.
- Final decision: keep. The user likes and frequently uses the workflow.

Sources reviewed:

- <https://github.com/voldikss/vim-floaterm>
- <https://github.com/akinsho/toggleterm.nvim>
- <https://raw.githubusercontent.com/folke/snacks.nvim/main/docs/terminal.md>

### 2026-07-10 - I03 WhichKey assessment

- WhichKey is an elemental interaction system, not an incidental popup.
- The installed plugin is 2.2 MB and loads on `VeryLazy`; its sampled direct
  startup contribution was small.
- `:checkhealth which-key` passed with no mapping issues, overlaps, or
  duplicates.
- The existing 181-line spec both creates mappings and provides descriptions.
  MiniClue deliberately does not create mappings, so replacement requires a
  mapping rewrite plus explicit clue triggers.
- Current MiniClue documents buffer-local trigger ordering and macro/operator
  caveats that WhichKey avoids for this workflow.
- Final decision: keep WhichKey. During implementation, remove stale groups and
  mappings belonging to removed plugins and absent NvimTree/rnvimr commands.
- Future direction: move all mapping creation out of the WhichKey spec into one
  consistent normal/plugin mapping architecture. Once complete, reevaluate
  MiniClue as a discovery-only layer; its non-creation of mappings then becomes
  an architectural benefit rather than a migration cost.

Sources reviewed:

- <https://github.com/folke/which-key.nvim>
- <https://raw.githubusercontent.com/nvim-mini/mini.nvim/refs/heads/main/readmes/mini-clue.md>

### 2026-07-10 - I04 FzfLua assessment

- FzfLua is an elemental interaction system and remains actively maintained;
  its upstream was last pushed on 2026-07-08.
- The installed plugin is 6.9 MB and command/key lazy-loaded. Current `fzf`,
  `ripgrep`, and `fd` executables are installed.
- MiniPick/MiniExtra can reproduce nearly all configured picker categories, but
  replacement would change a heavily used UI/query workflow for little runtime
  benefit.
- FzfLua can replace Dressing's `vim.ui.select` role directly with
  `ui_select = true`, increasing its responsibility and removing a separate UI
  plugin.
- Final decision: keep FzfLua as the single picker system. Do not enable
  MiniPick in parallel. Remove mappings for deleted Neoclip/Trouble workflows
  and review duplicate file-picker mappings during implementation.

Sources reviewed:

- <https://github.com/ibhagwan/fzf-lua>
- <https://raw.githubusercontent.com/nvim-mini/mini.nvim/refs/heads/main/readmes/mini-pick.md>
- <https://raw.githubusercontent.com/nvim-mini/mini.nvim/refs/heads/main/readmes/mini-extra.md>

### 2026-07-10 - I05 Blink configuration refresh

- Installed and latest stable Blink are both v1.10.2; upstream was active on
  2026-07-10. Keep the plugin and Super-Tab/menu/documentation behavior.
- Remove dependencies `friendly-snippets` and `blink-copilot`.
- Remove default providers `snippets` and `copilot`, the Copilot provider/icon,
  and the CodeCompanion per-filetype provider.
- Keep only `lsp`, `path`, and `buffer` as general providers. Add `lazydev` only
  for Lua with `inherit_defaults = true`, using
  `lazydev.integrations.blink` and a positive score offset.
- Remove `appearance.use_nvim_cmp_as_default`; upstream still marks it for future
  removal, and both retained themes already provide Blink highlight groups.
- Remove `opts_extend = { "sources.default" }` because all surviving sources are
  configured in one place.
- Retain the current stable release selector, rounded menu/documentation UI,
  zero-delay documentation, Nerd Font mode, and LSP capabilities integration.
- Run `:checkhealth blink.cmp` after implementation. Expected default sources:
  LSP, path, buffer, and LazyDev only for Lua.

Sources reviewed:

- <https://github.com/Saghen/blink.cmp>
- <https://cmp.saghen.dev/configuration/general.html>
- <https://cmp.saghen.dev/configuration/sources.html>
- <https://raw.githubusercontent.com/folke/lazydev.nvim/main/README.md>

### 2026-07-10 - I06 movement conflict diagnosis

- Leap is current and correctly configured according to its present upstream
  README: `s` starts a current-window jump and `S` starts a cross-window jump.
- The configuration also enables MiniSurround. Its normal-mode mappings own the
  `s` prefix through `sa`, `sd`, `sr`, `sf`, `sF`, and `sh`, with next/previous
  variants. This makes bare `s` an unsafe Leap prefix: the first character of a
  Leap target can instead complete a MiniSurround mapping.
- MiniSurround is frequently used and should retain the coherent `s...`
  namespace. The old conclusion that Leap itself was broken was therefore
  incorrect; the active mappings conflict.
- MiniJump2d avoids this collision by defaulting to `<CR>` in normal, visual,
  and operator-pending modes. It explicitly restores ordinary Enter behavior
  in quickfix and command-line windows.
- Final decision: keep Leap and borrow that architecture by mapping `<CR>` to
  current-window Leap and `g<CR>` to cross-window Leap, with equivalent
  quickfix/command-window safeguards. The user never uses normal Enter for
  line movement, and the complete surround namespace remains intact.
- Remove `vim-repeat`: it only adds dot-repeat for delete/change operations
  whose motion was supplied by Leap, and the user has never used that workflow.
  MiniSurround's own dot-repeat does not depend on it.

Sources reviewed:

- Installed Leap README and `:help leap`
- Installed `mini.jump2d` documentation and implementation

### 2026-07-10 - I07 Lualine reassessment

- The actual Lualine configuration is small and conventional: mode, branch,
  diff, diagnostics, filename, file metadata, progress, and location. Its
  rendered separators and section-level theme colors provide the polish the
  user values.
- MiniStatusline's default covers nearly all the same information and both
  retained themes define its highlight groups. Its direct rendering is
  intentionally flatter and sparser, however. Recreating Lualine's appearance
  would transfer more UI code into the configuration than the present ten-line
  Lualine setup contains.
- Lualine occupies 2.6 MB and was current as of its installed 2026-04-28
  revision. Mini.nvim is already retained, so replacement would save a plugin
  entry and 2.6 MB, but not reduce the number of eagerly initialized systems by
  enough to justify losing a preferred interface.
- The configured `lsp_progress` component is stale; current Lualine calls its
  combined client/progress component `lsp_status`. Do not replace it because
  Fidget deliberately owns verbose LSP progress. Remove the dead component.
- The configured `nvim-tree` extension is stale because Neo-tree is the active
  explorer. Replace it with Lualine's existing `neo-tree` extension. Keep the
  Fugitive extension because Fugitive is heavily used.
- Final decision: keep Lualine, remove those two stale settings, and do not
  enable MiniStatusline in parallel. The user values its polished presentation
  more than the marginal 2.6 MB/plugin-count saving.

Sources reviewed:

- Installed Lualine configuration, documentation, and extensions
- Installed MiniStatusline documentation and implementation
- Runtime statusline rendering under the current TokyoNight theme

### 2026-07-10 - I08 file workflow prerequisite

- Neo-tree remains the primary explorer. Before I08 it was pinned to `v2.x` at a
  2023-07-16 commit whose own message says to switch to `v3.x` for continued
  updates. Current upstream installation instructions use `v3.x`.
- The configured `Neotree` commands already use the v3-compatible command. The
  documented v3 breaking changes mainly remove older `NeoTree...` commands,
  so the user-facing mappings should survive the upgrade.
- Modernization performed during the upgrade: remove the obsolete
  `neo_tree_remove_legacy_commands` flag, move old diagnostic sign definitions
  to `vim.diagnostic.config()`, and replace boolean
  `async_directory_scan = false` with its current `"never"` equivalent.
- Neo-tree and its window-picker integration were upgraded and health-checked
  in isolated commit `1bf68ef` (`chore(neo-tree): upgrade to v3`). Runtime tests
  confirmed reveal, single-window auto-selection, and auto-close behavior.
- MiniFiles was deliberately not enabled during this audit. Keep it as a future
  workflow experiment alongside Neo-tree, using a normal mapping with a
  description so WhichKey observes rather than owns the mapping. “Deferred” is
  not a rejection of MiniFiles.
- To keep the Neo-tree commit isolated, the already-decided Leap and Lualine
  implementation edits were reverted from tracked files. Their decisions in
  this document still stand and should be applied in the final cleanup pass.

Sources reviewed:

- Current Neo-tree README and v3 changelog
- Installed Neo-tree v2 configuration and commit
- Installed MiniFiles documentation and implementation

## Implementation notes discovered during audit

- Stale mappings and orphaned files are enumerated in the authoritative
  implementation plan above; do not rely on this shorter historical list.
- In the current pre-cleanup files, Lualine still declares an NvimTree extension
  and Leap still uses `s`/`S` because both implementation edits were reverted to
  isolate the Neo-tree commit.
- `README.md` and `CLAUDE.md` both describe old completion, AI, explorer, Git,
  navigation, DAP, and mapping workflows.

## Completed focused assessments and explicit deferrals

The broad plugin-by-plugin challenge and all required focused assessments are
complete. Deferred experiments are intentionally outside the slimming pass.

| Order | Assessment | Goal | Status |
| --- | --- | --- | --- |
| I01 | nvim-lint | Prove whether Hadolint and markdownlint provide unique live diagnostics; update loading strategy if retained. | Complete: keep and narrow loading |
| I02 | Floaterm | Compare the frequently used floating-terminal workflow with current native, Snacks, and other maintained approaches. | Complete: keep |
| I03 | WhichKey | Interaction-level comparison with MiniClue, including mapping coverage and macro/buffer-local caveats. | Complete: keep now; revisit after keymap normalization |
| I04 | FzfLua | Picker-by-picker comparison with MiniPick/MiniExtra using the actual configured mappings. | Complete: keep |
| I05 | Blink configuration | Refresh against current upstream after removing Copilot and snippets; add LazyDev provider if appropriate. | Assessment complete; implementation recorded above |
| I06 | Movement | Compare current Leap with MiniJump2d and other current options; restore a reliable fast-motion workflow if it still adds value. | Assessment complete; reapply `<CR>`/`g<CR>` during cleanup |
| I07 | Lualine revisit | Make the promised final Lualine versus MiniStatusline decision after the rest of the editor shape is known. | Assessment complete; keep and apply cleanup |
| I08 | File workflow experiment | Enable and trial MiniFiles alongside retained Neo-tree; decide whether Neo-tree remains primary after real use. | Deferred until after audit; Neo-tree v3 update complete |
| I09 | Neovim 0.12 UI2 | Experiment only after plugin removals; decide whether the private/experimental UI is stable enough to enable. | Deferred future experiment; not required for cleanup |
