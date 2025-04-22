{ pkgs, lib, ... }:

let
  iosevka = pkgs.iosevka.override {
    set = "Term";
    privateBuildPlan = ''
      [buildPlans.IosevkaTerm]
      family = "Iosevka Nix"
      spacing = "term"
      serifs = "sans"
      noCvSs = true
      exportGlyphNames = true

        [buildPlans.IosevkaTerm.variants]
        inherits = "ss14"

        [buildPlans.IosevkaTerm.ligations]
        inherits = "clike"
    '';
  };
in
{
  fonts.packages = [ iosevka ];
}
