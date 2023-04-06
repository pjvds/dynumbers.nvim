# Installation

## Packer

```
-- Packer
use({
  "pjvds/dynumbers.nvim",
  config = function()
    require("dynumbers").setup()
  end,
})
```

## Lazy

```
-- Lazy
{
  "pjvds/dynumbers.nvim",
  event = "VeryLazy"
  config = function()
    require("dynumbers").setup()
  end,
}
```
