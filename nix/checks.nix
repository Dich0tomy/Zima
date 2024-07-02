# FIXME: for some reason this doesn't work, I get no output in terminal lmao
{
  pkgs,
  self',
  ...
}: {
  checks.default = pkgs.writeShellApplication {
    name = "zima-checks";

    runtimeInputs = [
      pkgs.gum
      pkgs.typos
      self'.packages.default
    ];

    text = ''
      gum style --border="rounded" --padding="0 1" --bold --border-foreground="#ffc0cb" "Running typos!"
      typos .

      gum style --border="rounded" --padding="0 1" --bold --border-foreground="#ffc0cb" "Checking zima!"
      zima --headless +exit
    '';
  };
}
