---
layout: about
title: about
permalink: /
subtitle: Research on U.S. labor markets, place-based policy, and the design of the social safety net.
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
  <p>I am Benjamin Glasner, a Senior Economist at the Economic Innovation Group in Washington, D.C. My research focuses on U.S. labor markets, place-based policy, and the design of the social safety net — with a particular interest in worker well-being, economic mobility, and how national policy choices play out in local economies.</p>
  <p>I work at the intersection of applied microeconomics, policy evaluation, and public-facing research communication. The goal is research that holds up under empirical scrutiny and is still useful to the policymakers, journalists, and practitioners who have to act on it.</p>
</div>

<section class="section-block">
  <h2 class="section-kicker">What I Work On</h2>
  <div class="insight-grid">
    <div class="insight-card">
      <h3>Wages and Work</h3>
      <p>I study low-wage work, labor-market power, worker classification, and how policy design shapes earnings and opportunity.</p>
    </div>
    <div class="insight-card">
      <h3>Place-Based Policy</h3>
      <p>I analyze how national policy reshapes local labor markets, housing supply, and regional economic resilience.</p>
    </div>
    <div class="insight-card">
      <h3>Transfers and Poverty</h3>
      <p>I study how safety-net programs change employment and well-being, and how poverty and mobility evolve over the long run.</p>
    </div>
  </div>
</section>

<section class="section-block">
  <h2 class="section-kicker">Start Here</h2>
  <div class="quick-links">
    <a class="quick-link-card" href="{{ '/cv/' | relative_url }}">
      <strong>CV</strong>
      <span>The full CV, with downloadable one-page, two-page, and complete versions.</span>
    </a>
    <a class="quick-link-card" href="{{ '/publications/' | relative_url }}">
      <strong>Publications</strong>
      <span>Journal articles, working papers, thesis research, and policy reports.</span>
    </a>
    <a class="quick-link-card" href="{{ '/writing/' | relative_url }}">
      <strong>Writing</strong>
      <span>Reports, essays, and short-form commentary that sit alongside the formal scholarly record.</span>
    </a>
    <a class="quick-link-card" href="{{ '/repositories/' | relative_url }}">
      <strong>Code + Data</strong>
      <span>Public repositories behind the policy reports, research infrastructure, and reproducible analysis.</span>
    </a>
    <a class="quick-link-card" href="{{ '/policy/' | relative_url }}">
      <strong>Policy</strong>
      <span>Active policy work: Opportunity Zones, the Retirement Savings for Americans Act, and the 80-80 wage subsidy proposal.</span>
    </a>
  </div>
</section>

<section class="section-block">
  <h2 class="section-kicker">Current Focus</h2>
  <ul class="focus-list">
    <li>Designing and evaluating policies that raise earnings and improve job quality for low-wage workers.</li>
    <li>Measuring how place-based policy reshapes housing supply, local growth, and regional inequality.</li>
    <li>Translating quantitative research into public-facing reports, essays, and interactive tools.</li>
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
      <p>Methods and policy notes for the 80-80 Rule simulator. The live prototype is offline; this page documents the model and the proposal it supports.</p>
    </article>
    <article class="page-card">
      <p class="meta-line">Research Infrastructure</p>
      <h3><a href="{{ '/repositories/' | relative_url }}">Code + data</a></h3>
      <p>Public repositories behind the research products, policy reports, and reproducible workflows.</p>
    </article>
    <article class="page-card">
      <p class="meta-line">Policy Agenda</p>
      <h3><a href="{{ '/policy/' | relative_url }}">Policy</a></h3>
      <p>The problem each policy is meant to solve, the state of the relevant literature, and my role on Opportunity Zones, the Retirement Savings for Americans Act, and the 80-80 wage subsidy.</p>
    </article>
  </div>
</section>
