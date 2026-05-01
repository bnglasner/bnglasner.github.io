---
layout: page
permalink: /publications/
title: publications
description: Journal articles, working papers, thesis research, and policy reports generated from the repository bibliography.
nav: true
nav_order: 3
---

The formal bibliography on this page is generated from the repo-local source file `_bibliography/papers.bib`. Short-form essays and commentary are curated separately on the [writing]({{ '/writing/' | relative_url }}) page.

{% include bib_search.liquid %}

<div class="publications">
  <h2>Peer-Reviewed Publications</h2>
  {% bibliography --group_by none --query @*[entry_group=peer_reviewed]* %}

  <h2>Working Papers</h2>
  {% bibliography --group_by none --query @*[entry_group=working_paper]* %}

  <h2>Dissertation and Thesis Research</h2>
  <h3>Dissertation</h3>
  {% bibliography --group_by none --query @*[entry_group=dissertation]* %}
  <h3>Senior Thesis</h3>
  {% bibliography --group_by none --query @*[entry_group=thesis]* %}

  <h2>Policy Reports and Research Notes</h2>
  {% bibliography --group_by none --query @*[entry_group=policy_report]* %}
</div>
