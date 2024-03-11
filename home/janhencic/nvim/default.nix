{ pkgs }:

let
  myConfig = pkgs.vimUtils.buildVimPlugin {
    name = "jan_config";
    src = ./.;
  };
in pkgs.neovim.override {
  configure = {
    customRC = ''
      lua require("init").run()
    '';
    packages.plugins = with pkgs.vimPlugins; {
      start = [
        vim-nix
        which-key-nvim
        tender-vim
        nvim-lspconfig
        neogit
        plenary-nvim
        indent-blankline-nvim
        nvim-tree-lua
        vim-fugitive
        suda-vim
        kanagawa-nvim
        telescope-nvim
        nvim-comment
        nvim-treesitter.withAllGrammars
        playground
        undotree
        nvim-cmp
        cmp-buffer
        luasnip
        cmp-nvim-lsp
        lspkind-nvim
        cmp_luasnip
        tokyonight-nvim
        fidget-nvim
        diffview-nvim
        lualine-nvim
        nvim-treesitter-context

        # The contents of ~/.config/nvim is packaged as a nvim plugin.
        myConfig
      ];
    };
  };
}
