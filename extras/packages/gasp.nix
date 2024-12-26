{ pkgs, splitpatch, ... }:

let
  pkgsInputs = with pkgs;
  [
    git
    fzf
  ];

  selfInputs = # Other custom packages
  [
    splitpatch
  ];

in pkgs.writeShellApplication
{
  name = "gasp"; # `Git Add Specific Patch`

  runtimeInputs = pkgsInputs ++ selfInputs;

  bashOptions =
  [
    "nounset" # -u
    "errexit" # -e
    "pipefail"
    "errtrace" # -E
  ];

  text =
  ''
    DIRECTORY="/etc/nixos" # Git directory we're operating on
    TMPDIR=$(mktemp -d)
    ORIGINAL="original.patch" # Unsplit patch with all the hunks together
    BAD_PATTERN="diff --git" # `splitpatch` has a bug that adds bad output to the end of each hunk

    cd "$TMPDIR"

    git -C "$DIRECTORY" diff > "$ORIGINAL" # Uses `git diff` for unstaged changes
    splitpatch -H "$ORIGINAL" # Split up patch into individual hunks

    rm "$ORIGINAL" # So we can iterate over each hunk individually

    for file in *.patch; do

      # Check last two lines for bad pattern
      if tail -n 2 "$file" | rg -q "$BAD_PATTERN" "$file"; then
        head -n -2 "$file" > tmpfile && mv tmpfile "$file"
      fi

    done

    selected_patch=$(fzf --preview-window="top" --preview="cat {} | diff-so-fancy")

    cd "$DIRECTORY"
    if [ -n "$selected_patch" ]; then
      # Read the patch content and apply it directly via stdin
      git apply --cached < "$TMPDIR/$selected_patch"
    fi

    rm -rf "$TMPDIR"
  '';
}
