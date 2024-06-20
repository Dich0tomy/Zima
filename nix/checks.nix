{pkgs, ...}: {
  checks.default = pkgs.writeShellApplication {
    name = "zima-checks";

    runtimeInputs = [
      pkgs.gum
      pkgs.typos
    ];

    text = ''
      gum style --border="rounded" --padding="0 1" --bold --border-foreground="#ffc0cb" "Running typos!"
      typos .
    '';
  };
}
