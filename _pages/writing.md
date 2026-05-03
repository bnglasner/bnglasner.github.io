---
layout: page
permalink: /writing/
title: writing
description: Policy reports, working papers, and selected short-form essays.
nav: true
nav_order: 4
---

<div class="page-lead">
  <p>This page collects public-facing writing that sits alongside the formal publications listed on the <a href="{{ '/publications/' | relative_url }}">publications</a> page. Reports, essays, and commentary now come from repo-local structured metadata instead of scattered hard-coded markdown.</p>
</div>

<section class="section-block">
  <h2 class="section-kicker">Policy Reports</h2>
  <div class="page-card-grid">
    {% for item in site.data.writing.reports %}
      <article class="page-card">
        <p class="meta-line">{{ item.outlet }} · {{ item.published | date: "%B %Y" }}</p>
        <h3><a href="{{ item.url }}">{{ item.title }}</a></h3>
        <p>{{ item.description }}</p>
      </article>
    {% endfor %}
  </div>
</section>

<section class="section-block">
  <h2 class="section-kicker">Working Papers and Long-Form Research</h2>
  <div class="page-card-grid">
    {% for item in site.data.writing.working_papers %}
      <article class="page-card">
        <p class="meta-line">{{ item.outlet }} · {{ item.published | date: "%Y" }}</p>
        <h3>{% if item.url %}<a href="{{ item.url }}">{{ item.title }}</a>{% else %}{{ item.title }}{% endif %}</h3>
        <p>{{ item.description }}</p>
      </article>
    {% endfor %}
  </div>
</section>

<section class="section-block">
  <h2 class="section-kicker">Selected Short-Form Writing</h2>
  <div class="page-card-grid">
    {% for item in site.data.writing.short_form %}
      <article class="page-card">
        <p class="meta-line">{{ item.outlet }} · {{ item.published | date: "%B %Y" }}</p>
        <h3><a href="{{ item.url }}">{{ item.title }}</a></h3>
        <p>{{ item.description }}</p>
      </article>
    {% endfor %}
  </div>
</section>
