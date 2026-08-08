# 6 Testing

## 6.1 Choosing meaningful tests

### 6.1.1 The smallest set that protects behavior

Add the smallest test set that protects meaningful current behavior. Do not target coverage for its own sake or duplicate the same guarantee across several test layers.

### 6.1.2 Tests describe the contract, not the bug

Describe and test the current contract, not the historical bug that revealed it. Do not add a test for a past breakage when no meaningful behavior or branch remains to protect.

### 6.1.3 Static presentation is not tested

Avoid UI render, snapshot, and copy tests when typechecking and visual review cover static presentation. Test interaction behavior or fragile transformations at the smallest useful boundary.

### 6.1.4 Canonical behavior is tested once

Do not preserve deprecated aliases, passthroughs, or temporary compatibility paths with dedicated tests. Test canonical behavior once.

### 6.1.5 Tests do not restate declarations

Do not write tests or build harnesses that merely restate a declaration — a static object, configuration literal, constant, schema, enum, field, or nullability rule — that code generation, typechecking, or focused review already covers.

**Exception:** schema fixture tests that protect meaningful normalization or rejection behavior.

### 6.1.6 Tests live beside their implementation

Keep focused tests beside the implementation they cover.

## 6.2 Running proportional checks

### 6.2.1 Targeted checks while debugging

During debugging, prefer targeted tests, diagnostics, or focused lint and typechecking over broad validation after every edit.

### 6.2.2 Full validation before commit or push

Run the appropriate full validation before committing or pushing implementation work.

### 6.2.3 Warnings are non-blocking only when confirmed unrelated

Treat repository-wide warnings as non-blocking only after confirming the command succeeded and the warnings are unrelated.

### 6.2.4 Recheck after generators run

Recheck the final status and diff after formatters, code generation, hooks, or generated artifacts run.

### 6.2.5 UI behavior gets concrete proof

Include concrete proof, such as a screenshot, when validating UI or browser behavior.
