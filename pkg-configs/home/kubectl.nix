{ pkgs, ... }: {
  home.packages = with pkgs; [ kubectl k9s kubectx ];
  home.sessionVariables = {
    KUBECONFIG = "$XDG_CONFIG_HOME/kube/config";
  };
  programs.fish = {
    shellAbbrs.k = "kubectl";
    shellAbbrs.krestart = "kubectl rollout restart deployment ";
    shellAbbrs.kcx = "kubectx";
    shellAbbrs.kns = "kubens";
  };
}