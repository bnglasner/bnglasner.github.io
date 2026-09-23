---
layout: page
permalink: /repositories/
title: Code
description: "Code and data behind my research: the EIG-Research GitHub organization and research repositories on my personal account."
nav: false
redesign_2026: true
---

<p class="research-intro">
  Most of the code and data I produce — anything I write or collaborate on through work — are published on the
  <a href="https://github.com/EIG-Research" target="_blank" rel="noopener noreferrer">EIG-Research</a>
  GitHub organization. Personal experiments, side projects, and the source for this site live on my
  <a href="https://github.com/bnglasner" target="_blank" rel="noopener noreferrer">personal GitHub account</a>. When a
  paper or report has public replication code, its entry on the <a href="{{ '/publications/' | relative_url }}">Research</a>
  page links to the repository.
</p>

<h2>Open Research, by Default</h2>
<p class="measure">
  I established the open-research standard EIG now uses for its empirical projects. Every analysis — whether a short memo or
  a multi-year study — should be readable from raw inputs to final figure, and that expectation applies across
  the EIG-Research organization. Any researcher, journalist, or policymaker should be able to open one of these
  repositories and trace the chain from data to claim.
</p>
<p class="measure">
  I extend the same workflow to the teams I collaborate with, coaching colleagues on the Git, code review, and
  documentation practices that make a public repository worth publishing.
</p>

{% include axis-rule.liquid %}

<h2>Recently Updated on EIG-Research</h2>
<div id="eig-research-repos" class="work-card-grid" data-state="loading" aria-live="polite" aria-busy="true">
  <div class="work-card work-card--policy">
    <span class="work-card__eyebrow">Loading</span>
    <p class="work-card__finding">Fetching the five most recently updated repositories from the EIG-Research GitHub organization.</p>
  </div>
</div>
<noscript>
  <p class="work-card__finding">This list loads from the GitHub API with JavaScript. Browse the organization directly at <a href="https://github.com/EIG-Research">github.com/EIG-Research</a>.</p>
</noscript>
<p class="work-card__meta" style="margin-top: 1rem;">
  For the full catalog, browse
  <a href="https://github.com/EIG-Research" target="_blank" rel="noopener noreferrer">github.com/EIG-Research</a>.
</p>

{% include axis-rule.liquid %}

<h2>Personal Research Code</h2>
<p class="research-intro">
  Replication code for published papers and research side projects live on my personal account at
  <a href="https://github.com/bnglasner" target="_blank" rel="noopener noreferrer">github.com/bnglasner</a>. Forks,
  course material, and the source for this site are not listed.
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

    var cacheKey = 'eig-research-repos';
    try {
      var cached = sessionStorage.getItem(cacheKey);
      if (cached) {
        renderRepos(JSON.parse(cached));
        container.setAttribute('aria-busy', 'false');
        return;
      }
    } catch (e) {}

    var controller = typeof AbortController === 'function' ? new AbortController() : null;
    var timer = controller
      ? setTimeout(function () {
          controller.abort();
        }, 8000)
      : null;

    fetch(endpoint, { headers: { Accept: 'application/vnd.github+json' }, signal: controller ? controller.signal : undefined })
      .then(function (response) {
        if (!response.ok) {
          throw new Error(
            response.status === 403 || response.status === 429 ? 'GitHub is limiting requests right now.' : 'GitHub did not respond as expected.'
          );
        }
        return response.json();
      })
      .then(function (repos) {
        renderRepos(repos);
        try {
          sessionStorage.setItem(cacheKey, JSON.stringify(repos));
        } catch (e) {}
      })
      .catch(function (error) {
        renderError(error && error.name === 'AbortError' ? 'GitHub took too long to respond.' : error && error.message ? error.message : 'The list could not load.');
      })
      .finally(function () {
        if (timer) clearTimeout(timer);
        container.setAttribute('aria-busy', 'false');
      });
  })();
</script>
