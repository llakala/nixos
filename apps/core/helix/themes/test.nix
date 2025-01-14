# MINIMAL THEME FOR TESTING WHAT COLORS AFFECT IN NIX
{
  # REQUIRED
  "ui.selection" =
  {
    fg = "white";
    bg = "gray";
  };

  operator.fg = "coral"; # `&&`
  "punctuation.delimiter".fg = "coral"; # `;`, `=`, etc

  string.fg = "yellow"; # Affects all strings, even in the case of "foo".bar
  "string.special".fg = "coral";

  comment.fg = "comment";

  "variable.builtin".fg = "green";
  "variable.parameter".fg = "comment";




  palette = {
    background = "#282a36";
    background_dark = "#21222c";
    comment = "#a39e9b";
    foreground = "#eff0eb";
    primary_highlight = "#800049";
    secondary_highlight = "#4d4f66";

    # main colors
    blue = "#57c7ff";
    cyan = "#9aedfe";
    green = "#5af78e";
    magenta = "#ff6ac1";
    purple = "#bd93f9";
    red = "#ff5c57";
    yellow = "#f3f99d";

    # aux colors
    carnation = "#f99fc6";
    coral = "#f97c7c";
    lilac = "#c9c5fb";
    olive = "#b6d37c";
    opal = "#b1d7c7";
    sand = "#ffab6f";

  };

}
