{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "osboxes";
  home.homeDirectory = "/home/osboxes";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'ripgrep' to your environment.
    pkgs.ripgrep

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Installs git and configures the user identity
  programs.git = {
    enable = true;
    userName = "NixCon NA";
    userEmail = "nix@nixcon.org";
  };
  # Create a file at ~/.config/git/ignore containing the text
  home.file.".config/git/ignore".text = ''
    result
    .DS_Store
  '';

  # Enable lazygit, if git is enabled
  programs.lazygit.enable = config.programs.git.enable;

  # Installs VSCodium with the listed extensions
  # To add extensions which are not part of nixpkgs refer to:
  # https://nixos.wiki/wiki/Visual_Studio_Code
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      zhuangtongfa.material-theme
      pkief.material-icon-theme
      jnoortheen.nix-ide
      rust-lang.rust-analyzer
    ];
  };
  # Create a file at ~/.config/VSCodium/User/settings.json with the
  # contents of the file located in your configs $CWD/codium-settings.json
  home.file.".config/VSCodium/User/settings.json".source = ./codium-settings.json;


  # Installs direnv, which loads or unloads your environment per directory.
  # nix-direnv enables an optimized implementation of "use flake" or "use nix",
  # which tells direnv to load or unload your shell.nix or your flakes
  # devShells.default
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
  };

  programs.bash.enable = true;

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

