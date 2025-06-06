{ config, ... }:

let
  # Function to perform some Yazi action and write current directory to file
  # Referenced from: https://github.com/Axlefublr/dotfiles/blob/38525a7f900709efe5d0ea3005b670203626794d/yazi/plugins/storecwd.yazi/init.lua#L5
  mkCwd = action:
  /* lua */
  ''
    --- @sync entry
    return {
      entry = function()
        local cwd = tostring(cx.active.current.cwd)
        local file = io.open('/tmp/yazi-cwd-suspend', 'w')
        if file then
          file:write(cwd)
          file:close()
        end
        ya.manager_emit('${action}', {})
      end,
    }
  '';
in
{

  hm.xdg.configFile =
  {
    "yazi/plugins/suspendcwd.yazi/main.lua".text = mkCwd "suspend";
    "yazi/plugins/opencwd.yazi/main.lua".text = mkCwd "open";
  };

  hm.programs.yazi.keymap.mgr.prepend_keymap =
  [
    {
      desc = "Suspend Yazi, writing the current directory to a file";
      on = "<C-z>";
      run = "plugin suspendcwd";
    }

    {
      desc = "Open file and write the current directory to a file";
      on = "o";
      run = "plugin opencwd";
    }
  ];

  # When pressing Ctrl+y, go to the last directory we were in with Yazi
  # Yazi recommends an alternative where you run `$shell` and it goes into fish, but then
  # I don't get Ctrl+z to resume the process, I have to do Ctrl+d. So we have the user do
  # it manually when needed. Perfect? Far from it. But I don't know if there's a way to
  #  suspend Yazi and have fish CATCH that suspension. I tried watching for SIGTSTP with
  # a fish function, but had no luck. I think it's because Yazi is the one that gets suspended.
  # Maybe there's some way? If you see this and think you have an idea, let me know via an issue
  # or email.
  hm.programs.fish.interactiveShellInit = assert config.features.shell == "fish";
  /* fish */
  ''
    bind -M insert \cy 'cd (cat /tmp/yazi-cwd-suspend); commandline -f repaint'
  '';
}
