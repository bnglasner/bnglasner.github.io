---
layout: page
permalink: /media/
title: Media
description: Verified interviews, broadcast appearances, podcasts, and quoted coverage.
nav: true
nav_order: 3
redesign_2026: true
toc:
  sidebar: right
---

{% assign media_page = site.data.media_page %}

<p class="research-intro">{{ media_page.lead.primary }}</p>

{% for section in media_page.sections %}
  {% case section.title %}
    {% when "Broadcast and Video" %}
      {% assign type_label = "BROADCAST" %}
    {% when "Podcasts and Radio" %}
      {% assign type_label = "PODCAST" %}
    {% when "Interviews and Features" %}
      {% assign type_label = "INTERVIEW" %}
    {% when "Quoted in News Coverage" %}
      {% assign type_label = "QUOTED" %}
    {% else %}
      {% assign type_label = "MEDIA" %}
  {% endcase %}

  <h2>{{ section.title }}</h2>
  <div class="work-card-grid">
    {% for item in section.items %}
      <div class="work-card work-card--policy">
        <span class="work-card__eyebrow">
          {{ type_label }}{% if item.published %} · {{ item.published | date: "%Y" }}{% endif %}
        </span>
        <h3 class="work-card__title">
          <a href="{{ item.url }}" target="_blank" rel="noopener noreferrer">{{ item.title }}</a>
        </h3>
        <p class="work-card__finding">{{ item.description }}</p>
        <div class="work-card__meta">
          <span>{{ item.outlet }}</span>
        </div>
      </div>
    {% endfor %}
  </div>
{% endfor %}

<h2>Selected Coverage of Research</h2>
<p class="research-intro">{{ media_page.lead.coverage }}</p>
{% for group in media_page.coverage_groups %}
  <h3>{{ group.title }}</h3>
  <p class="research-intro">{{ group.description }}</p>
  <div class="work-card-grid">
    {% for item in group.items %}
      <div class="work-card work-card--policy">
        <span class="work-card__eyebrow">COVERAGE · {{ item.published | date: "%Y" }}</span>
        <h4 class="work-card__title">
          <a href="{{ item.url }}" target="_blank" rel="noopener noreferrer">{{ item.title }}</a>
        </h4>
        <p class="work-card__finding">{{ item.description }}</p>
        <div class="work-card__meta">
          <span>{{ item.outlet }}</span>
        </div>
      </div>
    {% endfor %}
  </div>
{% endfor %}

<h2>Connect</h2>
<p class="research-intro measure">
  For media inquiries, podcast invitations, or speaking engagements, reach out at
  <a href="mailto:benjamin@eig.org">benjamin@eig.org</a>. For short-form commentary as it lands, the
  <a href="https://agglomerations.eig.org" target="_blank" rel="noopener noreferrer">Agglomerations</a>
  newsletter and <a href="https://x.com/BenGlasner" target="_blank" rel="noopener noreferrer">X</a> are the most
  up-to-date channels.
</p>
