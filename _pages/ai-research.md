---
layout: page
permalink: /ai-research/
title: AI and research infrastructure
description: "AI-assisted workflows for empirical economic research: a research template and an institutional knowledge base, built at the Economic Innovation Group."
nav: false
redesign_2026: true
---

{% comment %}
Off-nav by design (the AI work is a second lane, not equal billing with the research):
linked from the Code page, the Press page, and the CV.
Ben's instruction (2026-11-14): describe both systems at a high level only. No internal
repository names or links, component counts, test results, or project status. Keep it
that way when editing.
{% endcomment %}

<p class="research-intro">
  I build the systems Economic Innovation Group researchers use to do empirical work with AI agents, along with the guardrails that
  keep that work checkable. The goal is faster research without weaker evidence: every number traceable to its source, every claim
  reviewed, and the writing still done by people.
</p>

<div class="policy-section" id="research-template">
  <h2>An AI-assisted research template</h2>
  <p>
    I designed and maintain EIG's AI-assisted research template, a common starting point for empirical projects. A researcher
    describes the work in plain language, and an AI coding agent plans it, builds the data pipeline, and documents each step under
    EIG's standards for code, methods, data, and figures.
  </p>
  <p>
    Before work is released, the template puts it through structured review of the code, the methodology, and the numbers, including
    checks for errors specific to AI, such as invented citations or variables. Finished projects can be released as replication
    packages, so outside readers can trace each figure back to the data.
  </p>
</div>

<div class="policy-section" id="knowledge-base">
  <h2>A knowledge base for institutional memory</h2>
  <p>
    I also designed and prototyped a knowledge base that turns an organization's scattered knowledge — its publications, datasets,
    proposals, and decisions — into one linked, structured record that both people and AI agents can read. Staff add to it by
    describing what happened to an AI assistant instead of filling in forms. The same assistant can then answer questions about past
    work and prepare briefings, with sources.
  </p>
</div>

<div class="policy-section" id="principles">
  <h2>Principles</h2>
  <ul>
    <li>
      <strong>AI speeds up the pipeline, not the judgment.</strong> Research questions, methods choices, and conclusions stay with the
      researcher.
    </li>
    <li>
      <strong>Every number is checkable.</strong> Analyses run end to end from raw inputs, and review confirms that what the text says
      matches what the code produces.
    </li>
    <li><strong>The writing is human.</strong> AI does not draft the prose of published work, and its role in the analysis is disclosed.</li>
    <li>
      <strong>Open by default.</strong> Released work ships with code and documentation; see
      <a href="{{ '/repositories/' | relative_url }}">Code</a>.
    </li>
  </ul>
</div>

<div class="policy-section" id="writing">
  <h2>Writing on AI and the economy</h2>
  <ul class="policy-section__links">
    <li>
      <a href="https://agglomerations.eig.org/p/fat-bear-week-and-the-fate-of-the" target="_blank" rel="noopener noreferrer"
        >Fat Bear Week and the Fate of the World</a
      >
      (with Nathan Goldschlag, Agglomerations, October 2025): AI, productivity, and the human-judgment problems that policy still has to
      solve.
    </li>
  </ul>
</div>

<div class="policy-section" id="talks">
  <h2>Talks and conversations</h2>
  <p>
    Requests to discuss this work with research teams, conferences, and panels are welcome. Contact details are on
    <a href="{{ '/press/' | relative_url }}">Press and speaking</a>.
  </p>
</div>

<div class="policy-section" id="disclosure">
  <h2>A disclosure</h2>
  <p>
    In keeping with the principles above: this website was built and drafted with the help of AI agents. Consider it the one place
    where the human-writing rule is relaxed, on the theory that no one has ever cited a personal website in a footnote. Every fact on
    it was still checked against a source, and I reviewed every page. The em dashes, for the record, are mine — I was using them long
    before the chatbots made them suspicious.
  </p>
</div>
