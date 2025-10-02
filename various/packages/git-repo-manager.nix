{
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  openssl,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "git-repo-manager";
  version = "0.8.2";
  src = fetchFromGitHub {
    owner = "hakoerber";
    repo = "git-repo-manager";
    rev = "v${finalAttrs.version}";
    hash = "sha256-QSqoq21BJQ0ZDktYoBYUp8fXqRqU1oOnXxbherPWw/g=";
  };
  cargoHash = "sha256-jvPsbaRa1WSgpTZvZySMlCqqO78dLd4+HL7qt5rL6ko=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  meta = {
    homepage = "https://github.com/hakoerber/git-repo-manager";
    description = "A git tool to manage worktrees";
  };
})
