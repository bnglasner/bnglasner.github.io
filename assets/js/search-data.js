const ninja = document.querySelector("ninja-keys");

ninja.data = [{
    id: "nav-about",
    title: "about",
    section: "Navigation",
    handler: () => {
      window.location.href = "/";
    },
  },{id: "nav-cv",
        title: "CV",
        description: "Full academic and policy CV maintained from repo-local structured data.",
        section: "Navigation",
        handler: () => {
          window.location.href = "/cv/";
        },
      },{id: "nav-publications",
        title: "publications",
        description: "Journal articles, working papers, thesis research, and policy reports generated from the repository bibliography.",
        section: "Navigation",
        handler: () => {
          window.location.href = "/publications/";
        },
      },{id: "nav-writing",
        title: "writing",
        description: "Policy reports, working papers, and selected short-form essays.",
        section: "Navigation",
        handler: () => {
          window.location.href = "/writing/";
        },
      },{id: "nav-code-data",
        title: "code + data",
        description: "Selected public repositories, reproducible research code, and data products.",
        section: "Navigation",
        handler: () => {
          window.location.href = "/repositories/";
        },
      },{id: "nav-tools",
        title: "tools",
        description: "Interactive research tools and policy prototypes.",
        section: "Navigation",
        handler: () => {
          window.location.href = "/tools/";
        },
      },{
      id: "report-how-to-end-low-wage-work-forever-an-80-80-wage-subsidy-proposal",
      title: "How to end low-wage work forever: An 80-80 wage subsidy proposal",
      description: "A proposal for a large, targeted wage subsidy designed to raise earnings and strengthen labor-market attachment for low-wage workers.",
      section: "Reports",
      handler: () => {
        window.open("https://eig.org/how-to-end-low-wage-work-forever/", "_blank");
      },
    },{
      id: "report-the-impact-of-opportunity-zones-on-housing-supply",
      title: "The Impact of Opportunity Zones on Housing Supply",
      description: "Evidence on how Opportunity Zones affected residential development and housing supply in designated communities.",
      section: "Reports",
      handler: () => {
        window.open("https://eig.org/opportunity-zones-housing-supply/", "_blank");
      },
    },{
      id: "report-the-great-transfer-mation-how-american-communities-became-reliant-on-income-from-government",
      title: "The Great &quot;Transfer&quot;-mation: How American Communities Became Reliant on Income from Government",
      description: "A portrait of how transfer income has grown across U.S. communities and reshaped local economic foundations.",
      section: "Reports",
      handler: () => {
        window.open("https://eig.org/great-transfermation/", "_blank");
      },
    },{
      id: "report-the-american-worker-project-toward-a-new-consensus",
      title: "The American Worker Project: Toward a New Consensus",
      description: "A framing document for a worker-centered economic policy agenda grounded in labor-market dynamism, mobility, and earnings growth.",
      section: "Reports",
      handler: () => {
        window.open("https://eig.org/american-worker/", "_blank");
      },
    },{
      id: "report-are-opportunity-zones-working-what-the-literature-tells-us",
      title: "Are Opportunity Zones Working? What the Literature Tells Us",
      description: "A synthesis of the empirical literature on Opportunity Zones and what early evidence suggests about program effects.",
      section: "Reports",
      handler: () => {
        window.open("https://eig.org/are-opportunity-zones-working/", "_blank");
      },
    },{
      id: "report-the-effects-of-noncompete-agreement-reforms-on-business-formation-a-comparison-of-hawaii-and-oregon",
      title: "The Effects of Noncompete Agreement Reforms on Business Formation: A Comparison of Hawaii...",
      description: "A research note comparing business-formation outcomes following noncompete reforms in two states.",
      section: "Reports",
      handler: () => {
        window.open("https://eig.org/noncompetes-research-note/", "_blank");
      },
    },{
      id: "working-paper-the-effectiveness-of-the-food-stamp-program-at-reducing-racial-differences-in-the-intergenerational-persistence-of-poverty",
      title: "The Effectiveness of the Food Stamp Program at Reducing Racial Differences in the...",
      description: "A working paper on how SNAP participation shaped intergenerational mobility and racial inequality in long-run poverty outcomes.",
      section: "Working Papers",
      handler: () => {
        
          window.open("https://equitablegrowth.org/working-papers/the-effectiveness-of-the-food-stamp-program-at-reducing-differences-in-the-intergenerational-persistence-of-poverty/", "_blank");
        
      },
    },{
      id: "working-paper-the-impact-of-public-policy-on-nonstandard-work-arrangements",
      title: "The Impact of Public Policy on Nonstandard Work Arrangements",
      description: "Doctoral dissertation on labor-market regulation, worker classification, and the gig economy.",
      section: "Working Papers",
      handler: () => {
        
          window.location.href = "/writing/";
        
      },
    },{
      id: "writing-looking-for-the-ladder",
      title: "Looking for the Ladder",
      description: "A short essay on early-career work, occupational ladders, and how AI may be reshaping entry-level opportunity.",
      section: "Writing",
      handler: () => {
        window.open("https://agglomerations.substack.com/p/looking-for-the-ladder", "_blank");
      },
    },{
      id: "writing-a-policy-stack-to-save-america",
      title: "A Policy Stack to Save America",
      description: "A year-end essay about combining abundance, work, and state capacity into a coherent policy program.",
      section: "Writing",
      handler: () => {
        window.open("https://agglomerations.substack.com/p/a-policy-stack-to-save-america", "_blank");
      },
    },{
      id: "writing-the-jobs-chart-that-really-has-us-worried",
      title: "The jobs chart that really has us worried",
      description: "An examination of labor-market slack through involuntary part-time work and what it signals about worker bargaining power.",
      section: "Writing",
      handler: () => {
        window.open("https://agglomerations.substack.com/p/the-jobs-chart-that-really-has-us", "_blank");
      },
    },{
      id: "writing-why-place-matters-more-than-ever",
      title: "Why Place Matters More Than Ever",
      description: "A short argument for why local labor markets and economic geography remain central to policy analysis.",
      section: "Writing",
      handler: () => {
        window.open("https://agglomerations.substack.com/p/why-place-matters-more-than-ever", "_blank");
      },
    },{
      id: "writing-no-governor-desantis-h-1bs-aren-t-going-to-cashiers",
      title: "No, Governor DeSantis, H-1Bs aren’t going to cashiers",
      description: "A data-driven response to common misconceptions about high-skill immigration and job competition.",
      section: "Writing",
      handler: () => {
        window.open("https://agglomerations.substack.com/p/no-governor-desantis-h-1bs-arent-going-to-cashiers", "_blank");
      },
    },{
      id: "writing-where-any-snap-lapse-will-bite-hardest",
      title: "Where any SNAP lapse will bite hardest",
      description: "A place-based look at which communities would feel the sharpest effects from interruptions in SNAP support.",
      section: "Writing",
      handler: () => {
        window.open("https://agglomerations.substack.com/p/where-any-snap-lapse-will-bite-hardest", "_blank");
      },
    },{
      id: "writing-fat-bear-week-and-the-fate-of-the-world",
      title: "Fat Bear Week and the Fate of the World",
      description: "A reflection on AI, productivity, and the human judgment problems that policy still has to solve.",
      section: "Writing",
      handler: () => {
        window.open("https://agglomerations.substack.com/p/fat-bear-week-and-the-fate-of-the", "_blank");
      },
    },{
      id: "writing-abundance-the-missing-piece",
      title: "Abundance: the Missing Piece",
      description: "A short essay on supply, implementation, and what abundance arguments need to say about institutions.",
      section: "Writing",
      handler: () => {
        window.open("https://agglomerations.substack.com/p/abundance-the-missing-piece", "_blank");
      },
    },{
      id: "writing-how-to-end-low-wage-work-forever",
      title: "How to end low-wage work forever",
      description: "A concise public-facing introduction to the wage subsidy proposal and the labor-market problem it is designed to solve.",
      section: "Writing",
      handler: () => {
        window.open("https://agglomerations.substack.com/p/how-to-end-low-wage-work-forever", "_blank");
      },
    },{
      id: "writing-tariffs-and-manufacturing-jobs-three-big-problems",
      title: "Tariffs and Manufacturing Jobs: Three Big Problems",
      description: "An evidence-based critique of common claims linking tariffs to durable manufacturing-job gains.",
      section: "Writing",
      handler: () => {
        window.open("https://agglomerations.substack.com/p/tariffs-and-manufacturing-jobs-three", "_blank");
      },
    },{
      id: "writing-opportunity-zones-a-quiet-revolution-in-housing-policy",
      title: "Opportunity Zones: A Quiet Revolution in Housing Policy",
      description: "A short essay connecting new evidence on Opportunity Zones to broader housing-supply debates.",
      section: "Writing",
      handler: () => {
        window.open("https://agglomerations.substack.com/p/opportunity-zones-a-quiet-revolution", "_blank");
      },
    },{
      id: "writing-no-we-are-not-producing-too-many-stem-graduates",
      title: "No, we are not producing too many STEM graduates",
      description: "A rebuttal to arguments that the U.S. has oversupplied STEM labor.",
      section: "Writing",
      handler: () => {
        window.open("https://agglomerations.substack.com/p/no-we-are-not-producing-too-many", "_blank");
      },
    },{
            id: "social-cv",
            title: "CV PDF",
            section: "Profiles",
            handler: () => {
              window.open("/assets/pdf/Ben_Glasner_CV_full.pdf", "_blank");
            },
          },{
            id: "social-email",
            title: "email",
            section: "Profiles",
            handler: () => {
              window.location.href = "mailto:%62%65%6E%6A%61%6D%69%6E@%65%69%67.%6F%72%67";
            },
          },{
            id: "social-scholar",
            title: "Google Scholar",
            section: "Profiles",
            handler: () => {
              window.open("https://scholar.google.com/citations?user=ZvG1rc8AAAAJ", "_blank");
            },
          },{
            id: "social-github",
            title: "GitHub",
            section: "Profiles",
            handler: () => {
              window.open("https://github.com/bnglasner", "_blank");
            },
          },{
            id: "social-linkedin",
            title: "LinkedIn",
            section: "Profiles",
            handler: () => {
              window.open("https://www.linkedin.com/in/bglasner", "_blank");
            },
          },];
