# Workflow Rules

1. Before any commit or push, verify the target branch and the target PR match the user's intent.
2. Before any push, explicitly verify the push destination branch is correct.
3. Before merge, rebase, or cherry-pick work, fetch the latest remote state first and start from that latest remote branch to avoid unnecessary rebases.
