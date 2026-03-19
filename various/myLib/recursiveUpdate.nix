let
  inherit (builtins)
    elemAt
    head
    intersectAttrs
    isAttrs
    isFunction
    length
    zipAttrsWith
    ;

  recursiveUpdate =
    inModule: lhs: rhs:
    zipAttrsWith
      (
        name: values:
        let
          lhs = elemAt values 1;
          rhs' = head values;
          # If we're in the modules field, allow rhs to be a function that reads
          # the old version of itself
          rhs = if inModule == false && isFunction rhs' then rhs' lhs else rhs';
        in
        if length values == 1 || !(isAttrs lhs && isAttrs rhs) then
          # Either there's no conflict and only head is valid (aka rhs),
          # or we can't recurse anymore and should pick rhs. Laziness
          # means even if lhs is invalid, we'll never evaluate it
          rhs
        else if intersectAttrs lhs rhs == {} then
          lhs // rhs
        else
          recursiveUpdate (
            if inModule == null || inModule && name != "modules" then
              # We're either:
              #
              # 1. about to enter another module field like `options` or `inputs`
              #
              # 2. have already done that, and should continue to be null
              #
              # This null looping protects us from false positives for a key
              # named `modules` in another field, like
              # `root.modules.foo.meta.modules = a: a + 1;`
              null
            else
              # we should toggle the state of inModule. We're either:
              #
              # 1. currently in some module foo (foo may be root), and are about
              # to enter `foo.modules`. Set inModule to false, to allow calling
              # modules with their old versions.
              #
              # 2. Currently in `foo.modules`, and about to enter
              # `foo.modules.bar`. Set inModule to true, and don't allow rhs to
              # be called with lhs rhs on the next iteration (but possibly in
              # two iterations)
              !inModule
          ) lhs rhs
      ) [ rhs lhs ];
in
# Start with inModule as false, as recursiveUpdate should be called on `modules
# =` of root.
recursiveUpdate false
