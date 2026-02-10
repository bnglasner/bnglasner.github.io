# bnglasner.github.io

Personal academic website for **Ben Glasner**, Senior Economist at the Economic Innovation Group. Research on labor markets, place-based policy, and social-policy design.

Built on the [al-folio](https://github.com/alshedivat/al-folio) Jekyll theme.

## Local development

Prerequisites: Ruby 3.3.5, Bundler, ImageMagick, Python 3.13+, Node.js (for PurgeCSS).

```bash
bundle install
pip install nbconvert
bundle exec jekyll serve
```

The site will be available at `http://localhost:4000`.

## Deployment

Pushes to `main` trigger the GitHub Actions workflow in `.github/workflows/deploy.yml`. The pipeline:

1. Installs Ruby 3.3.5, Python 3.13, and ImageMagick
2. Builds the site with `jekyll build` (production mode)
3. Purges unused CSS with PurgeCSS
4. Deploys to GitHub Pages via the [JamesIves deploy action](https://github.com/JamesIves/github-pages-deploy-action)

## Project structure

| Path | Description |
|---|---|
| `_bibliography/papers.bib` | BibTeX entries — drives the publications page |
| `_data/coauthors.yml` | Coauthor metadata (names, URLs) for publication links |
| `_data/cv.yml` | CV content |
| `_layouts/bib.liquid` | Template for rendering individual bibliography entries |
| `_news/` | News/announcement items shown on the home page |
| `_pages/` | Site pages (about, publications, projects, etc.) |
| `_projects/` | Project cards displayed on the projects page |
| `_sass/` | SCSS stylesheets |
| `assets/img/` | Images (auto-converted to responsive WebP during build) |
| `assets/pdf/` | PDF files linked from publications |

## License

The theme is available as open source under the terms of the [MIT License](LICENSE).
