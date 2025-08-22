{ baseVars, ... }:

{
  hm.programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = baseVars.fullName; # Full name associated with commits
        email = "78693624+quatquatt@users.noreply.github.com"; # github noreply email
      };

      ui.paginate = "never";
    };
  };
}
