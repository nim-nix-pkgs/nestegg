{
  description = ''A nimterop wrapper for the nestegg portable webm video demuxer'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."nestegg-master".dir   = "master";
  inputs."nestegg-master".owner = "nim-nix-pkgs";
  inputs."nestegg-master".ref   = "master";
  inputs."nestegg-master".repo  = "nestegg";
  inputs."nestegg-master".type  = "github";
  inputs."nestegg-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nestegg-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}