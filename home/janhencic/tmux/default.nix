{ pkgs }: {
  programs.tmux = {
    enable = true;
    extraConfig = (builtins.readFile ./.tmux.conf);
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = resurrect;
        extraConfig = ''
          resurrect_dir="$HOME/.tmux/resurrect"
          set -g @resurrect-dir $resurrect_dir
          set -g @resurrect-hook-post-save-all "sed -i 's/--cmd lua.*--cmd set packpath/--cmd \"lua/g; s/--cmd set rtp.*\$/\"/' $resurrect_dir/last"
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-processes '"~nvim"'
        '';
      }
      {
        plugin = battery;
      }
    ];
  };
}
