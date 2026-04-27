.PHONY: deploy codex claude

REPO_ROOT := $(CURDIR)
CODEX_SRC := $(REPO_ROOT)/codex
CLAUDE_SRC := $(REPO_ROOT)/claude
CODEX_DST := $(HOME)/.codex
CLAUDE_DST := $(HOME)/.claude

deploy: $(filter codex claude,$(MAKECMDGOALS))
	@if [ -z "$(filter codex claude,$(MAKECMDGOALS))" ]; then \
		echo "usage: make deploy codex | make deploy claude" >&2; \
		exit 1; \
	fi

codex:
	@set -eu; \
	test -f "$(CODEX_SRC)/AGENTS.md" || { echo "missing: $(CODEX_SRC)/AGENTS.md" >&2; exit 1; }; \
	mkdir -p "$(CODEX_DST)" "$(CODEX_DST)/rules" "$(CODEX_DST)/skills"; \
	echo "== diff: $(CODEX_SRC)/AGENTS.md -> $(CODEX_DST)/AGENTS.md =="; \
	diff -u "$(CODEX_DST)/AGENTS.md" "$(CODEX_SRC)/AGENTS.md" || true; \
	if [ -d "$(CODEX_SRC)/rules" ]; then \
		echo "== diff: $(CODEX_SRC)/rules -> $(CODEX_DST)/rules =="; \
		diff -ruN "$(CODEX_DST)/rules" "$(CODEX_SRC)/rules" || true; \
	fi; \
	if [ -d "$(CODEX_SRC)/skills" ]; then \
		echo "== diff: $(CODEX_SRC)/skills -> $(CODEX_DST)/skills =="; \
		diff -ruN "$(CODEX_DST)/skills" "$(CODEX_SRC)/skills" || true; \
	fi; \
	printf "Proceed with deploy to $(CODEX_DST)? [yes/no] "; \
	read answer; \
	case "$$answer" in yes) ;; *) echo "Canceled."; exit 1 ;; esac; \
	cp -f "$(CODEX_SRC)/AGENTS.md" "$(CODEX_DST)/AGENTS.md"; \
	if [ -d "$(CODEX_SRC)/rules" ]; then cp -R "$(CODEX_SRC)/rules/." "$(CODEX_DST)/rules/"; fi; \
	if [ -d "$(CODEX_SRC)/skills" ]; then cp -R "$(CODEX_SRC)/skills/." "$(CODEX_DST)/skills/"; fi; \
	echo "Deployed Codex config to $(CODEX_DST)"

claude:
	@set -eu; \
	test -f "$(CLAUDE_SRC)/CLAUDE.md" || { echo "missing: $(CLAUDE_SRC)/CLAUDE.md" >&2; exit 1; }; \
	mkdir -p "$(CLAUDE_DST)" "$(CLAUDE_DST)/commands" "$(CLAUDE_DST)/hooks" "$(CLAUDE_DST)/rules" "$(CLAUDE_DST)/skills"; \
	echo "== diff: $(CLAUDE_SRC)/CLAUDE.md -> $(CLAUDE_DST)/CLAUDE.md =="; \
	diff -u "$(CLAUDE_DST)/CLAUDE.md" "$(CLAUDE_SRC)/CLAUDE.md" || true; \
	echo "== diff: $(CLAUDE_SRC)/settings.json -> $(CLAUDE_DST)/settings.json =="; \
	diff -u "$(CLAUDE_DST)/settings.json" "$(CLAUDE_SRC)/settings.json" || true; \
	echo "== diff: $(CLAUDE_SRC)/statusline-command.sh -> $(CLAUDE_DST)/statusline-command.sh =="; \
	diff -u "$(CLAUDE_DST)/statusline-command.sh" "$(CLAUDE_SRC)/statusline-command.sh" || true; \
	if [ -d "$(CLAUDE_SRC)/commands" ]; then \
		echo "== diff: $(CLAUDE_SRC)/commands -> $(CLAUDE_DST)/commands =="; \
		diff -ruN "$(CLAUDE_DST)/commands" "$(CLAUDE_SRC)/commands" || true; \
	fi; \
	if [ -d "$(CLAUDE_SRC)/hooks" ]; then \
		echo "== diff: $(CLAUDE_SRC)/hooks -> $(CLAUDE_DST)/hooks =="; \
		diff -ruN "$(CLAUDE_DST)/hooks" "$(CLAUDE_SRC)/hooks" || true; \
	fi; \
	if [ -d "$(CLAUDE_SRC)/rules" ]; then \
		echo "== diff: $(CLAUDE_SRC)/rules -> $(CLAUDE_DST)/rules =="; \
		diff -ruN "$(CLAUDE_DST)/rules" "$(CLAUDE_SRC)/rules" || true; \
	fi; \
	if [ -d "$(CLAUDE_SRC)/skills" ]; then \
		echo "== diff: $(CLAUDE_SRC)/skills -> $(CLAUDE_DST)/skills =="; \
		diff -ruN "$(CLAUDE_DST)/skills" "$(CLAUDE_SRC)/skills" || true; \
	fi; \
	printf "Proceed with deploy to $(CLAUDE_DST)? [yes/no] "; \
	read answer; \
	case "$$answer" in yes) ;; *) echo "Canceled."; exit 1 ;; esac; \
	cp -f "$(CLAUDE_SRC)/CLAUDE.md" "$(CLAUDE_SRC)/settings.json" "$(CLAUDE_SRC)/statusline-command.sh" "$(CLAUDE_DST)/"; \
	if [ -d "$(CLAUDE_SRC)/commands" ]; then cp -R "$(CLAUDE_SRC)/commands/." "$(CLAUDE_DST)/commands/"; fi; \
	if [ -d "$(CLAUDE_SRC)/hooks" ]; then cp -R "$(CLAUDE_SRC)/hooks/." "$(CLAUDE_DST)/hooks/"; fi; \
	if [ -d "$(CLAUDE_SRC)/rules" ]; then cp -R "$(CLAUDE_SRC)/rules/." "$(CLAUDE_DST)/rules/"; fi; \
	if [ -d "$(CLAUDE_SRC)/skills" ]; then cp -R "$(CLAUDE_SRC)/skills/." "$(CLAUDE_DST)/skills/"; fi; \
	echo "Deployed Claude config to $(CLAUDE_DST)"
