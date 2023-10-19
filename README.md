# nvim-config

My current .config/nvim setup.

Based on [this video](https://www.youtube.com/watch?v=w7i4amO_zaE) and [this accompanying repo](https://github.com/ThePrimeagen/init.lua) by ThePrimeagen.

## Prerequisits
1. Install [ripgrep](https://github.com/BurntSushi/ripgrep)

2. Setup Packer

- Install Packer by running this:
```
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

## Setup
The easiest way to set this up on a new computer is to clone the repo into a personal directory, then create a symlink to the repo in ``.
This can be done like this:
```
ln -s /Users/ahmad/Repos/personal/nvim-config ~/.config/nvim
```

Once the symlink is setup, do the following:
1. Navigate to `lua/amkia/packer.lua` within `~/.config/nvim`
2. Run `:so` then run `:PackerSync` to download everything
