---
layout: page
permalink: /writing/
title: Writing
description: Essays and commentary on Agglomerations and in outside publications.
nav: true
nav_order: 3
redesign_2026: true
---

{% comment %} Author lists keep each byline as published in the writing data file; the replace filter shows one form of Ben's name on the page. {% endcomment %}

<p class="research-intro">
  Reports and analyses are on the <a href="{{ '/policy/' | relative_url }}#reports">Policy</a> page, alongside the three
  policy designs I work on most.
</p>

<h2>Essays and Commentary</h2>
<p class="research-intro">
  Agglomerations is the EIG newsletter; pieces are sometimes solo, sometimes co-authored with EIG colleagues.
  Co-authors are listed on each card.
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
        {% if item.authors.size > 1 %}<span>{{ item.authors | join: ", " | replace: "Ben Glasner", "Benjamin Glasner" }}</span>{% endif %}
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
          {% if item.authors.size > 1 %}<span>{{ item.authors | join: ", " | replace: "Ben Glasner", "Benjamin Glasner" }}</span>{% endif %}
        </div>
      </div>
    {% endfor %}
  </div>
{% endif %}
