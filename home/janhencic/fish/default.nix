{
  programs.fish = {
    enable = true;
  };
  xdg.configFile."fish/functions/nd.fish".source = ./nd.fish;
  xdg.configFile."fish/functions/fish_greeting.fish".text =
    "function fish_greeting; end\n";
}
