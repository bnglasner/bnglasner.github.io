---
layout: page
permalink: /wage-subsidy-sim/
title: wage subsidy simulator
description: Interactive simulation of the EIG 80-80 Rule wage subsidy proposal, estimating fiscal and distributional effects for U.S. workers.
nav: true
nav_order: 5
---

<p>
  This tool simulates the fiscal and distributional effects of the <a href="https://eig.org/how-to-end-low-wage-work-forever/" target="_blank">EIG 80-80 Rule</a> wage subsidy proposal.
  It combines Current Population Survey (CPS) microdata with pre-computed PolicyEngine-US household income schedules to estimate eligibility, gross cost, and safety-net interactions at the individual and population level.
</p>

<p style="font-size: 0.85rem; color: #666;">
  The app is hosted on Streamlit Community Cloud. If it shows a loading screen, click <strong>Yes, get this app back up!</strong> to wake it from sleep.
  You can also open it directly at
  <a href="https://eig-wage-subsidy.streamlit.app/" target="_blank">eig-wage-subsidy.streamlit.app</a>.
</p>

<div style="position: relative; width: 100%; padding-bottom: 0;">
  <iframe
    src="https://eig-wage-subsidy.streamlit.app/?embed=true"
    style="width: 100%; height: 85vh; min-height: 600px; border: 1px solid #e0e0e0; border-radius: 6px;"
    allow="clipboard-read; clipboard-write"
    loading="lazy"
  ></iframe>
</div>
