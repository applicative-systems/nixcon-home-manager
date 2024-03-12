{ config, pkgs, ... }:

{
  home.username = "osboxes";
  home.homeDirectory = "/home/osboxes";

  home.stateVersion = "23.11";

  home.packages = [
    pkgs.ripgrep
  ];

  programs.git = {
    enable = true;
    userName = "NixCon NA";
    userEmail = "nix@nixcon.org";
  };
  home.file.".config/git/ignore".text = ''
    result
    .DS_Store
  '';

  programs.lazygit.enable = config.programs.git.enable;

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

  home.file.".config/VSCodium/User/settings.json".source = ./codium-settings.json;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
  };

  programs.bash.enable = true;

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
}

