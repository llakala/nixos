let
  inherit (builtins) elemAt head intersectAttrs isAttrs length unsafeGetAttrPos zipAttrsWith;
  recursiveUpdate =
    withinModule: lhs: rhs:
    zipAttrsWith (
      name: values:
      let
        lhs = elemAt values 1;
        rhs = head values;
      in
      if length values == 1 || !(isAttrs lhs && isAttrs rhs) then
        # Either there's no conflict and only head is valid (aka rhs),
        # or we can't recurse anymore and should pick rhs. Laziness
        # means even if lhs is invalid, we'll never evaluate it
        rhs
      else if isAttrs withinModule then
        # The previous call was in $module_name.options, and the current
        # option has a conflict. The merging of this option will break
        # `unsafeGetAttrPos` for docs generators, so include the
        # locations of lhs and rhs manually.
        (if intersectAttrs lhs rhs == {} then lhs // rhs else recursiveUpdate null lhs rhs)
        // {
          loc = {
            lhs = unsafeGetAttrPos name withinModule.lhs;
            rhs = unsafeGetAttrPos name withinModule.rhs;
          };
        }
      else if intersectAttrs lhs rhs == {} then
        lhs // rhs
      else
        recursiveUpdate (
          # We only only want to add loc info to withinModule if the path to the
          # current location looks like /$name(.modules.$name)*.options/ (where
          # $name can be anything). For performance reasons, we'd prefer to not
          # pass around a big list of names, so we cram this info into a single
          # boolean. true means we're right under $name, false means we're under
          # .modules, and null means the schema doesnt match
          if withinModule == true then
            if name == "options" then
              # Any options that have values injected in the next recursive call
              # will need to manually include loc info. Pass them our current
              # lhs and rhs (representing the left and right `options`) so they
              # can get the location of their option within it
              { inherit lhs rhs; }
            else if name == "modules" then
              false
            else
              null
          else if withinModule == false then
            true
          else
            null
        ) lhs rhs
    ) [ rhs lhs ];
in
recursiveUpdate false
