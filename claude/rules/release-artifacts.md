# Release Artifact Rules

These rules apply whenever a task changes release packaging, GitHub Release attachments, installer bundling, archive contents, or CI steps that publish deliverables.

1. Do not infer what "binary", "bundle", "artifact", or "package" means.
2. Before editing any workflow, release script, or PR body, first state the final deliverables in concrete form.
3. The concrete form must include:
   - the exact release attachment filename(s)
   - the exact archive filename(s)
   - the exact file path(s) that will exist inside each archive
4. Treat `.dmg`, `.exe`, `.AppImage`, unpacked directories, and helper scripts as different deliverable types. Never substitute one for another without explicit confirmation.
5. If the request is ambiguous, ask one short clarification question before making edits.
6. Do not create, edit, or update a PR until the concrete deliverable list matches the implementation.
7. Before push or PR creation, restate the final deliverables again in concrete form.
