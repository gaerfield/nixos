{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

  imports = [
    ./../../pkg-configs/home/base
    ./../../pkg-configs/home/teams-for-linux.nix
    ./../../pkg-configs/home/rambox.nix
    ./../../pkg-configs/home/virtualization.nix
    ./../../pkg-configs/home/google-cloud-sdk.nix
    ./../../pkg-configs/home/kubectl.nix
    ./../../pkg-configs/home/java.nix
    ./../../pkg-configs/home/idea.nix
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
  
  home = {
    username = "blaschke";
    homeDirectory = "/home/blaschke";
  };

  programs.git = {
    # add git work account
    # https://seansantry.com/development/2022/12/14/split-git-nix/
    includes = [
      {
        contents = {
          user = {
            name = "blatobi";
        	  email = "tobias.blaschke@payfree.io";
        	};
        
        	core = {
        	  sshCommand = "ssh -i ~/.ssh/blatobi";
          };
        };
        # trailing slash is very important for directories :-(
        condition = "gitdir:~/IdeaProjects/payfree/";
      }
    ];
  };
}