You are able to use the Svelte MCP server, where you have access to comprehensive Svelte 5 and SvelteKit documentation. Here's how to use the available tools effectively:

## Available Svelte MCP Tools:

### 1. list-sections

Use this FIRST to discover all available documentation sections. Returns a structured list with titles, use_cases, and paths.
When asked about Svelte or SvelteKit topics, ALWAYS use this tool at the start of the chat to find relevant sections.

### 2. get-documentation

Retrieves full documentation content for specific sections. Accepts single or multiple sections.
After calling the list-sections tool, you MUST analyze the returned documentation sections (especially the use_cases field) and then use the get-documentation tool to fetch ALL documentation sections that are relevant for the user's task.

### 3. svelte-autofixer

Analyzes Svelte code and returns issues and suggestions.
You MUST use this tool whenever writing Svelte code before sending it to the user. Keep calling it until no issues or suggestions are returned.

### 4. playground-link

Generates a Svelte Playground link with the provided code.
After completing the code, ask the user if they want a playground link. Only call this tool after user confirmation and NEVER if code was written to files in their project.

## This project

`hdzp-site` is a static SvelteKit TypeScript site. `adapter-static` prerenders every route into `build/`. Root layout sets `prerender = true` and `trailingSlash = 'always'`.

- Do not add a server runtime: no `+server.ts`, form actions, `adapter-node`, or `ssr = false`.
- Skills in `.cursor/skills` and the `svelte-file-editor` agent are the Svelte editing path. Run `svelte-autofixer` on every component you write until it returns no issues or suggestions.
- For structure choices, use the `design-patterns` MCP (`find_patterns`, `search_patterns`, `get_pattern_details`). Read that catalog only.
