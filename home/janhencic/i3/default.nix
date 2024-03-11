{ pkgs, ... }: {
  xsession = {
    enable = true;

    windowManager.i3 = {
      enable = true;
      config = null;
      extraConfig = (builtins.readFile ./config);
      package = pkgs.i3-gaps;
    };
  };

  home.packages = with pkgs; [ dmenu polybar i3status i3lock ];
}
