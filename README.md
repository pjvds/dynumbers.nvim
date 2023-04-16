# Installation

## [Packer](https://github.com/wbthomason/packer.nvim)

``` lua
-- Packer
use({
  "pjvds/dynumbers.nvim",
  config = function()
    require("dynumbers").setup()
  end,
})
```

## [Lazy](https://github.com/folke/lazy.nvim)

``` lua
-- Lazy
{
  "pjvds/dynumbers.nvim",
  event = "VeryLazy"
  config = function()
    require("dynumbers").setup()
  end,
}
```

# Ignore buffer

By default NvimTree and startify buffers are ignored by dynumbers. You can configure the ignore by setting the ignore list when calling setup:

``` lua
require("dynumbers").setup({
  ignore: { "NvimTree", "startify", "..."}
})
```
