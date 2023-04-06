# Installation

## [Packer](https://github.com/wbthomason/packer.nvim)

```
-- Packer
use({
  "pjvds/dynumbers.nvim",
  config = function()
    require("dynumbers").setup()
  end,
})
```

## [Lazy](https://github.com/folke/lazy.nvim)

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
