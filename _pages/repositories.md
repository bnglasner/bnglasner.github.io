---
layout: page
permalink: /repositories/
title: Code
description: The five most recently updated repositories on the EIG-Research GitHub organization, where my code and data products live.
nav: true
nav_order: 4
redesign_2026: true
---

<p class="research-intro">
  Most of the code and data I produce, anything I write or collaborate on through work, is published on the
  <a href="https://github.com/EIG-Research" target="_blank" rel="noopener noreferrer">EIG-Research</a>
  GitHub organization. Personal experiments, side projects, and the source for this site live on my
  <a href="https://github.com/bnglasner" target="_blank" rel="noopener noreferrer">personal GitHub page</a>.
</p>

<h2>Open Research, by Default</h2>
<p class="measure">
  I established the open-research standard EIG now uses for its empirical projects. Every analysis, a short memo or
  a multi-year study, should be readable from raw inputs to final figure, and that expectation now applies across
  the EIG-Research organization. Any researcher, journalist, or policymaker should be able to open one of these
  repositories and trace the chain from data to claim.
</p>
<p class="measure">
  I extend the same workflow to the teams I collaborate with, coaching colleagues on the Git, code review, and
  documentation practices that make a public repository worth publishing. I intend to carry that commitment forward
  on every project I touch and across every team I work with.
</p>

{% include axis-rule.liquid %}

<h2>Recently Updated on EIG-Research</h2>
<div id="eig-research-repos" class="work-card-grid" data-state="loading">
  <div class="work-card work-card--policy">
    <span class="work-card__eyebrow">Loading</span>
    <p class="work-card__finding">Fetching the five most recently updated repositories from the EIG-Research GitHub organization.</p>
  </div>
</div>
<p class="work-card__meta" style="margin-top: 1rem;">
  For the full catalog, browse
  <a href="https://github.com/EIG-Research" target="_blank" rel="noopener noreferrer">github.com/EIG-Research</a>.
</p>

{% include axis-rule.liquid %}

<h2>Personal Research Code</h2>
<p class="research-intro">
  Side projects and earlier replication code, on the personal account at
  <a href="https://github.com/bnglasner" target="_blank" rel="noopener noreferrer">github.com/bnglasner</a>. The
  repositories below are research-bearing; experimental forks and infrastructure (the source of this site, course
  material, third-party plugin forks) are not listed here.
</p>
<div class="work-card-grid">
  <div class="work-card work-card--academic">
    <span class="work-card__eyebrow">Python</span>
    <h3 class="work-card__title">
      <a href="https://github.com/bnglasner/eig-wagesubsidy-policy-sim" target="_blank" rel="noopener noreferrer">
        eig-wagesubsidy-policy-sim
      </a>
    </h3>
    <p class="work-card__finding">
      The microsimulation engine behind the 80-80 wage subsidy methods page: combines CPS microdata with
      PolicyEngine-US household income schedules to estimate eligibility, fiscal cost, and distributional effects.
    </p>
  </div>
  <div class="work-card work-card--academic">
    <span class="work-card__eyebrow">HTML</span>
    <h3 class="work-card__title">
      <a href="https://github.com/bnglasner/hours-working-for-median-home" target="_blank" rel="noopener noreferrer">
        hours-working-for-median-home
      </a>
    </h3>
    <p class="work-card__finding">Hours of work required to afford the median home, by metro area and over time.</p>
  </div>
  <div class="work-card work-card--academic">
    <span class="work-card__eyebrow">HTML</span>
    <h3 class="work-card__title">
      <a href="https://github.com/bnglasner/telework-ASEC-analysis" target="_blank" rel="noopener noreferrer">telework-ASEC-analysis</a>
    </h3>
    <p class="work-card__finding">Telework microdata work merging CPS-ASEC and contemporary remote-work supplements.</p>
  </div>
  <div class="work-card work-card--academic">
    <span class="work-card__eyebrow">R</span>
    <h3 class="work-card__title">
      <a href="https://github.com/bnglasner/MinimumWage-SelfEmp" target="_blank" rel="noopener noreferrer">MinimumWage-SelfEmp</a>
    </h3>
    <p class="work-card__finding">
      Replication code for "The Minimum Wage, Self-Employment, and the Online Gig Economy," Journal of Labor
      Economics, 2023.
    </p>
  </div>
  <div class="work-card work-card--academic">
    <span class="work-card__eyebrow">HTML</span>
    <h3 class="work-card__title">
      <a href="https://github.com/bnglasner/QCEW" target="_blank" rel="noopener noreferrer">QCEW</a>
    </h3>
    <p class="work-card__finding">Summary tooling and visualizations built on the BLS Quarterly Census of Employment and Wages.</p>
  </div>
  <div class="work-card work-card--academic">
    <span class="work-card__eyebrow">Stata</span>
    <h3 class="work-card__title">
      <a href="https://github.com/bnglasner/CTC-MentalHealth" target="_blank" rel="noopener noreferrer">CTC-MentalHealth</a>
    </h3>
    <p class="work-card__finding">
      Replication code for "No Evidence the Child Tax Credit Expansion Had an Effect on the Well-Being and Mental
      Health of Parents," Health Affairs, 2022.
    </p>
  </div>
</div>

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
        '<div class="work-card work-card--policy">' +
        '<span class="work-card__eyebrow">Could not load</span>' +
        '<p class="work-card__finding">' +
        escapeHtml(message) +
        ' Browse the organization directly at ' +
        '<a href="https://github.com/EIG-Research" target="_blank" rel="noopener noreferrer">github.com/EIG-Research</a>.</p>' +
        '</div>';
    }

    function renderRepos(repos) {
      if (!Array.isArray(repos) || repos.length === 0) {
        renderError('The GitHub API returned no repositories.');
        return;
      }
      var cards = repos
        .map(function (repo) {
          var eyebrow = escapeHtml(repo.language) || 'Repository';
          var pushed = formatDate(repo.pushed_at);
          var meta = pushed ? 'Updated ' + escapeHtml(pushed) : '';
          var description = repo.description ? escapeHtml(repo.description) : 'No description provided.';
          return (
            '<div class="work-card work-card--policy">' +
            '<span class="work-card__eyebrow">' +
            eyebrow +
            '</span>' +
            '<h3 class="work-card__title"><a href="' +
            escapeHtml(repo.html_url) +
            '" target="_blank" rel="noopener noreferrer">' +
            escapeHtml(repo.full_name) +
            '</a></h3>' +
            '<p class="work-card__finding">' +
            description +
            '</p>' +
            (meta ? '<div class="work-card__meta"><span>' + meta + '</span></div>' : '') +
            '</div>'
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
