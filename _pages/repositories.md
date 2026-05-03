---
layout: page
permalink: /repositories/
title: code + data
description: The five most recently updated repositories on the EIG-Research GitHub organization, where my code and data products live.
nav: true
nav_order: 6
---

<div class="page-lead">
  <p>Most of the code and data I produce — anything I write or collaborate on through work — are published on the <a href="https://github.com/EIG-Research">EIG-Research</a> GitHub organization. Personal experiments, side projects, and the source for this site live on my <a href="https://github.com/bnglasner">personal GitHub page</a>.</p>
</div>

<section class="section-block">
  <h2 class="section-kicker">Open Research, by Default</h2>
  <p>I established the open-research standard EIG now uses for its empirical projects. Every analysis — a short memo or a multi-year study — should be readable from raw inputs to final figure, and that expectation now applies across the EIG-Research organization. Any researcher, journalist, or policymaker should be able to open one of these repositories and trace the chain from data to claim.</p>
  <p>I extend the same workflow to the teams I collaborate with, coaching colleagues on the Git, code review, and documentation practices that make a public repository worth publishing. I intend to carry that commitment forward on every project I touch and across every team I work with.</p>
</section>

<section class="section-block">
  <h2 class="section-kicker">Recently Updated on EIG-Research</h2>
  <div id="eig-research-repos" class="page-card-grid" data-state="loading">
    <article class="page-card">
      <p class="meta-line">Loading</p>
      <p>Fetching the five most recently updated repositories from the EIG-Research GitHub organization.</p>
    </article>
  </div>
  <p class="meta-line" style="margin-top: 1rem;">
    For the full catalog, browse <a href="https://github.com/EIG-Research">github.com/EIG-Research</a>.
  </p>
</section>

<section class="section-block">
  <h2 class="section-kicker">Personal Research Code</h2>
  <p>Side projects and earlier replication code, on the personal account at <a href="https://github.com/bnglasner">github.com/bnglasner</a>. The repositories below are research-bearing; experimental forks and infrastructure (the source of this site, course material, third-party plugin forks) are not listed here.</p>
  <div class="page-card-grid">
    <article class="page-card">
      <p class="meta-line">Python · 80-80 wage subsidy</p>
      <h3><a href="https://github.com/bnglasner/eig-wagesubsidy-policy-sim" target="_blank" rel="noopener noreferrer">eig-wagesubsidy-policy-sim</a></h3>
      <p>The microsimulation engine behind the 80-80 wage subsidy methods page: combines CPS microdata with PolicyEngine-US household income schedules to estimate eligibility, fiscal cost, and distributional effects.</p>
    </article>
    <article class="page-card">
      <p class="meta-line">HTML · Housing affordability</p>
      <h3><a href="https://github.com/bnglasner/hours-working-for-median-home" target="_blank" rel="noopener noreferrer">hours-working-for-median-home</a></h3>
      <p>Hours of work required to afford the median home, by metro area and over time.</p>
    </article>
    <article class="page-card">
      <p class="meta-line">HTML · Remote work</p>
      <h3><a href="https://github.com/bnglasner/telework-ASEC-analysis" target="_blank" rel="noopener noreferrer">telework-ASEC-analysis</a></h3>
      <p>Telework microdata work merging CPS-ASEC and contemporary remote-work supplements.</p>
    </article>
    <article class="page-card">
      <p class="meta-line">R · Replication</p>
      <h3><a href="https://github.com/bnglasner/MinimumWage-SelfEmp" target="_blank" rel="noopener noreferrer">MinimumWage-SelfEmp</a></h3>
      <p>Replication code for "The Minimum Wage, Self-Employment, and the Online Gig Economy," <i>Journal of Labor Economics</i>, 2023.</p>
    </article>
    <article class="page-card">
      <p class="meta-line">HTML · QCEW</p>
      <h3><a href="https://github.com/bnglasner/QCEW" target="_blank" rel="noopener noreferrer">QCEW</a></h3>
      <p>Summary tooling and visualizations built on the BLS Quarterly Census of Employment and Wages.</p>
    </article>
    <article class="page-card">
      <p class="meta-line">Stata · Replication</p>
      <h3><a href="https://github.com/bnglasner/CTC-MentalHealth" target="_blank" rel="noopener noreferrer">CTC-MentalHealth</a></h3>
      <p>Replication code for "No Evidence the Child Tax Credit Expansion Had an Effect on the Well-Being and Mental Health of Parents," <i>Health Affairs</i>, 2022.</p>
    </article>
  </div>
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
