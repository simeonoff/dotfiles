# System configuration
{ pkgs, self, ... }:

{
  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;
}