<script lang="ts">
	import travolta from '$lib/assets/travolta.png';
	import monitor from '$lib/assets/monitor.png';

	const BOTS = 5;
	const BOT_W = 78;
	const BOT_H = 74;

	const pilePlan = [
		{ fx: 0.12, fy: 0.46, n: 6 },
		{ fx: 0.86, fy: 0.38, n: 5 },
		{ fx: 0.16, fy: 0.8, n: 7 },
		{ fx: 0.84, fy: 0.76, n: 5 },
		{ fx: 0.58, fy: 0.18, n: 4 }
	];

	const bitOffsets = [
		[-16, 2],
		[4, 8],
		[-4, -10],
		[16, 0],
		[-18, 12],
		[10, -8],
		[0, 14],
		[20, 12]
	];
	const bitColors = ['#8d6b45', '#6d7a52', '#8f4d4d', '#4f6574', '#b08958', '#5c5348'];

	type Pile = { fx: number; fy: number; n: number };
	type Bot = { x: number; y: number; dest: number; carrying: boolean; facing: number; bob: number };

	let piles = $state<Pile[]>(pilePlan.map((pile) => ({ ...pile })));
	let bots = $state<Bot[]>([]);
	let heroFlip = $state(1);
	let floorNow = $state(64);
	let viewW = $state(0);
	let viewH = $state(0);

	function place(pile: Pile, w: number, h: number) {
		const playH = Math.max(160, h - floorNow - 8);
		return {
			x: 36 + pile.fx * (w - 100),
			y: 28 + pile.fy * (playH - 70)
		};
	}

	function otherPile(index: number) {
		let next = Math.floor(Math.random() * (piles.length - 1));
		if (next >= index) next += 1;
		return next;
	}

	function arrive(bot: Bot) {
		const here = bot.dest;
		if (bot.carrying) {
			piles[here].n += 1;
			bot.carrying = false;
			bot.dest = otherPile(here);
			return;
		}
		if (piles[here].n > 0) {
			piles[here].n -= 1;
			bot.carrying = true;
			bot.dest = otherPile(here);
			return;
		}
		const loaded = piles.findIndex((pile, index) => index !== here && pile.n > 0);
		bot.dest = loaded === -1 ? otherPile(here) : loaded;
	}

	function step(world: HTMLDivElement, dt: number) {
		const w = world.clientWidth;
		const h = world.clientHeight;
		floorNow = world.parentElement?.querySelector('footer')?.offsetHeight ?? floorNow;
		if (w < 40 || h < 40) return;
		viewW = w;
		viewH = h;

		if (bots.length === 0) {
			bots = Array.from({ length: BOTS }, (_, index) => {
				const at = place(piles[index % piles.length], w, h);
				return {
					x: at.x - BOT_W / 2,
					y: at.y - BOT_H / 2,
					dest: (index + 1) % piles.length,
					carrying: index % 2 === 0,
					facing: 1,
					bob: index
				};
			});
			for (let index = 0; index < bots.length; index += 1) {
				if (bots[index].carrying && piles[index % piles.length].n > 0) {
					piles[index % piles.length].n -= 1;
				}
			}
		}

		for (const bot of bots) {
			const target = place(piles[bot.dest], w, h);
			const dx = target.x - BOT_W / 2 - bot.x;
			const dy = target.y - BOT_H / 2 - bot.y;
			const dist = Math.hypot(dx, dy);
			const stride = 170 * dt;
			if (dist <= Math.max(6, stride)) {
				bot.x = target.x - BOT_W / 2;
				bot.y = target.y - BOT_H / 2;
				arrive(bot);
			} else {
				bot.x += (dx / dist) * stride;
				bot.y += (dy / dist) * stride;
				if (Math.abs(dx) > 1) bot.facing = dx < 0 ? -1 : 1;
			}
			bot.bob += dt * 14;
		}
	}

	function play(node: HTMLDivElement) {
		floorNow = node.parentElement?.querySelector('footer')?.offsetHeight || floorNow;
		let frame = 0;
		let last = performance.now();
		const loop = (now: number) => {
			const dt = Math.min(0.05, (now - last) / 1000);
			last = now;
			step(node, dt);
			frame = requestAnimationFrame(loop);
		};
		frame = requestAnimationFrame(loop);
		const flipTimer = setInterval(() => {
			heroFlip = -heroFlip;
		}, 3000);
		return () => {
			cancelAnimationFrame(frame);
			clearInterval(flipTimer);
		};
	}
</script>

<div class="world" {@attach play}>
	{#each piles as pile, pileIndex (pileIndex)}
		{@const at = place(pile, viewW, viewH)}
		<div class="pile" style:left="{at.x}px" style:top="{at.y}px">
			{#each Array.from({ length: Math.min(pile.n, 8) }, (_, index) => index) as bit (bit)}
				<span
					class="bit"
					style:left="{bitOffsets[bit][0]}px"
					style:top="{bitOffsets[bit][1]}px"
					style:background={bitColors[(bit + pileIndex) % bitColors.length]}
					style:rotate="{bit * 17 - 20}deg"
				></span>
			{/each}
		</div>
	{/each}

	{#each bots as bot, index (index)}
		<img
			class="bot"
			src={monitor}
			alt=""
			draggable="false"
			style:left="{bot.x}px"
			style:top="{bot.y + Math.sin(bot.bob) * 3}px"
			style:scale="{bot.facing} 1"
			style:z-index={bot.y > viewH * 0.58 ? 6 : 2}
		/>
		{#if bot.carrying}
			<span
				class="bit carried"
				style:left="{bot.x + 46}px"
				style:top="{bot.y - 4 + Math.sin(bot.bob) * 3}px"
				style:background={bitColors[index % bitColors.length]}
				style:z-index={bot.y > viewH * 0.58 ? 7 : 3}
			></span>
		{/if}
	{/each}

	<img
		class="hero"
		src={travolta}
		alt=""
		draggable="false"
		style:bottom="{floorNow}px"
		style:scale="{heroFlip} 1"
	/>
</div>

<style>
	.world {
		position: absolute;
		inset: 0;
		overflow: hidden;
		pointer-events: none;
	}

	.hero {
		position: absolute;
		left: 50%;
		z-index: 4;
		height: min(62vh, 540px);
		width: auto;
		translate: -50% 0;
		transform-origin: center bottom;
	}

	.bot {
		position: absolute;
		width: 78px;
		height: auto;
		transform-origin: center center;
	}

	.pile {
		position: absolute;
		z-index: 1;
		width: 0;
		height: 0;
	}

	.bit {
		position: absolute;
		width: 16px;
		height: 11px;
		border: 1px solid #2a241c;
	}

	.bit.carried {
		width: 14px;
		height: 10px;
	}
</style>
