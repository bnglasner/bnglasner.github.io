---
layout: page
permalink: /media/
title: Media
description: Verified interviews, broadcast appearances, podcasts, and quoted coverage.
nav: true
nav_order: 3
toc:
  sidebar: right
---

{% assign media_page = site.data.media_page %}

<div class="page-lead">
  <p>{{ media_page.lead.primary }}</p>
</div>

{% for section in media_page.sections %}
  <section class="section-block">
    <h2 class="section-kicker">{{ section.title }}</h2>
    <div class="page-card-grid">
      {% for item in section.items %}
        <article class="page-card">
          <p class="meta-line">
            {{ item.outlet }}{% if item.published %} · {{ item.published | date: "%B %-d, %Y" }}{% endif %}
          </p>
          <h3><a href="{{ item.url }}" target="_blank" rel="noopener noreferrer">{{ item.title }}</a></h3>
          <p>{{ item.description }}</p>
        </article>
      {% endfor %}
    </div>
  </section>
{% endfor %}

<section class="section-block">
  <h2 class="section-kicker">Selected Coverage of Research</h2>
  <p class="page-lead">{{ media_page.lead.coverage }}</p>
  {% for group in media_page.coverage_groups %}
    <h3>{{ group.title }}</h3>
    <p>{{ group.description }}</p>
    <div class="page-card-grid">
      {% for item in group.items %}
        <article class="page-card">
          <p class="meta-line">{{ item.outlet }} · {{ item.published | date: "%B %-d, %Y" }}</p>
          <h4><a href="{{ item.url }}" target="_blank" rel="noopener noreferrer">{{ item.title }}</a></h4>
          <p>{{ item.description }}</p>
        </article>
      {% endfor %}
    </div>
  {% endfor %}
</section>

<section class="section-block">
  <h2 class="section-kicker">Connect</h2>
  <p>For media inquiries, podcast invitations, or speaking engagements, reach out at <a href="mailto:benjamin@eig.org">benjamin@eig.org</a>. For short-form commentary as it lands, the <a href="https://agglomerations.eig.org" target="_blank" rel="noopener noreferrer">Agglomerations</a> newsletter and <a href="https://x.com/BenGlasner" target="_blank" rel="noopener noreferrer">X</a> are the most up-to-date channels.</p>
</section>
