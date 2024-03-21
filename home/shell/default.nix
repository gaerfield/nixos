{ pkgs, config, ... }:
let
  d = config.xdg.dataHome;
  c = config.xdg.configHome;
  cache = config.xdg.cacheHome;
in {
  imports = [
    ./fzf.nix
    ./zoxide.nix
  ];

  # https://nixos.wiki/wiki/Fish
  # switch to fish if parent is not fish already
  programs.bash = {
    enable = true;
    enableCompletion = true;

    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    plugins = with pkgs.fishPlugins; [
      # { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      { name = "fzf"; src = pkgs.fishPlugins.fzf.src; }
      { name = "tide"; src = pkgs.fishPlugins.tide.src; }
      { name = "sdkman-for-fish"; src = pkgs.fishPlugins."sdkman-for-fish".src; }
      { name = "sponge"; src = pkgs.fishPlugins.sponge.src; }
    ];
  };
  # tide configure --auto --style=Rainbow --prompt_colors='True color' --show_time=No --rainbow_prompt_separators=Angled --powerline_prompt_heads=Sharp --powerline_prompt_tails=Flat --powerline_prompt_style='Two lines, frame' --prompt_connection=Disconnected --powerline_right_prompt_frame=Yes --prompt_connection_andor_frame_color=Light --prompt_spacing=Compact --icons='Few icons' --transient=Yes
  
  # branchvincent/tide-show-on-cmd
  # oh-my-fish/plugin-extract
  # lgathy/google-cloud-sdk-fish-completion
  # gazorby/fish-abbreviation-tips
  
  xdg.configFile."fish/conf.d" = {
    source = ./conf.d;
    recursive = true;
  };

  # imports = [
  #   ./nushell
  #   ./common.nix
  #   ./starship.nix
  #   ./terminals.nix
  # ];

  # add environment variables
  # home.sessionVariables = {
  #   # clean up ~
  #   # LESSHISTFILE = cache + "/less/history";
  #   # LESSKEY = c + "/less/lesskey";
  #   # WINEPREFIX = d + "/wine";
  # 
  #   # set default applications
  #   EDITOR = "nvim";
  #   BROWSER = "firefox";
  #   TERMINAL = "alacritty";
  # 
  #   # enable scrolling in git diff
  #   DELTA_PAGER = "less -R";
  # 
  #   #MANPAGER = "sh -c 'col -bx | bat -l man -p'";
  # };
  # 
  # home.shellAliases = {
  #   # k = "kubectl";
  # };
}