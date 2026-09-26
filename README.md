# Bridge to Purpose

Static portfolio and documentation site by [Muddassir Iqbal](https://github.com/iqbalmuddassir). A hub linking to featured projects—digital marketing guides, Islamic app documentation, business courses, and internal concept work—built with vanilla HTML, CSS, and JavaScript.

**Live site:** [https://iqbalmuddassir.github.io/](https://iqbalmuddassir.github.io/)

## Projects

### Public

| Project | Description |
|---------|-------------|
| [Digital Marketing AI](https://iqbalmuddassir.github.io/digital-marketing-ai/) | 3-month freelancer roadmap for AI-assisted digital marketing |
| [Quran Kit](https://iqbalmuddassir.github.io/quran-kit-app/) | App documentation: recitations, translations, AI Halal checking, prayer tools (live on Google Play and the App Store) |
| [Local Lead Gen Agency](https://iqbalmuddassir.github.io/local-lead-gen-agency/) | 14-module self-study course for building a local lead gen agency in India |
| [Margin](https://iqbalmuddassir.github.io/margin/) | On-device photo culling for iPhone and iPad, live on the App Store |
| [Engineering Leadership Portfolio](https://iqbalmuddassir.github.io/grab-sem-portfolio/) | Public career portfolio: mobile engineering and consumer maps leadership at Grab |

### Internal

These pages are deployed but hidden from the default hub.

| Project | Description |
|---------|-------------|
| [Minimal Family House](https://iqbalmuddassir.github.io/minimal-family-house/) | Trapezoid-plot concept plans — garden, patio, parking, rooftop BBQ, two-storey family home |
| [Amanah India](https://iqbalmuddassir.github.io/amanah-india/) | Internal summary for an Islamic e-commerce marketplace |

## Repository structure

All site content lives under `docs/`:

```
docs/
├── index.html                          # Portfolio landing page
├── digital-marketing-ai/index.html
├── quran-kit-app/
│   ├── index.html
│   ├── terms_and_conditions.html
│   ├── android/                        # Android marketing / Play Store page
│   └── ios/                            # iOS App Store page + redesign gallery
│       ├── islamic-swiftui-redesign.html
│       └── assets/
├── quran-education-app/                # Redirects to quran-kit-app/
├── local-lead-gen-agency/index.html
├── minimal-family-house/               # Internal
│   ├── index.html
│   └── assets/
├── amanah-india/index.html             # Internal
└── grab-sem-portfolio/index.html       # Public career portfolio
```

## Local development

No build step or package manager is required. Open any HTML file in a browser, or serve the `docs/` folder locally:

```bash
cd docs && python3 -m http.server 8000
```

Then visit [http://localhost:8000](http://localhost:8000).

## Deployment

Pushes to `main` trigger the GitHub Actions workflow (`.github/workflows/digi-mar-ai-workflow.yml`), which deploys the `docs/` directory to GitHub Pages. No manual deploy step is needed.

## Git

This repository keeps a **linear** history on `main`. Integrate with rebase or squash only — no merge commits.

## Tech stack

- **HTML, CSS, JavaScript** — no frameworks or bundlers
- **Theming** — dark/light mode via CSS custom properties; preference stored in `localStorage`
- **Typography** — Space Grotesk on the hub and most studio pages; Quran Kit uses Outfit + Cormorant Garamond

Each page is self-contained with inline styles and scripts.

## License

© Muddassir Iqbal. All rights reserved.
