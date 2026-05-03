---
layout: about
title: about
permalink: /
subtitle: Research on labor markets, place-based policy, and social-policy design.
profile:
  align: right
  image: prof_pic_color.jpg
  image_alt: Benjamin Glasner standing on the walls of the old city of Dubrovnik with the harbor and Adriatic coast in the background.
  image_circular: false
  more_info: >
    <p>Washington, D.C.</p>
    <p>Senior Economist, Economic Innovation Group</p>
social: true
selected_papers: true
---

<div class="home-intro">
  <p>I am Benjamin Glasner, Ph.D., a Senior Economist at the Economic Innovation Group in Washington, D.C. I study labor markets, place-based policy, and social-policy design with a focus on worker well-being, economic mobility, and the local consequences of national policy choices.</p>
  <p>My work sits at the intersection of applied microeconomics, policy evaluation, and public-facing research communication. I aim to produce evidence that holds up empirically and is still useful to policymakers, journalists, and practitioners who need to act on it.</p>
</div>

<section class="section-block">
  <h2 class="section-kicker">What I Work On</h2>
  <div class="insight-grid">
    <div class="insight-card">
      <h3>Wages and Work</h3>
      <p>I study low-wage work, labor-market power, worker classification, and how policy design changes earnings and opportunity.</p>
    </div>
    <div class="insight-card">
      <h3>Place-Based Policy</h3>
      <p>I analyze how national policy interacts with local labor markets, housing supply, and regional economic resilience.</p>
    </div>
    <div class="insight-card">
      <h3>Transfers and Poverty</h3>
      <p>I work on the employment and well-being effects of safety-net programs and the long-run dynamics of poverty and mobility.</p>
    </div>
  </div>
</section>

<section class="section-block">
  <h2 class="section-kicker">Start Here</h2>
  <div class="quick-links">
    <a class="quick-link-card" href="{{ '/cv/' | relative_url }}">
      <strong>CV</strong>
      <span>Structured public CV with downloadable one-page, two-page, and full versions.</span>
    </a>
    <a class="quick-link-card" href="{{ '/publications/' | relative_url }}">
      <strong>Publications</strong>
      <span>Formal journal articles, working papers, thesis research, and policy reports from the repo bibliography.</span>
    </a>
    <a class="quick-link-card" href="{{ '/writing/' | relative_url }}">
      <strong>Writing</strong>
      <span>Curated reports, essays, and short-form commentary that complement the formal scholarly record.</span>
    </a>
    <a class="quick-link-card" href="{{ '/repositories/' | relative_url }}">
      <strong>Code + Data</strong>
      <span>Selected repositories behind policy reports, research infrastructure, and reproducible analysis.</span>
    </a>
    <a class="quick-link-card" href="{{ '/tools/' | relative_url }}">
      <strong>Tools</strong>
      <span>Interactive work that turns research into something decision-makers can use directly.</span>
    </a>
  </div>
</section>

<section class="section-block">
  <h2 class="section-kicker">Current Focus</h2>
  <ul class="focus-list">
    <li>Designing and evaluating policies that raise earnings and improve job quality for low-wage workers.</li>
    <li>Measuring how place-based policy changes housing supply, local growth, and regional inequality.</li>
    <li>Translating complex quantitative work into public-facing reports, essays, and interactive tools.</li>
  </ul>
</section>

<section class="section-block">
  <h2 class="section-kicker">Featured Writing</h2>
  {% assign featured_writing = site.data.writing.short_form | where: 'featured', true %}
  <div class="page-card-grid">
    {% for item in featured_writing limit: 3 %}
      <article class="page-card">
        <p class="meta-line">{{ item.outlet }} · {{ item.published | date: "%B %Y" }}</p>
        <h3><a href="{{ item.url }}">{{ item.title }}</a></h3>
        <p>{{ item.description }}</p>
      </article>
    {% endfor %}
  </div>
</section>

<section class="section-block">
  <h2 class="section-kicker">Code, Data, and Tools</h2>
  <div class="page-card-grid">
    <article class="page-card">
      <p class="meta-line">Featured Tool</p>
      <h3><a href="{{ '/wage-subsidy-sim/' | relative_url }}">80-80 wage subsidy simulator</a></h3>
      <p>A methods and policy page for the 80-80 Rule simulator, preserving the proposal logic and public framing while the live prototype is offline.</p>
    </article>
    <article class="page-card">
      <p class="meta-line">Research Infrastructure</p>
      <h3><a href="{{ '/repositories/' | relative_url }}">Code + data</a></h3>
      <p>A curated set of public repositories behind research products, policy reports, and reproducible workflows.</p>
    </article>
    <article class="page-card">
      <p class="meta-line">Decision Support</p>
      <h3><a href="{{ '/tools/' | relative_url }}">Tools</a></h3>
      <p>A home for interactive work that makes empirical analysis easier to inspect, share, and apply.</p>
    </article>
  </div>
</section>
