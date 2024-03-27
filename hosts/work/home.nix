{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

  imports = [
    ./../../home
    ./../../home/teams-for-linux.nix
    ./../../home/rambox.nix
    ./../../home/virtualization.nix
    ./../../home/google-cloud-sdk.nix
    ./../../home/kubectl.nix
    ./../../home/java.nix
    ./../../home/idea.nix
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