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
      },{id: "nav-media",
        title: "media",
        description: "Podcast appearances, broadcast and print coverage, and policy-advisory work.",
        section: "Navigation",
        handler: () => {
          window.location.href = "/media/";
        },
      },{id: "nav-code-data",
        title: "code + data",
        description: "The five most recently updated repositories on the EIG-Research GitHub organization, where my code and data products live.",
        section: "Navigation",
        handler: () => {
          window.location.href = "/repositories/";
        },
      },{id: "nav-policy",
        title: "policy",
        description: "Active policy work on Opportunity Zones, the Retirement Savings for Americans Act, and the 80-80 wage subsidy proposal.",
        section: "Navigation",
        handler: () => {
          window.location.href = "/policy/";
        },
      },{
      id: "report-how-to-end-low-wage-work-forever-an-80-80-wage-subsidy-proposal",
      title: "How to end low-wage work forever: An 80-80 wage subsidy proposal",
      description: "A large, targeted wage subsidy designed to raise earnings and strengthen labor-market attachment for low-wage workers.",
      section: "Reports",
      handler: () => {
        window.open("https://eig.org/how-to-end-low-wage-work-forever/", "_blank");
      },
    },{
      id: "report-the-impact-of-opportunity-zones-on-housing-supply",
      title: "The Impact of Opportunity Zones on Housing Supply",
      description: "Evidence that Opportunity Zones increased residential development and housing supply in designated communities.",
      section: "Reports",
      handler: () => {
        window.open("https://eig.org/opportunity-zones-housing-supply/", "_blank");
      },
    },{
      id: "report-the-great-transfer-mation-how-american-communities-became-reliant-on-income-from-government",
      title: "The Great &quot;Transfer&quot;-mation: How American Communities Became Reliant on Income from Government",
      description: "How transfer income has grown across U.S. communities and reshaped the foundations of local economies.",
      section: "Reports",
      handler: () => {
        window.open("https://eig.org/great-transfermation/", "_blank");
      },
    },{
      id: "report-the-american-worker-project-toward-a-new-consensus",
      title: "The American Worker Project: Toward a New Consensus",
      description: "A worker-centered economic policy agenda grounded in labor-market dynamism, mobility, and earnings growth.",
      section: "Reports",
      handler: () => {
        window.open("https://eig.org/american-worker/", "_blank");
      },
    },{
      id: "report-full-vs-hybrid-examining-the-consequences-of-how-americans-work-remotely",
      title: "Full vs. Hybrid: Examining the Consequences of How Americans Work Remotely",
      description: "Why full-remote and hybrid arrangements have substantively different consequences for local labor markets.",
      section: "Reports",
      handler: () => {
        window.open("https://eig.org/full-vs-hybrid-remote-work/", "_blank");
      },
    },{
      id: "report-are-opportunity-zones-working-what-the-literature-tells-us",
      title: "Are Opportunity Zones Working? What the Literature Tells Us",
      description: "A synthesis of the empirical literature on Opportunity Zones and what the early evidence says about program effects.",
      section: "Reports",
      handler: () => {
        window.open("https://eig.org/are-opportunity-zones-working/", "_blank");
      },
    },{
      id: "report-the-effects-of-noncompete-agreement-reforms-on-business-formation-a-comparison-of-hawaii-and-oregon",
      title: "The Effects of Noncompete Agreement Reforms on Business Formation: A Comparison of Hawaii...",
      description: "A research note comparing business-formation outcomes after noncompete reforms in Hawaii and Oregon.",
      section: "Reports",
      handler: () => {
        window.open("https://eig.org/noncompetes-research-note/", "_blank");
      },
    },{
      id: "working-paper-the-effectiveness-of-the-food-stamp-program-at-reducing-racial-differences-in-the-intergenerational-persistence-of-poverty",
      title: "The Effectiveness of the Food Stamp Program at Reducing Racial Differences in the...",
      description: "How SNAP participation shaped intergenerational mobility and racial inequality in long-run poverty outcomes.",
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
      id: "writing-fixing-the-u-s-retirement-system-a-q-a",
      title: "Fixing the U.S. Retirement System: A Q&amp;A",
      description: "A Q&amp;A on the coverage gap, auto-enrollment, and the design choices behind the Retirement Savings for Americans Act.",
      section: "Writing",
      handler: () => {
        window.open("https://agglomerations.eig.org/p/fixing-the-us-retirement-system-a", "_blank");
      },
    },{
      id: "writing-how-to-end-low-wage-work-forever-part-2-the-faq",
      title: "How to end low-wage work forever, Part 2: the FAQ",
      description: "Common objections to the 80-80 wage subsidy, addressed: incidence, take-up, fiscal cost, and interactions with the safety net.",
      section: "Writing",
      handler: () => {
        window.open("https://agglomerations.eig.org/p/how-to-end-low-wage-work-forever-4a4", "_blank");
      },
    },{
      id: "writing-the-jobs-chart-that-really-has-us-worried",
      title: "The jobs chart that really has us worried",
      description: "Reading labor-market slack through involuntary part-time work, and what it signals about worker bargaining power.",
      section: "Writing",
      handler: () => {
        window.open("https://agglomerations.eig.org/p/the-jobs-chart-that-really-has-us", "_blank");
      },
    },{
      id: "writing-how-many-manufacturing-workers-are-there",
      title: "How many manufacturing workers are there?",
      description: "What counts as a manufacturing worker, and why the number depends on which definition you use.",
      section: "Writing",
      handler: () => {
        window.open("https://agglomerations.eig.org/p/how-many-manufacturing-workers-are", "_blank");
      },
    },{
      id: "writing-where-any-snap-lapse-will-bite-hardest",
      title: "Where any SNAP lapse will bite hardest",
      description: "Which communities would feel the sharpest effects of any interruption in SNAP support.",
      section: "Writing",
      handler: () => {
        window.open("https://agglomerations.eig.org/p/where-any-snap-lapse-will-bite-hardest", "_blank");
      },
    },{
      id: "writing-fat-bear-week-and-the-fate-of-the-world",
      title: "Fat Bear Week and the Fate of the World",
      description: "AI, productivity, and the human-judgment problems that policy still has to solve.",
      section: "Writing",
      handler: () => {
        window.open("https://agglomerations.eig.org/p/fat-bear-week-and-the-fate-of-the", "_blank");
      },
    },{
      id: "writing-abundance-the-missing-piece",
      title: "Abundance: the Missing Piece",
      description: "Supply, implementation, and what abundance arguments need to say about institutions.",
      section: "Writing",
      handler: () => {
        window.open("https://agglomerations.eig.org/p/abundance-the-missing-piece", "_blank");
      },
    },{
      id: "writing-how-to-end-low-wage-work-forever",
      title: "How to end low-wage work forever",
      description: "A public-facing introduction to the 80-80 wage subsidy proposal and the labor-market problem it is designed to solve.",
      section: "Writing",
      handler: () => {
        window.open("https://agglomerations.eig.org/p/how-to-end-low-wage-work-forever", "_blank");
      },
    },{
      id: "writing-tariffs-and-manufacturing-jobs-three-big-problems",
      title: "Tariffs and Manufacturing Jobs: Three Big Problems",
      description: "Three problems with the standard claim that tariffs bring back durable manufacturing jobs.",
      section: "Writing",
      handler: () => {
        window.open("https://agglomerations.eig.org/p/tariffs-and-manufacturing-jobs-three", "_blank");
      },
    },{
      id: "writing-opportunity-zones-a-quiet-revolution-in-housing-policy",
      title: "Opportunity Zones: A Quiet Revolution in Housing Policy",
      description: "Connecting new evidence on Opportunity Zones to broader housing-supply debates.",
      section: "Writing",
      handler: () => {
        window.open("https://agglomerations.eig.org/p/opportunity-zones-a-quiet-revolution", "_blank");
      },
    },{
      id: "writing-transfers-deficits-and-your-community-how-will-you-know",
      title: "Transfers, deficits, and your community: How will you know?",
      description: "An interactive tour of the county-level transfer dependence behind the Great Transfer-mation report.",
      section: "Writing",
      handler: () => {
        window.open("https://agglomerations.eig.org/p/transfers-deficits-and-your-community", "_blank");
      },
    },{
      id: "writing-no-we-are-not-producing-too-many-stem-graduates",
      title: "No, we are not producing too many STEM graduates",
      description: "Why the argument that the U.S. has oversupplied STEM labor does not hold up.",
      section: "Writing",
      handler: () => {
        window.open("https://agglomerations.eig.org/p/no-we-are-not-producing-too-many", "_blank");
      },
    },{
      id: "writing-the-economic-geography-of-the-2024-elections",
      title: "The economic geography of the 2024 elections",
      description: "Mapping the 2024 results onto county-level economic conditions and demographic change.",
      section: "Writing",
      handler: () => {
        window.open("https://agglomerations.eig.org/p/the-economic-geography-of-the-2024", "_blank");
      },
    },{
      id: "writing-an-inflation-puzzle-of-the-2024-election",
      title: "An inflation puzzle of the 2024 election",
      description: "Why post-2021 inflation hit voters harder than headline indicators suggested.",
      section: "Writing",
      handler: () => {
        window.open("https://agglomerations.eig.org/p/inflation-puzzle-election", "_blank");
      },
    },{
      id: "writing-who-s-left-out-of-america-s-retirement-savings-system",
      title: "Who&#39;s left out of America&#39;s retirement savings system?",
      description: "Who falls outside the U.S. retirement savings system, and what the coverage gap looks like by income, employer size, and worker classification.",
      section: "Writing",
      handler: () => {
        window.open("https://agglomerations.eig.org/p/whos-left-out-of-americas-retirement", "_blank");
      },
    },{
    id: "repo-eig-research",
    title: "EIG-Research on GitHub",
    description: "All code and data I write or collaborate on through work is published on the EIG-Research GitHub organization.",
    section: "Code + Data",
    handler: () => {
      window.open("https://github.com/EIG-Research", "_blank");
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
