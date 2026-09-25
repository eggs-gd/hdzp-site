# hdzp-site

Static site on SvelteKit and TypeScript. Production output is prerendered HTML in `build/`.

```sh
npm install
npm run dev
npm run check
npm run build
```

Push to `main` publishes the site with GitHub Actions. In the repository settings, set Pages to deploy from GitHub Actions.

Agent setup lives in `AGENTS.md`, `.cursor/rules`, and `.cursor/mcp.json` (`svelte`, `design-patterns`).
