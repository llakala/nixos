{ diff-so-fancy }:

diff-so-fancy.overrideAttrs (prevAttrs: {
  # patch from https://github.com/so-fancy/diff-so-fancy/issues/542
  patches = (prevAttrs.patches or []) ++ [ ./fix-leading-dash.patch ];
})
