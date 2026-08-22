<p align="center">
    <h2 align="center"> HighVim
    </h2>
</p>

<p align="center" style="text-decoration: none; border: none; margin-bottom: 10px;">
    <img
        alt="Neovim Version Capability"
        src="https://img.shields.io/badge/Nvim-v0.11.2-A6D895?style=for-the-badge&colorA=363A4F&logo=neovim&logoColor=D9E0EE">
    <img
        alt="Code Size"
        src="https://img.shields.io/github/languages/code-size/SeaHI-Robot/highvim?colorA=363A4F&colorB=DDB6F2&logo=gitlfs&logoColor=D9E0EE&style=for-the-badge">
</p>

<br>

![highvim-cover](./assets/highvim-cover.png)

## :cherry_blossom: Introduction

- This repo hosts my [Neovim](https://neovim.io/) configuration for Linux. 
- `init.lua` is the config entry point.
- Plugins are managed by [lazy.nvim](https://github.com/folke/lazy.nvim).
- Well configured colorthemes including: [catppuccin](https://github.com/catppuccin/nvim) and [nordfox](https://github.com/EdenEast/nightfox.nvim)
- HighVim also has a [vim configuration](https://github.com/SeaHI-Robot/highvim/tree/vim), but deprecated.

## :page_with_curl: Structure
```
lua
├── core
│   ├── autocmds.lua
│   ├── keymaps.lua
│   ├── lazy.lua
│   └── options.lua
└── plugins
    ├── config_1.lua
    ├── config_2.lua
    ├── config_3.lua
    └── ...

```
