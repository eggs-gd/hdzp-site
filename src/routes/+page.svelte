<svelte:head>
	<title>humanidzelup</title>
</svelte:head>

<main>
	<h1>humanidzelup<sup aria-hidden="true">*</sup></h1>
	<p class="note">
		<span class="star" aria-hidden="true">*</span>human in the loop after wrong STT recognition
	</p>
</main>

<style>
	main {
		box-sizing: border-box;
		min-height: 100vh;
		padding: 33.333vh 1.5rem 3rem;
		text-align: center;
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
		margin: 0.9rem auto 0;
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
</style>
