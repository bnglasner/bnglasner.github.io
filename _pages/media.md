---
layout: page
permalink: /media/
title: media
description: Public-facing media, appearances, and related mentions.
nav: true
nav_order: 6
---

{% assign media_items = site.data.media.items %}

{% if media_items and media_items.size > 0 %}

<ul>
  {% for item in media_items %}
  <li>
    <a href="{{ item.url }}" target="_blank" rel="noopener noreferrer">{{ item.title }}</a>
    {% if item.source %} ({{ item.source }}){% endif %}
    {% if item.category %} - {{ item.category }}{% endif %}
    {% if item.published_at %} - {{ item.published_at }}{% endif %}
  </li>
  {% endfor %}
</ul>

{% else %}

No media items found yet. Run the monthly refresh pipeline to populate this page.

{% endif %}
