{ types, ... }:
{
  name = "self";

  options = {
    myLib = {
      type = types.attrs;
    };
  };
}
