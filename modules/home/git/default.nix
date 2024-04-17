{ pkgs, ... }: 
{
  programs.git = {
    enable = true;
    
    userName = "tggpx";
    userEmail = "wu_zhihan@qq.com";
    
    extraConfig = { 
      init.defaultBranch = "main";
      credential.helper = "store";
    };
  };

  
  home.packages = [ pkgs.gh pkgs.git-lfs ];

}