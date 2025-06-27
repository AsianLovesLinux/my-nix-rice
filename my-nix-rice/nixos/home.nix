{ pkgs, ... }: {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        colors = [ 2 10 2 ]; # Dark green
      };
      display = {
        titleColor = [ 2 10 2 ]; # Dark green text
      };
    };
  };
}
