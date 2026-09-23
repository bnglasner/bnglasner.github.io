---
layout: page
permalink: /publications/
title: Research
description: Peer-reviewed research, working papers, policy reports, and thesis research, grouped by research agenda.
nav: true
nav_order: 1
redesign_2026: true
# Page-level jekyll-scholar overrides. details_link: false stops the plugin from
# appending its own "Details" link after every card (bib.liquid already links
# the detail page inside the card). sort_by/order put the newest work first
# within each type block below.
scholar:
  details_link: false
  sort_by: year,month
  order: descending
---

{%- comment -%}
One section per research theme (\_data/research_themes.yml), keyed by each
papers.bib entry's `theme` field. Inside a theme, one bibliography query per
entry_group keeps the type order fixed (peer-reviewed first); the per-query

  <ol> wrappers are stripped so every card in a theme shares one grid, and a
  query that matches nothing prints nothing. Type labels stay on each card's
  eyebrow (_includes/entry-type-label.liquid).
{%- endcomment -%}
{%- assign research_groups = "peer_reviewed,working_paper,policy_report,dissertation,thesis" | split: "," -%}

<p class="research-intro">
  Each card is labeled peer-reviewed, working paper, policy report, or thesis research, and lists every coauthor. The full list
  of reports and analyses is on the <a href="{{ '/policy/' | relative_url }}#reports">Policy</a> page, essays and commentary
  are on the <a href="{{ '/writing/' | relative_url }}">Writing</a> page, and replication code is on the
  <a href="{{ '/repositories/' | relative_url }}">Code</a> page.
</p>

<p class="research-intro">
  Research strands:
  {% for theme in site.data.research_themes -%}
    <a href="#theme-{{ theme.key }}">{{ theme.title }}</a>
    {%- unless forloop.last %} · {% endunless %}
  {% endfor %}
</p>

{% include bib_search.liquid %}

{% for theme in site.data.research_themes %}
{%- assign theme_key = theme.key -%}
{%- capture theme_cards -%}
{%- for research_group in research_groups -%}
{%- capture rendered -%}{% bibliography --group_by none --query @*[theme={{theme_key}},entry_group={{research_group}}] %}{%- endcapture -%}
{%- if rendered contains "<li" -%}
{{- rendered | remove: '<ol class="bibliography">' | remove: "</ol>" -}}
{%- endif -%}
{%- endfor -%}
{%- endcapture -%}

  <section class="research-theme" id="theme-{{ theme.key }}" data-bibsearch-group>
    <h2>{{ theme.title }}</h2>
    <p class="research-intro">{{ theme.description }}</p>
    <ol class="bibliography">
      {{ theme_cards }}
    </ol>
  </section>
{% endfor %}
