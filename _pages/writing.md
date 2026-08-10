---
layout: page
permalink: /writing/
title: Policy writing
description: Policy reports, essays, and public-facing commentary.
nav: true
nav_order: 2
redesign_2026: true
---

<p class="research-intro">
  For a closer look at three specific policy designs — the problem, the state of the research, and my role in it — see
  <a href="{{ '/policy/' | relative_url }}">Policy focus areas</a>.
</p>

<h2>Policy Reports</h2>
<div class="work-card-grid">
  {% for item in site.data.writing.reports %}
    <div class="work-card work-card--policy">
      <span class="work-card__eyebrow">POLICY REPORT · {{ item.published | date: "%Y" }}</span>
      <h3 class="work-card__title">
        <a href="{{ item.url }}" target="_blank" rel="noopener noreferrer">{{ item.title }}</a>
      </h3>
      <p class="work-card__finding">{{ item.description }}</p>
      <div class="work-card__meta">
        <span>{{ item.outlet }}</span>
        {% if item.authors.size > 1 %}<span>{{ item.authors | join: ", " }}</span>{% endif %}
      </div>
    </div>
  {% endfor %}
</div>

<h2>Essays and Commentary</h2>
<p class="research-intro">
  Agglomerations is the EIG newsletter; pieces are sometimes solo, sometimes co-authored with EIG colleagues.
  Co-bylines are noted on each card.
</p>
<div class="work-card-grid">
  {% for item in site.data.writing.short_form %}
    <div class="work-card work-card--policy">
      <span class="work-card__eyebrow">ESSAY · {{ item.published | date: "%Y" }}</span>
      <h3 class="work-card__title">
        <a href="{{ item.url }}" target="_blank" rel="noopener noreferrer">{{ item.title }}</a>
      </h3>
      <p class="work-card__finding">{{ item.description }}</p>
      <div class="work-card__meta">
        <span>{{ item.outlet }}</span>
        {% if item.authors.size > 1 %}<span>{{ item.authors | join: ", " }}</span>{% endif %}
      </div>
    </div>
  {% endfor %}
</div>

{% if site.data.writing.guest_posts %}

  <h2>Guest Writing</h2>
  <p class="research-intro">Pieces written for outside publications.</p>
  <div class="work-card-grid">
    {% for item in site.data.writing.guest_posts %}
      <div class="work-card work-card--policy">
        <span class="work-card__eyebrow">GUEST ESSAY · {{ item.published | date: "%Y" }}</span>
        <h3 class="work-card__title">
          <a href="{{ item.url }}" target="_blank" rel="noopener noreferrer">{{ item.title }}</a>
        </h3>
        <p class="work-card__finding">{{ item.description }}</p>
        <div class="work-card__meta">
          <span>{{ item.outlet }}</span>
          {% if item.authors.size > 1 %}<span>{{ item.authors | join: ", " }}</span>{% endif %}
        </div>
      </div>
    {% endfor %}
  </div>
{% endif %}
