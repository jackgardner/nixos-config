{ pkgs, ... }:
let

in
{
  fonts = {
    fontDir.enable = true;
    # enableGhostscriptFonts = true;

    fonts = with pkgs; [
      (callPackage ./comiccode.nix {})
      anonymousPro
      corefonts
      dejavu_fonts
      freefont_ttf
      google-fonts
      inconsolata
      liberation_ttf
      powerline-fonts
      source-code-pro
      terminus_font
      ttf_bitstream_vera
      ubuntu_font_family
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "Comic Code Ligatures" ];
        sansSerif = [ "Comic Code Ligatures" ];
        serif     = [ "Comic Code Ligatures" ];
      };
    };
  };
}
