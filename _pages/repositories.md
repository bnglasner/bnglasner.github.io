---
layout: page
permalink: /repositories/
title: code + data
description: Selected public repositories, reproducible research code, and data products.
nav: true
nav_order: 5
---

<div class="page-lead">
  <p>A curated view of public repositories that support research products, policy analysis, and reproducible workflows.</p>
</div>

<section class="section-block">
  <h2 class="section-kicker">Primary Profiles</h2>
  <div class="page-card-grid">
    {% for profile in site.data.repositories.profiles %}
      <article class="page-card">
        <p class="meta-line">Profile</p>
        <h3><a href="{{ profile.url }}">{{ profile.label }}</a></h3>
        <p>{{ profile.description }}</p>
      </article>
    {% endfor %}
  </div>
</section>

<section class="section-block">
  <h2 class="section-kicker">Selected Repositories</h2>
  <div class="page-card-grid">
    {% for repo in site.data.repositories.featured %}
      <article class="page-card">
        <p class="meta-line">{{ repo.language }} · updated {{ repo.updated }}</p>
        <h3><a href="{{ repo.url }}">{{ repo.organization }}/{{ repo.name }}</a></h3>
        <p>{{ repo.description }}</p>
      </article>
    {% endfor %}
  </div>
</section>
