---
layout: page
permalink: /publications/
title: Research
description: Peer-reviewed research, working papers, and dissertation or thesis research.
nav: true
nav_order: 1
---

This page covers the formal research record: peer-reviewed publications, working papers, and dissertation or thesis research. Policy reports, essays, and commentary are collected separately on the [writing]({{ '/writing/' | relative_url }}) page.

{% include bib_search.liquid %}

<div class="publications">
  <h2>Peer-Reviewed Research</h2>
  {% bibliography --group_by none --query @*[entry_group=peer_reviewed]* %}

  <h2>Working Papers</h2>
  {% bibliography --group_by none --query @*[entry_group=working_paper]* %}

  <h2>Dissertation and Thesis Research</h2>
  <h3>Dissertation</h3>
  {% bibliography --group_by none --query @*[entry_group=dissertation]* %}
  <h3>Senior Thesis</h3>
  {% bibliography --group_by none --query @*[entry_group=thesis]* %}
</div>
