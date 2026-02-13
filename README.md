# snipe-marks.nvim

Yet another marks navigate nvim plugin depends on [leath-dub/snipe.nvim](https://github.com/leath-dub/snipe.nvim)

## Setup and usage

```lua
{
  "nicholasxjy/snipe-marks.nvim",
  dependencies = { "leath-dub/snipe.nvim" },
  opts = {
    -- optional: defaults shown
    title = { local_marks = "Local Marks", all_marks = "All Marks" },
    include_non_alnum = true,
    notify_no_marks = true,
    position = "cursor",
    open_command = "edit",
    highlights = {
      mark = "WarningMsg",
      line = "MoreMsg",
      col = "Search",
      text = "Normal",
    },
  },
  keys = {
    { "<leader>ml", function() require("snipe-marks").open_marks_menu() end, desc = "Find local marks" },
    { "<leader>ma", function() require("snipe-marks").open_marks_menu("all") end, desc = "Find all marks" },
  },
}
```

Public API:
- `require("snipe-marks").setup(opts)`
- `require("snipe-marks").open_marks_menu()`
- `require("snipe-marks").open_marks_menu("all")`

## Demo

![demo.gif](./assets/demo.gif)

## Architecture

- `lua/snipe-marks/source.lua`: collect + normalize local/global marks.
- `lua/snipe-marks/format.lua`: format mark lines and ordering.
- `lua/snipe-marks/actions.lua`: open target file/buffer and jump cursor.
- `lua/snipe-marks/menu.lua`: render snipe menu, keymaps, highlights.
- `lua/snipe-marks/config.lua`: defaults and `setup(opts)` merging.

## Why not telescope?

Local marks is a good and quick way for me to navigate between code blocks when editing the current buffer.

The telescope UI is a bit distracted for me, snipe menu is so clean and simple.
