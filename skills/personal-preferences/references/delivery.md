# 8 Delivery

## 8.1 Diff hygiene

### 8.1.1 Hegar's changes are preserved

Preserve Hegar's changes and unrelated dirty work.

### 8.1.2 No unrelated churn

Avoid unrelated refactors, formatting churn, generated-file churn, compatibility scaffolding, and speculative branches.

### 8.1.3 Existing structure is preserved

Preserve existing helpers, structure, and line locations when they still serve the requested behavior; moving unchanged code manufactures review noise.

### 8.1.4 Comments are deleted only when invalidated

Delete an existing comment only when the requested change invalidates it. Do not sweep unrelated stale comments from a touched file.

### 8.1.5 Surrounding code is inspected before editing

Inspect surrounding code immediately before editing; do not trust stale line numbers or prior context.

## 8.2 Commits, pushes, and review flow

### 8.2.1 Only the intended diff is packaged

Package only the intended diff when committing or pushing.

### 8.2.2 Never force-push

Never force-push; fix forward with a new commit.

### 8.2.3 Pushes use the current branch

When Hegar explicitly asks to commit and push, use the current branch. Do not invent a branch or pull request unless he asks for one or repository instructions require it.

### 8.2.4 Review-response edits stay local

After a pull request is open, keep review-response edits local until Hegar explicitly asks to push them. Commit locally when useful, but do not push merely because the branch already exists remotely.
