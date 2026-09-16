{ diff-so-fancy, fetchFromGitHub }:

# pin a nightly build while waiting on
# https://github.com/so-fancy/diff-so-fancy/issues/542 to be included in a
# release
assert diff-so-fancy.version == "1.4.12";
diff-so-fancy.overrideAttrs {
  src = fetchFromGitHub {
    owner = "so-fancy";
    repo = "diff-so-fancy";
    rev = "8c03d4a5023c47087a35a34f489c242098b0a65c";
    hash = "sha256-KjZb46HJfhrIe5Go9BTPogeK1EiN1wTDc2T8r/I46zs=";
  };
}
