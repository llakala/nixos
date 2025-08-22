{ lib, pkgs, ... }:

let
  difftastic = lib.getExe pkgs.difftastic;
in {
  hm.programs.git.iniContent = {
    difftool.prompt = false;
    diff.tool = "difftastic";

    pager.difftool = true;

    difftool.difftastic.cmd = # bash
    ''
      ${difftastic} --display inline "$MERGED" "$LOCAL" "abcdef1" "100644" "$REMOTE" "abcdef2" "100644"
    '';
  };
}
