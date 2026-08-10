---
layout: page
permalink: /publications/
title: Research
description: Peer-reviewed research, working papers, and dissertation or thesis research.
nav: true
nav_order: 1
enable_publication_badges: true
redesign_2026: true
---

<p class="research-intro">
  Policy reports, essays, and commentary are collected separately on the
  <a href="{{ '/writing/' | relative_url }}">Policy writing</a> page.
</p>

{% include bib_search.liquid %}

<h2>Peer-Reviewed Research</h2>
{% bibliography --group_by none --query @*[entry_group=peer_reviewed]* %}

<h2>Working Papers</h2>
{% bibliography --group_by none --query @*[entry_group=working_paper]* %}

<h2>Dissertation and Thesis Research</h2>
{% bibliography --group_by none --query @*[entry_group=dissertation]* %}
{% bibliography --group_by none --query @*[entry_group=thesis]* %}
