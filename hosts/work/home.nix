{ config, pkgs, ... }:

{
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

  home = {
    username = "blaschke";
    homeDirectory = "/home/blaschke";
    stateVersion = "23.11";
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
