{

  hm.programs.eza = # Replaces aliases already in its config
  {
    enable = true;
    icons = "auto";

    extraOptions =
    [
      "--group-directories-first"
      "--hyperlink" # Ctrl+Click a file to go directly to it
      "--sort=extension"

      "--smart-group" # Show "group" if it's not the default
      "--header"
      "--total-size" # Show the size of a folder's contents

      "--no-permissions"
      "--no-user"
    ];
  };

}