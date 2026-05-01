---
permalink: /assets/js/search-data.js
---
const ninja = document.querySelector("ninja-keys");

ninja.data = [
  {%- for page in site.pages -%}
    {%- if page.permalink == '/' -%}{%- assign about_title = page.title | strip -%}{%- endif -%}
  {%- endfor -%}
  {
    id: "nav-{{ about_title | slugify }}",
    title: "{{ about_title | truncatewords: 13 }}",
    section: "Navigation",
    handler: () => {
      window.location.href = "{{ '/' | relative_url }}";
    },
  },
  {%- assign sorted_pages = site.pages | sort: "nav_order" -%}
  {%- for p in sorted_pages -%}
    {%- if p.nav and p.autogen == null -%}
      {
        {%- assign title = p.title | escape | strip -%}
        id: "nav-{{ title | slugify }}",
        title: "{{ title | truncatewords: 13 }}",
        description: "{{ p.description | strip_html | strip_newlines | escape | strip }}",
        section: "Navigation",
        handler: () => {
          window.location.href = "{{ p.url | relative_url }}";
        },
      },
    {%- endif -%}
  {%- endfor -%}
  {%- for item in site.data.writing.reports -%}
    {
      id: "report-{{ item.title | slugify }}",
      title: "{{ item.title | escape | truncatewords: 13 }}",
      description: "{{ item.description | strip_html | strip_newlines | escape | strip }}",
      section: "Reports",
      handler: () => {
        window.open("{{ item.url }}", "_blank");
      },
    },
  {%- endfor -%}
  {%- for item in site.data.writing.working_papers -%}
    {
      id: "working-paper-{{ item.title | slugify }}",
      title: "{{ item.title | escape | truncatewords: 13 }}",
      description: "{{ item.description | strip_html | strip_newlines | escape | strip }}",
      section: "Working Papers",
      handler: () => {
        {% if item.url %}
          window.open("{{ item.url }}", "_blank");
        {% else %}
          window.location.href = "{{ '/writing/' | relative_url }}";
        {% endif %}
      },
    },
  {%- endfor -%}
  {%- for item in site.data.writing.short_form -%}
    {
      id: "writing-{{ item.title | slugify }}",
      title: "{{ item.title | escape | truncatewords: 13 }}",
      description: "{{ item.description | strip_html | strip_newlines | escape | strip }}",
      section: "Writing",
      handler: () => {
        window.open("{{ item.url }}", "_blank");
      },
    },
  {%- endfor -%}
  {%- for repo in site.data.repositories.featured -%}
    {
      id: "repo-{{ repo.organization | slugify }}-{{ repo.name | slugify }}",
      title: "{{ repo.organization }}/{{ repo.name }}",
      description: "{{ repo.description | strip_html | strip_newlines | escape | strip }}",
      section: "Code + Data",
      handler: () => {
        window.open("{{ repo.url }}", "_blank");
      },
    },
  {%- endfor -%}
  {%- if site.socials_in_search -%}
    {%- for social in site.data.socials -%}
      {%- case social[0] -%}
        {%- when "cv_pdf" -%}
          {
            id: "social-cv",
            title: "CV PDF",
            section: "Profiles",
            handler: () => {
              window.open("{{ social[1] | relative_url }}", "_blank");
            },
          },
        {%- when "email" -%}
          {
            id: "social-email",
            title: "email",
            section: "Profiles",
            handler: () => {
              window.location.href = "mailto:{{ social[1] | encode_email }}";
            },
          },
        {%- when "github_username" -%}
          {
            id: "social-github",
            title: "GitHub",
            section: "Profiles",
            handler: () => {
              window.open("https://github.com/{{ social[1] }}", "_blank");
            },
          },
        {%- when "linkedin_username" -%}
          {
            id: "social-linkedin",
            title: "LinkedIn",
            section: "Profiles",
            handler: () => {
              window.open("https://www.linkedin.com/in/{{ social[1] }}", "_blank");
            },
          },
        {%- when "scholar_userid" -%}
          {
            id: "social-scholar",
            title: "Google Scholar",
            section: "Profiles",
            handler: () => {
              window.open("https://scholar.google.com/citations?user={{ social[1] }}", "_blank");
            },
          },
      {%- endcase -%}
    {%- endfor -%}
  {%- endif -%}
];
