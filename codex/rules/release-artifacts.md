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

Repository-specific guardrails for `mailark`:

- For macOS release bundle changes, do not replace `mailark-<version>-mac-universal.dmg` with `mac-universal/` unless explicitly requested.
- For Windows release bundle changes, do not replace `mailark-<version>-windows-x64.exe` with `win-unpacked/` unless explicitly requested.
- If the version were `0.0.10`, the concrete artifact description must look like this:
  - `mailark-0.0.10-mac-bundle.zip`
  - `mailark-0.0.10-mac-bundle/install-setup.sh`
  - `mailark-0.0.10-mac-bundle/mailark-0.0.10-mac-universal.dmg`
  - `mailark-0.0.10-win-bundle.zip`
  - `mailark-0.0.10-win-bundle/install-setup.bat`
  - `mailark-0.0.10-win-bundle/mailark-0.0.10-windows-x64.exe`
