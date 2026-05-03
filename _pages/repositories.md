---
layout: page
permalink: /repositories/
title: code + data
description: The five most recently updated repositories on the EIG-Research GitHub organization, where my code and data products live.
nav: true
nav_order: 5
---

<div class="page-lead">
  <p>Most of the code and data I produce — anything I write or collaborate on through work — is published on the <a href="https://github.com/EIG-Research">EIG-Research</a> GitHub organization. Personal experiments, side projects, and the source for this site live on my <a href="https://github.com/bnglasner">personal GitHub page</a>.</p>
</div>

<section class="section-block">
  <h2 class="section-kicker">Recently Updated on EIG-Research</h2>
  <div id="eig-research-repos" class="page-card-grid" data-state="loading">
    <article class="page-card">
      <p class="meta-line">Loading</p>
      <p>Fetching the five most recently pushed repositories from the EIG-Research GitHub organization.</p>
    </article>
  </div>
  <p class="meta-line" style="margin-top: 1rem;">
    For the full catalog, browse <a href="https://github.com/EIG-Research">github.com/EIG-Research</a>.
  </p>
</section>

<script>
  (function () {
    var container = document.getElementById('eig-research-repos');
    if (!container) {
      return;
    }

    var endpoint = 'https://api.github.com/orgs/EIG-Research/repos?sort=pushed&direction=desc&per_page=5';

    function escapeHtml(value) {
      if (value == null) {
        return '';
      }
      return String(value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&#39;');
    }

    function formatDate(iso) {
      var parsed = new Date(iso);
      if (isNaN(parsed.getTime())) {
        return '';
      }
      return parsed.toLocaleDateString(undefined, {
        year: 'numeric',
        month: 'short',
        day: 'numeric',
      });
    }

    function renderError(message) {
      container.setAttribute('data-state', 'error');
      container.innerHTML =
        '<article class="page-card">' +
        '<p class="meta-line">Could not load</p>' +
        '<p>' +
        escapeHtml(message) +
        ' Browse the organization directly at ' +
        '<a href="https://github.com/EIG-Research">github.com/EIG-Research</a>.</p>' +
        '</article>';
    }

    function renderRepos(repos) {
      if (!Array.isArray(repos) || repos.length === 0) {
        renderError('The GitHub API returned no repositories.');
        return;
      }
      var cards = repos
        .map(function (repo) {
          var meta = [];
          if (repo.language) {
            meta.push(escapeHtml(repo.language));
          }
          var pushed = formatDate(repo.pushed_at);
          if (pushed) {
            meta.push('updated ' + escapeHtml(pushed));
          }
          var description = repo.description
            ? escapeHtml(repo.description)
            : '<em>No description provided.</em>';
          return (
            '<article class="page-card">' +
            '<p class="meta-line">' +
            (meta.join(' &middot; ') || 'Repository') +
            '</p>' +
            '<h3><a href="' +
            escapeHtml(repo.html_url) +
            '">' +
            escapeHtml(repo.full_name) +
            '</a></h3>' +
            '<p>' +
            description +
            '</p>' +
            '</article>'
          );
        })
        .join('');
      container.setAttribute('data-state', 'ready');
      container.innerHTML = cards;
    }

    fetch(endpoint, { headers: { Accept: 'application/vnd.github+json' } })
      .then(function (response) {
        if (!response.ok) {
          throw new Error('GitHub API returned status ' + response.status + '.');
        }
        return response.json();
      })
      .then(renderRepos)
      .catch(function (error) {
        renderError(error && error.message ? error.message : 'Unknown error.');
      });
  })();
</script>
