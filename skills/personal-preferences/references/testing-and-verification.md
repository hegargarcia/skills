# Testing and verification

## Choose meaningful tests

- Add the smallest test set that protects meaningful current behavior. Do not target coverage for its own sake or duplicate the same guarantee across several test layers.
- Describe and test the current contract, not the historical bug that revealed it.
- Do not add a test merely because an implementation was previously broken when no meaningful behavior or branch remains to protect.
- Avoid UI render, snapshot, and copy tests when typechecking and visual review cover static presentation. Test interaction behavior or fragile transformations at the smallest useful boundary.
- Do not preserve deprecated aliases, passthroughs, or temporary compatibility paths with dedicated tests. Test canonical behavior once.
- Do not write tests that merely restate a static object, configuration literal, constant, schema declaration, enum, field, or nullability rule.
- Do not build a full integration harness solely to prove a declaration that code generation, typechecking, or focused review already covers.
- Avoid one-off schema fixture tests unless they protect meaningful normalization or rejection behavior.
- Keep focused tests beside the implementation they cover.

## Run proportional checks

- During debugging, prefer targeted tests, diagnostics, or focused lint and typechecking over broad validation after every edit.
- Run the appropriate full validation before committing or pushing implementation work.
- Treat repository-wide warnings as non-blocking only after confirming the command succeeded and the warnings are unrelated.
- Recheck the final status and diff after formatters, code generation, hooks, or generated artifacts run.
- Include concrete proof, such as a screenshot, when validating UI or browser behavior.
