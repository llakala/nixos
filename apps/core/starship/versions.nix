{
  # Don't show the language and version of the current project
  # Why would someone want this?
  # If someone knows of a better way to disable all this, let me know!
  # I just took from the existing template for no version numbers,
  # did `builtins.toTOML`, and some vim find/replace to create this.
  hm.programs.starship.settings = {
    buf.format = "";
    bun.format = "";
    c.format = "";
    cmake.format = "";
    cobol.format = "";
    crystal.format = "";
    daml.format = "";
    dart.format = "";
    deno.format = "";
    dotnet.format = "";
    elixir.format = "";
    elm.format = "";
    erlang.format = "";
    fennel.format = "";
    gleam.format = "";
    golang.format = "";
    gradle.format = "";
    haxe.format = "";
    helm.format = "";
    java.format = "";
    julia.format = "";
    kotlin.format = "";
    lua.format = "";
    meson.format = "";
    nim.format = "";
    nodejs.format = "";
    ocaml.format = "";
    opa.format = "";
    perl.format = "";
    php.format = "";
    pulumi.format = "";
    purescript.format = "";
    python.format = "";
    quarto.format = "";
    raku.format = "";
    red.format = "";
    rlang.format = "";
    ruby.format = "";
    rust.format = "";
    solidity.format = "";
    swift.format = "";
    typst.format = "";
    vagrant.format = "";
    vlang.format = "";
    zig.format = "";
  };
}
