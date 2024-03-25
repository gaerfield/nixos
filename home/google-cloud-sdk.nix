{ pkgs, config, ... }:
let
  gsdk = pkgs.google-cloud-sdk.withExtraComponents( with pkgs.google-cloud-sdk.components; [
    gke-gcloud-auth-plugin
  ]);
in
{
  home.packages = [ pkgs.google-cloud-sdk ];

  programs.fish = {
    plugins = [
      # Manually pull fish completions for gcloud
      # https://github.com/lgathy/google-cloud-sdk-fish-completion
      {
        name = "google-cloud-sdk-fish-completion";
        src = pkgs.fetchFromGitHub {
            owner = "lgathy";
            repo = "google-cloud-sdk-fish-completion";
            rev = "bc24b0bf7da2addca377d89feece4487ca0b1e9c";
            sha256 = "sha256-BIbzdxAj3mrf340l4hNkXwA13rIIFnC6BxM6YuJ7/w8=";
        };
      }
    ];
  
  };
}
