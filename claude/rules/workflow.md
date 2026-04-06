# Workflow Rules

1. Before any commit or push, verify the target branch and the target PR match the user's intent.
2. Before any push, explicitly verify the push destination branch is correct.
3. Before merge, rebase, or cherry-pick work, fetch the latest remote state first and start from that latest remote branch to avoid unnecessary rebases.
4. Treat `main`, `master`, and other default branches as protected branches.
5. Never force-push to a protected branch, even when the user asks to amend, squash, or rewrite history, unless the user explicitly says `force push` or `--force-with-lease`.
6. If a requested action would require rewriting history on a protected branch, stop and ask one short confirmation question that explicitly says it requires a force push.
7. Prefer creating a new commit over amending or rewriting history on a protected branch.
8. If the user asks to amend after a commit has already been pushed to a protected branch, do not rewrite that branch by default. Offer to create a follow-up commit or do the amend on a separate branch instead.
9. Do not describe failures with vague words like `雑でした`. Name the failure precisely as one of: `理解不足`, `検証不足`, `設計ミス`, or `運用違反`.
10. When a mistake is pointed out, explain the concrete failure and the concrete preventive action. Do not use softened language that blurs responsibility.
11. For changes that affect core execution paths, external processes, media generation, deployment, or git history, do not claim completion from unit tests alone. State exactly which of `unit test`, `lint`, `format`, `integration test`, and `real execution check` were performed.
12. If the same problem area has already required more than one fix attempt, stop shipping speculative fixes. Add or run a tighter reproduction or integration test before the next code change or PR.
13. Do not default to denial when the user points out damage, stray files, or side effects caused during the session. If the agent could plausibly have caused it, say so plainly and take responsibility first.
14. When evidence is incomplete, do not use uncertainty as a shield. State the known facts, acknowledge plausible responsibility, and offer the concrete cleanup or verification step.
15. Never run `terraform plan` or `terraform apply` unless the user explicitly instructs that exact Terraform command in that turn. Default to code inspection and command suggestion only, even when the next Terraform step seems obvious.
16. Treat `terraform plan` and `terraform apply` as at least as sensitive as `git push`. If the agent runs either command without explicit approval, acknowledge it as an `運用違反`, state exactly what was run, and stop making further Terraform execution changes until the user directs the next step.
