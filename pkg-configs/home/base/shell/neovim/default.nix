{ pkgs, config, lib, ... }: {
  systemd.user.tmpfiles.rules = [
    "d ${config.xdg.cacheHome}/nvim/undo"
    "d ${config.xdg.cacheHome}/nvim/swap"
    "d ${config.xdg.cacheHome}/nvim/backup"
    "d ${config.xdg.cacheHome}/nvim/view"
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = false;

    plugins = with pkgs.vimPlugins; [
      neovim-sensible
      nvim-treesitter.withAllGrammars
      vim-airline
      vim-airline-themes
      nvim-fzf
      nvim-fzf-commands
      zoxide-vim
      vim-fugitive
      vim-gitgutter
      nvim-surround
      nord-vim
      nvim-web-devicons
      nvim-tree-lua
    ];

    extraLuaConfig = ''
      -- -- specific nvim-tree config
      -- disable netrw at the very start of your init.lua
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      -- empty setup using defaults
      require("nvim-tree").setup()
      -- blaa
      vim.keymap.set('n', '<leader>b', ':NvimTreeToggle<CR>')
      vim.keymap.set('n', '<leader>bf', ':NvimTreeFocus<CR>')
      vim.keymap.set('n', '<leader>bs', ':NvimTreeFindFile<CR>')
      vim.keymap.set('n', '<leader>bc', ':NvimTreeCollaps<CR>')
    '';

    extraConfig = lib.fileContents ./init.vim;
  };
}