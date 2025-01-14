# TODO:
# Check out modus vivendi it's the only one to style nix attributes differently
# Ensure variables and types are different colors
# Separate builtin types and strings
# Take inspiration from the replit theme (you know where to find it)
{
  inherits = "snazzy";

  "function".fg = "green";
  "function.builtin".fg = "green";
  "function.call".fg = "green";
  "function.macro".fg = "purple";
  "function.method".fg = "green";

  "variable.other".fg = "foreground";

  palette =
  {
    green = "#50fa7b";
    cyan = "#8be9fd";
    # Yellow is already the same as dracula

    opal = "#8be9fd"; # Same as yellow, applied to all things currently opal
  };
}
