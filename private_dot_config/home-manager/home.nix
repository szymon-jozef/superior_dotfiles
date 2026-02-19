{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "szymon";
  home.homeDirectory = "/home/szymon";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    gh
    fastfetch
    neovim
    fd
    duf
    gdu
    tealdeer
    grim
    slurp
    wl-clipboard
    mako
    bc
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/szymon/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.sessionPath = [
    "/home/szymon/.lmstudio/bin"
  ];

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # no dum greeting
      set fish_greeting ""

      # yes, please setup git for me
      gh auth setup-git

      # add github ssh key
      # (dodałem przekierowanie błędów, żeby nie śmieciło na ekranie przy starcie)
      eval (ssh-agent -c) > /dev/null
      ssh-add ~/.ssh/github 2> /dev/null

      # add github gpg key
      set -gx GPG_TTY (tty)

      # vi mode
      fish_vi_key_bindings

      # Odpalenie fastfetcha na start
      clear
      fastfetch --config ~/.config/fastfetch/startup.jsonc
    '';
  };

  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
      color_theme = "catppuccin_mocha";
    };
  };

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "y";
    settings = {
        mgr = {
            ratio          = [ 1 4 3 ];
            sort_by        = "alphabetical";
            sort_sensitive = false;
            sort_reverse   = false;
            sort_dir_first = true;
            sort_translit  = false;
            linemode       = "none";
            show_hidden    = false;
            show_symlink   = true;
            scrolloff      = 5;
            mouse_events   = [ "click" "scroll" ];
            title_format   = "Yazi: {cwd}";
        };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
