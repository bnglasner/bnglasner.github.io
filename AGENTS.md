# Agent Guidelines for al-folio

A simple, clean, and responsive Jekyll theme for academics.

## Quick Links by Role

- **Are you a coding agent?** → Read [`.github/copilot-instructions.md`](.github/copilot-instructions.md) first (tech stack, build, CI/CD, common pitfalls & solutions)
- **Customizing the site?** → See [`.github/agents/customize.agent.md`](.github/agents/customize.agent.md)
- **Writing documentation?** → See [`.github/agents/docs.agent.md`](.github/agents/docs.agent.md)
- **Need setup/deployment help?** → [INSTALL.md](INSTALL.md)
- **Troubleshooting & FAQ?** → [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
- **Customization & theming?** → [CUSTOMIZE.md](CUSTOMIZE.md)
- **Quick 5-min start?** → [QUICKSTART.md](QUICKSTART.md)

## Essential Commands

### Local Development

> **This fork (bnglasner.github.io):** the primary path is the local Ruby toolchain, which is also what CI uses (`ruby/setup-ruby`, Ruby 3.3.5). Docker is optional and not installed on Ben's machine. `.claude/rules/build-and-verify.md` is authoritative for this repo.

```bash
# First time: install gems and the pinned Prettier
bundle install && npm ci

# Dev server (UTF-8 locale avoids jekyll-terser "on US-ASCII" exceptions)
LC_ALL=en_US.UTF-8 bundle exec jekyll serve --port 4000
# Site runs at http://localhost:4000

# One-command headless check: schemas, build, internal links
bash bin/verify_site.sh
```

Docker alternative (upstream al-folio default; only if Docker is installed):

```bash
docker compose pull && docker compose up   # http://localhost:8080
docker compose up --build                  # after changing dependencies or Dockerfile
docker compose down                        # stop and free port 8080
```

### Pre-Commit Checklist

Before every commit, you **must** run these steps:

1.  **Format Code:**
    ```bash
    # (First time only; installs the versions pinned in package-lock.json)
    npm ci
    # Format all files
    npx prettier . --write
    ```
2.  **Build Locally & Verify:**

    ```bash
    # Headless: schemas, build, internal links
    bash bin/verify_site.sh

    # Visual: serve and visit http://localhost:4000
    LC_ALL=en_US.UTF-8 bundle exec jekyll serve --port 4000
    # Check navigation, pages, images, and dark mode.
    ```

## Critical Configuration

When modifying `_config.yml`, these **must be updated together**:

- **Personal site:** `url: https://username.github.io` + `baseurl:` (empty)
- **Project site:** `url: https://username.github.io` + `baseurl: /repo-name/`
- **YAML errors:** Quote strings with special characters: `title: "My: Cool Site"`

## Development Workflow

- **Git & Commits:** For commit message format and Git practices, see [.github/GIT_WORKFLOW.md](.github/GIT_WORKFLOW.md).
- **Code-Specific Instructions:** Consult the relevant instruction file for your code type.

| File Type                                     | Instruction File                                                                                |
| --------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| Markdown content (`_posts/`, `_pages/`, etc.) | [markdown-content.instructions.md](.github/instructions/markdown-content.instructions.md)       |
| YAML config (`_config.yml`, `_data/`)         | [yaml-configuration.instructions.md](.github/instructions/yaml-configuration.instructions.md)   |
| BibTeX (`_bibliography/`)                     | [bibtex-bibliography.instructions.md](.github/instructions/bibtex-bibliography.instructions.md) |
| Liquid templates (`_includes/`, `_layouts/`)  | [liquid-templates.instructions.md](.github/instructions/liquid-templates.instructions.md)       |
| JavaScript (`_scripts/`)                      | [javascript-scripts.instructions.md](.github/instructions/javascript-scripts.instructions.md)   |

## Common Issues

For troubleshooting, see:

- [Common Pitfalls & Workarounds](.github/copilot-instructions.md#common-pitfalls--workarounds) in copilot-instructions.md
- [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for detailed solutions
- [GitHub Issues](https://github.com/alshedivat/al-folio/issues) to search for your specific problem.
