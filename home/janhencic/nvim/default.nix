{ pkgs }:

let
  plugins = with pkgs.vimPlugins; [
    vim-nix
    which-key-nvim
    tender-vim
    nvim-lspconfig
    neogit
    plenary-nvim
    indent-blankline-nvim
    nvim-tree-lua
    vim-fugitive
    vim-suda
    kanagawa-nvim
    telescope-nvim
    nvim-comment
    nvim-treesitter.withAllGrammars
    undotree
    nvim-cmp
    cmp-buffer
    luasnip
    cmp-nvim-lsp
    lspkind-nvim
    cmp_luasnip
    fidget-nvim
    diffview-nvim
    lualine-nvim
    nvim-treesitter-context
    neoscroll-nvim
    render-markdown-nvim
    vim-table-mode
    nvim-ufo
    # Postman alternative
    # rest-nvim
    # Better tabs
    tabby-nvim
    nvim-web-devicons
    # Themes
    kanagawa-nvim
    tokyonight-nvim
    catppuccin-nvim
  ];

  myConfig = pkgs.vimUtils.buildVimPlugin {
    name = "jan_config";
    src = ./.;
    dependencies = plugins;
  };
in pkgs.neovim.override {
  configure = {
    customRC = ''
      lua require("init").run()
    '';
    packages.plugins = {
      start = plugins ++ [
        # The contents of ~/.config/nvim is packaged as a nvim plugin.
        myConfig
      ];
    };
  };
}
