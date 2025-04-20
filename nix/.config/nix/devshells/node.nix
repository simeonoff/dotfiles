# Node.js development shells
{ pkgs }:

{
  # Node.js 18.x environment
  nodejs18 = pkgs.mkShell {
    buildInputs = with pkgs; [ nodejs_18 ];
  };
  
  # Node.js 20.x environment
  nodejs20 = pkgs.mkShell {
    buildInputs = with pkgs; [ nodejs_20 ];
  };

  # Node.js 22.x environment
  nodejs22 = pkgs.mkShell {
    buildInputs = with pkgs; [ nodejs_22 ];
  };
}
