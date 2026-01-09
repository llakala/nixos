# Copied in from my nixpkgs PR, adding the ability to pass a filepath and have
# an env var read from it at runtime
# See https://github.com/NixOS/nixpkgs/pull/478261
{
  targetPackages,
  lib,
  makeSetupHook,
  dieHook,
  writeShellScript,
  tests,
  cc ? targetPackages.stdenv.cc,
  sanitizers ? [ ],
}:

makeSetupHook {
  name = "make-binary-wrapper-hook";
  propagatedBuildInputs = [ dieHook ];

  substitutions = {
    cc = "${cc}/bin/${cc.targetPrefix}cc ${
      lib.escapeShellArgs (map (s: "-fsanitize=${s}") sanitizers)
      + lib.optionalString (
        cc.isClang && !cc.stdenv.hostPlatform.isDarwin
      ) "--ld-path=${cc.targetPrefix}ld"
    }";
  };

  passthru = {
    # Extract the function call used to create a binary wrapper from its embedded docstring
    extractCmd = writeShellScript "extract-binary-wrapper-cmd" ''
      ${targetPackages.gnuStdenv.cc.bintools.targetPrefix}strings -dw "$1" | sed -n '/^makeCWrapper/,/^$/ p'
    '';

    tests = tests.makeBinaryWrapper;
  };
} ./make-binary-wrapper.sh
