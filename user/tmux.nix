{ pkgs, lib, ... }:
let
  theme = (pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/folke/tokyonight.nvim/affb21a81e6d7de073378eb86d02864c594104d9/extras/tmux/tokyonight_night.tmux";
    sha256 = "k6HGlN3X0kvyJpMMrXNuRuPK+sAzGRVwmKNKHIZHxm0=";
  });
in
{
  enable = true;
  extraConfig = ''
    source-file ${theme}

    set -g mouse on

    # ======

    set -g default-terminal "xterm-256color"
    set -ag terminal-overrides ",xterm-256color:RGB"
  '';

  plugins = with pkgs; [
    tmuxPlugins.cpu
    tmuxPlugins.prefix-highlight
    {
      plugin = tmuxPlugins.resurrect;
      extraConfig = "set -g @resurrect-strategy-nvim 'session'";
    }
    {
      plugin = tmuxPlugins.continuum;
      extraConfig = ''
        set -g @continuum-restore 'on'
        set -g @continuum-save-interval '60' # minutes
      '';
    }
  ];

}

