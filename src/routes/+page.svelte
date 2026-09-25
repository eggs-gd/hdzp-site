<script lang="ts">
	import Yard from '$lib/Yard.svelte';
</script>

<svelte:head>
	<title>humanidzelup</title>
</svelte:head>

<div class="stage">
	<Yard />

	<header>
		<h1>humanidzelup<sup aria-hidden="true">*</sup></h1>
		<p class="note">
			<span class="star" aria-hidden="true">*</span>human in the loop after wrong STT recognition
		</p>
	</header>

	<footer>
		<hr />
		<div class="bar">
			<p>© 2026 HDZP.dev</p>
			<a href="https://firestart.dev">firestart.dev</a>
			<a href="https://fleet.eggs.gd">fleet.eggs.gd</a>
		</div>
	</footer>
</div>

<style>
	.stage {
		position: relative;
		height: 100vh;
		overflow: hidden;
	}

	header {
		position: absolute;
		top: 0;
		left: 0;
		z-index: 8;
		padding: 2.5rem 1.75rem;
		pointer-events: none;
	}

	h1 {
		margin: 0;
		font-family: Palatino, 'Palatino Linotype', 'Iowan Old Style', Georgia, serif;
		font-size: clamp(2.6rem, 7vw, 4.75rem);
		font-weight: 500;
		letter-spacing: -0.03em;
		line-height: 1;
	}

	h1 sup {
		margin-left: 0.12em;
		font-size: 0.42em;
		font-weight: 400;
	}

	.note {
		max-width: 28rem;
		margin: 0.9rem 0 0;
		font-family: Palatino, 'Palatino Linotype', 'Iowan Old Style', Georgia, serif;
		font-size: 1.05rem;
		font-style: italic;
		line-height: 1.45;
		color: #3f3a34;
	}

	.star {
		margin-right: 0.35em;
		font-style: normal;
	}

	footer {
		position: absolute;
		right: 0;
		bottom: 0;
		left: 0;
		z-index: 8;
	}

	hr {
		height: 2px;
		margin: 0;
		border: 0;
		background: #6f655b;
	}

	.bar {
		display: flex;
		flex-wrap: nowrap;
		gap: 1.25rem;
		align-items: baseline;
		justify-content: center;
		padding: 0.7rem 1.25rem 0.85rem;
		background: #c3b59f;
		color: #5c5348;
		font-family: Palatino, 'Palatino Linotype', 'Iowan Old Style', Georgia, serif;
		font-size: 0.9rem;
		line-height: 1.5;
	}

	.bar p {
		margin: 0;
	}

	a {
		color: inherit;
	}
</style>
