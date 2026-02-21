---
layout: page
permalink: /repositories/
title: repositories
description: GitHub profile and research code repositories.
nav: true
nav_order: 5
---

{% assign github_users = site.data.repositories.github_users %}
{% if site.data.repos and site.data.repos.featured and site.data.repos.featured.size > 0 %}
  {% assign featured_repos = site.data.repos.featured %}
{% elsif site.data.repositories.github_repos %}
  {% assign featured_repos = site.data.repositories.github_repos %}
{% else %}
  {% assign featured_repos = nil %}
{% endif %}

{% if github_users %}

## GitHub users

<div class="repositories d-flex flex-wrap flex-md-row flex-column justify-content-between align-items-center">
  {% for user in github_users %}
    {% include repository/repo_user.liquid username=user %}
  {% endfor %}
</div>

---

{% if site.repo_trophies.enabled %}
{% for user in github_users %}
{% if github_users.size > 1 %}

  <h4>{{ user }}</h4>
  {% endif %}
  <div class="repositories d-flex flex-wrap flex-md-row flex-column justify-content-between align-items-center">
  {% include repository/repo_trophies.liquid username=user %}
  </div>

---

{% endfor %}
{% endif %}
{% endif %}

{% if featured_repos %}

## GitHub Repositories

<div class="repositories d-flex flex-wrap flex-md-row flex-column justify-content-between align-items-center">
  {% for repo in featured_repos %}
    {% if repo.full_name %}
      {% include repository/repo.liquid repository=repo.full_name %}
    {% else %}
      {% include repository/repo.liquid repository=repo %}
    {% endif %}
  {% endfor %}
</div>
{% endif %}
