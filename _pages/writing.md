---
layout: page
permalink: /writing/
title: writing
description: Policy reports, essays, and public-facing commentary.
nav: true
nav_order: 4
---

<div class="page-lead">
  <p>This page collects the public-facing writing that sits outside the formal scholarly record on the <a href="{{ '/publications/' | relative_url }}">publications</a> page. It focuses on policy reports, short-form essays, and guest writing for broader audiences.</p>
</div>

<section class="section-block">
  <h2 class="section-kicker">Policy Reports</h2>
  <div class="page-card-grid">
    {% for item in site.data.writing.reports %}
      <article class="page-card">
        <p class="meta-line">{{ item.outlet }} · {{ item.published | date: "%B %Y" }}{% if item.authors %} · {{ item.authors | join: ", " }}{% endif %}</p>
        <h3><a href="{{ item.url }}">{{ item.title }}</a></h3>
        <p>{{ item.description }}</p>
      </article>
    {% endfor %}
  </div>
</section>

<section class="section-block">
  <h2 class="section-kicker">Essays and Commentary</h2>
  <p class="page-lead">Agglomerations is the EIG newsletter; pieces are sometimes solo, sometimes co-authored with EIG colleagues. Co-bylines are noted on each card.</p>
  <div class="page-card-grid">
    {% for item in site.data.writing.short_form %}
      <article class="page-card">
        <p class="meta-line">{{ item.outlet }} · {{ item.published | date: "%B %Y" }}{% if item.authors %} · {{ item.authors | join: ", " }}{% endif %}</p>
        <h3><a href="{{ item.url }}">{{ item.title }}</a></h3>
        <p>{{ item.description }}</p>
      </article>
    {% endfor %}
  </div>
</section>

{% if site.data.writing.guest_posts %}

<section class="section-block">
  <h2 class="section-kicker">Guest Writing</h2>
  <p class="page-lead">Pieces written for outside publications.</p>
  <div class="page-card-grid">
    {% for item in site.data.writing.guest_posts %}
      <article class="page-card">
        <p class="meta-line">{{ item.outlet }} · {{ item.published | date: "%B %Y" }}{% if item.authors %} · {{ item.authors | join: ", " }}{% endif %}</p>
        <h3><a href="{{ item.url }}">{{ item.title }}</a></h3>
        <p>{{ item.description }}</p>
      </article>
    {% endfor %}
  </div>
</section>
{% endif %}
