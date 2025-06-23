# shell.nix
let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs {
    config = { };
    overlays = [ ];
  };

  pythonPkgs = pkgs.python311.withPackages (
    ps: with ps; [
      flask
      flask-sqlalchemy
      psycopg2
      python-dotenv
      sqlalchemy
    ]
  );

in

pkgs.mkShell {

  buildInputs = with pkgs; [
    pythonPkgs
    postgresql
  ];

  shellHook = ''
    echo "Flask TODO App Development Environment"

    # Run database initialization script
    source db_init.sh

    trap 'echo "Cleaning up..." && source cleanup.sh' EXIT
  '';
}
