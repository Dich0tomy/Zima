{pkgs, ...}: {
  formatter = pkgs.writeShellApplication {
    name = "zima-formatter";

    runtimeInputs = [
      pkgs.stylua
      pkgs.alejandra
      pkgs.gum
    ];

    text = ''
      gum style --border="rounded" --padding="0 1" --bold --border-foreground="#ffc0cb" "Running alejandra!"
      alejandra .

      gum style --border="rounded" --padding="0 1" --bold --border-foreground="#ffc0cb" "Running stylua!"
      stylua .
    '';
  };
}
