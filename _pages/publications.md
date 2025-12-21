---
layout: page
permalink: /publications/
title: publications
description: Peer-reviewed articles, policy reports, and working papers.
nav: true
nav_order: 2
---

{% include bib_search.liquid %}

<div class="publications">

## Peer-reviewed articles
{% bibliography --query @article %}

## Reports & working papers
{% bibliography --query @techreport %}

</div>
