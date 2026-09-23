const ninja = document.querySelector("ninja-keys");

ninja.data = [{
    id: "nav-home",
    title: "Home",
    section: "Navigation",
    handler: () => {
      window.location.href = "/";
    },
  },{id: "nav-research",
        title: "Research",
        description: "Peer-reviewed articles, working papers, policy reports, and thesis research, grouped by research agenda.",
        section: "Navigation",
        handler: () => {
          window.location.href = "/publications/";
        },
      },{id: "nav-policy",
        title: "Policy",
        description: "Three policy designs I work on — Opportunity Zones, the Retirement Savings for Americans Act, and the 80-80 wage subsidy — plus my reports and analyses.",
        section: "Navigation",
        handler: () => {
          window.location.href = "/policy/";
        },
      },{id: "nav-writing",
        title: "Writing",
        description: "Essays and commentary on Agglomerations and in outside publications.",
        section: "Navigation",
        handler: () => {
          window.location.href = "/writing/";
        },
      },{id: "nav-media",
        title: "Media",
        description: "Interviews, broadcast and podcast appearances, press quotes, and selected coverage of my research.",
        section: "Navigation",
        handler: () => {
          window.location.href = "/media/";
        },
      },{id: "nav-cv",
        title: "CV",
        description: "Education, employment, publications, and media. One-page, two-page, and full PDF versions are below.",
        section: "Navigation",
        handler: () => {
          window.location.href = "/cv/";
        },
      },{
      id: "report-the-u-s-retirement-system-fast-facts",
      title: "The U.S. Retirement System: Fast Facts",
      description: "About 76 million workers — nearly 52 percent of working Americans ages 18 to 64 — lack access to an employer-provided retirement plan, and only 37 percent of workers receive an employer contribution or match.",
      section: "Reports",
      handler: () => {
        window.open("https://eig.org/retirement-fast-facts/", "_blank");
      },
    },{
      id: "report-how-to-end-low-wage-work-forever-an-80-80-wage-subsidy-proposal",
      title: "How to end low-wage work forever: An 80-80 wage subsidy proposal",
      description: "The 80-80 proposal would subsidize low-wage paychecks directly, raising take-home pay without adding to employers&#39; cost of hiring.",
      section: "Reports",
      handler: () => {
        window.open("https://eig.org/how-to-end-low-wage-work-forever/", "_blank");
      },
    },{
      id: "report-are-opportunity-zones-helping-high-need-communities-eig-responds-to-new-york-times-op-ed",
      title: "Are Opportunity Zones Helping High-Need Communities? EIG Responds to New York Times Op-Ed...",
      description: "A response to Corinth and Feldman&#39;s New York Times op-ed arguing that the evidence now shows Opportunity Zones drove investment into low-income communities, and that the critics&#39; revised case against the policy does not hold.",
      section: "Reports",
      handler: () => {
        window.open("https://eig.org/eig-responds-to-nyt-op-ed/", "_blank");
      },
    },{
      id: "report-the-impact-of-opportunity-zones-on-housing-supply",
      title: "The Impact of Opportunity Zones on Housing Supply",
      description: "Opportunity Zone designation increased new housing construction by 70 percent in designated tracts, adding more than 416,000 residential addresses with little displacement from nearby areas.",
      section: "Reports",
      handler: () => {
        window.open("https://eig.org/opportunity-zones-housing-supply/", "_blank");
      },
    },{
      id: "report-the-great-transfer-mation-how-american-communities-became-reliant-on-income-from-government",
      title: "The Great &quot;Transfer&quot;-mation: How American Communities Became Reliant on Income from Government",
      description: "Government transfers grew from 8 percent of personal income in 1970 to almost 18 percent by 2022, leaving roughly half of U.S. counties substantially reliant on transfer income.",
      section: "Reports",
      handler: () => {
        window.open("https://eig.org/great-transfermation/", "_blank");
      },
    },{
      id: "report-the-american-worker-project-toward-a-new-consensus",
      title: "The American Worker Project: Toward a New Consensus",
      description: "American workers are more prosperous than prior generations by most measures, but the pace of improvement has slowed, and public perception often lags the underlying data.",
      section: "Reports",
      handler: () => {
        window.open("https://eig.org/american-worker/", "_blank");
      },
    },{
      id: "report-living-the-good-life-or-getting-a-bad-deal",
      title: "Living the good life or getting a bad deal?",
      description: "Combining EPI&#39;s Family Budget Calculator with EIG&#39;s Distressed Communities Index to assess which U.S. communities offer families a good value proposition on cost of living versus well-being.",
      section: "Reports",
      handler: () => {
        window.open("https://eig.org/dci-cost-of-living/", "_blank");
      },
    },{
      id: "report-evaluating-the-trade-offs-children-s-well-being-vs-parents-work-incentives",
      title: "Evaluating the Trade-offs: Children&#39;s Well-being vs. Parents&#39; Work Incentives",
      description: "The history, goals, and trade-offs of the Child Tax Credit — anti-poverty tool versus tax relief for working parents — as the Tax Relief for American Families and Workers Act of 2024 heads to the Senate.",
      section: "Reports",
      handler: () => {
        window.open("https://eig.org/evaluating-the-child-tax-credit/", "_blank");
      },
    },{
      id: "report-full-vs-hybrid-examining-the-consequences-of-how-americans-work-remotely",
      title: "Full vs. Hybrid: Examining the Consequences of How Americans Work Remotely",
      description: "Full-remote work raises long-distance migration and destination-market housing prices, while hybrid work enables shorter moves without the same price effect.",
      section: "Reports",
      handler: () => {
        window.open("https://eig.org/full-vs-hybrid-remote-work/", "_blank");
      },
    },{
      id: "report-movers-and-money-mapping-the-flow-of-income-during-the-pandemic",
      title: "Movers And Money: Mapping the Flow of Income During the Pandemic",
      description: "An interactive tool tracing the origins and destinations of pandemic-era movers&#39; taxable income, led by Manhattan&#39;s $16.5 billion in outflows and Florida&#39;s $39 billion net gain.",
      section: "Reports",
      handler: () => {
        window.open("https://eig.org/interactive-income-flows/", "_blank");
      },
    },{
      id: "report-are-opportunity-zones-working-what-the-literature-tells-us",
      title: "Are Opportunity Zones Working? What the Literature Tells Us",
      description: "Studies that wait long enough to observe Opportunity Zones under fully finalized regulations find the strongest positive investment effects; many widely cited early studies end their analysis window too soon to detect them.",
      section: "Reports",
      handler: () => {
        window.open("https://eig.org/opportunity-zones-research-brief/", "_blank");
      },
    },{
      id: "report-how-much-does-retirement-plan-coverage-vary-by-state-and-income-an-updated-look",
      title: "How Much Does Retirement Plan Coverage Vary by State and Income? An Updated...",
      description: "In 2021, 69 million workers — 55.5 percent — lacked any employer-provided retirement plan, a gap concentrated among low-income earners and uneven across states.",
      section: "Reports",
      handler: () => {
        window.open("https://eig.org/state-retirement-coverage-2023/", "_blank");
      },
    },{
      id: "report-liquid-assets-financial-shocks-and-entrances-into-material-hardship",
      title: "Liquid Assets, Financial Shocks, and Entrances into Material Hardship",
      description: "New Yorkers with $2,000 in liquid assets are substantially less likely to fall into material hardship after a financial shock than those with none, and the protective effect levels off above that amount.",
      section: "Reports",
      handler: () => {
        window.open("https://robinhood.org/wp-content/uploads/2024/01/poverty-tracker_2023.08_spotlight-on-liquid-assets-financial-shocks-and-entrances-into-material-hardship.pdf", "_blank");
      },
    },{
      id: "report-business-establishments-bloom-in-booming-georgia",
      title: "Business Establishments Bloom in Booming Georgia",
      description: "County-level QCEW data for the fourth quarter of 2022 show the post-pandemic surge in new business establishments persisting, with Georgia among the standout states.",
      section: "Reports",
      handler: () => {
        window.open("https://eig.org/georgia-business-establishments/", "_blank");
      },
    },{
      id: "report-gao-report-underscores-excessive-use-of-noncompetes",
      title: "GAO Report Underscores Excessive Use of Noncompetes",
      description: "The GAO&#39;s report on noncompete agreements underscores their excessive and relatively indiscriminate use, including heavier use by large employers and little differentiation across classes of workers.",
      section: "Reports",
      handler: () => {
        window.open("https://eig.org/gao-noncompetes/", "_blank");
      },
    },{
      id: "report-the-effects-of-noncompete-agreement-reforms-on-business-formation-a-comparison-of-hawaii-and-oregon",
      title: "The Effects of Noncompete Agreement Reforms on Business Formation: A Comparison of Hawaii...",
      description: "Hawaii&#39;s noncompete exemption for technology workers was associated with 10 percent more technology establishments, while Oregon&#39;s broader low-wage-worker reform showed no significant effect.",
      section: "Reports",
      handler: () => {
        window.open("https://eig.org/noncompetes-research-note/", "_blank");
      },
    },{
      id: "writing-the-babysitter-clause-and-the-problem-of-partial-noncompete-bans",
      title: "The Babysitter Clause and the Problem of Partial Noncompete Bans",
      description: "Partial noncompete bans that carve out workers by income, occupation, or industry — down to Washington, D.C.&#39;s exemption for casual babysitters — end up arbitrary, confusing, and hard to enforce, which makes the case for full bans.",
      section: "Writing",
      handler: () => {
        window.open("https://agglomerations.eig.org/p/the-babysitter-clause-and-the-problem", "_blank");
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
      description: "An interactive tour of the county-level transfer dependence behind the Great &quot;Transfer&quot;-mation report.",
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
