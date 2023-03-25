{ lib, pkgs, user }:
let
in pkgs.stdenv.mkDerivation rec {
  pname = "comic-code-ligatures";
  version = "1.0.0";

  src = /home/${user}/.local/share/fonts/ComicCodeLigatures-Regular.otf;
  installPhase = ''
    mkdir -p $out/share/fonts/opentype
    cp -r $src $out/share/fonts/opentype
  '';
  phases = [ "installPhase" ];
  meta = with lib; {
    homepage = "";
    description = "The best font";
    maintainers = [ "calliope@chronojam.co.uk" ];
  };
}
