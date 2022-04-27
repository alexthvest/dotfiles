{ config, pkgs, pkgs-unstable, ... }:

{
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      onedark-nvim

      nvim-web-devicons
      nvim-tree-lua

      feline-nvim
      telescope-nvim
      gitgutter
      vim-nix
      comment-nvim

      # indent-blankline-nvim
      indentLine

      ## LSP
      nvim-lspconfig
      nvim-treesitter

      ## Autocompletion
      nvim-cmp
      cmp-nvim-lsp
    ];

    extraConfig = ''
      lua << EOF
        require("lspconfig").sumneko_lua.setup {}
        require("lspconfig").rnix.setup {}
        require("lspconfig").tsserver.setup {}
        require("lspconfig").rust_analyzer.setup {}
      EOF

      lua require('init')
    '';
  };

  home.packages = with pkgs; [
    ## Lua
    sumneko-lua-language-server

    ## Nix
    rnix-lsp

    ## Rust
    rust-analyzer

    ## Typescript
    nodePackages.typescript
    nodePackages.typescript-language-server
  ] ++ (with pkgs-unstable; [
    # dotnet
    omnisharp-roslyn
  ]);
}
