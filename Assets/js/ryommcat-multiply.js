const RYOMMCAT_MAX_COUNT = 4;
const RYOMMCAT_POP_DELAY = 500;
const RYOMMCAT_DROP_HEIGHT = 16;

// Called from the footer ryommcat image's onclick. Jiggles every cat in the
// container and, as long as we haven't hit the limit, spawns a clone next to
// the clicked one. Once the limit is reached, every cat pops like a slime
// shortly after.
function ryommcatClick(element) {
    const container = element.parentElement;
    if (!container) {
        return;
    }

    const catsBefore = container.querySelectorAll('img');
    if (catsBefore.length >= RYOMMCAT_MAX_COUNT) {
        return;
    }

    container.appendChild(element.cloneNode(true));

    const cats = container.querySelectorAll('img');
    cats.forEach(cat => ryommcatJiggle(cat));

    if (cats.length >= RYOMMCAT_MAX_COUNT) {
        setTimeout(() => ryommcatPop(container), RYOMMCAT_POP_DELAY);
    }
}

// Pops every cat in the container like a bursting slime, staggered slightly
// per cat, then removes the clones and resets the original to its idle state.
function ryommcatPop(container) {
    const cats = Array.from(container.querySelectorAll('img'));
    const popDuration = 450;
    const stagger = 70;

    cats.forEach((cat, index) => {
        cat.getAnimations().forEach(animation => animation.cancel());

        cat.animate([
            { transform: 'scale3d(1, 1, 1)', opacity: 1 },
            { transform: 'scale3d(1.35, 0.65, 1)', opacity: 1, offset: 0.35 },
            { transform: 'scale3d(0.1, 1.5, 1)', opacity: 0.6, offset: 0.7 },
            { transform: 'scale3d(0, 0, 1)', opacity: 0 }
        ], {
            duration: popDuration,
            delay: index * stagger,
            easing: 'ease-in',
            fill: 'forwards'
        });
    });

    const totalDuration = popDuration + (cats.length - 1) * stagger;
    setTimeout(() => {
        cats.slice(1).forEach(cat => cat.remove());
        const [first] = cats;
        if (first) {
            first.getAnimations().forEach(animation => animation.cancel());

            // Drop back in from slightly above, landing straight into the
            // jiggle keyframes with no gap between the two animations.
            const fallDuration = 150;
            const totalDuration = fallDuration + RYOMMCAT_JIGGLE_DURATION;
            const fallEnd = fallDuration / totalDuration;
            const remap = offset => fallEnd + offset * (1 - fallEnd);

            first.animate([
                { transform: `translateY(-${RYOMMCAT_DROP_HEIGHT}px) scale3d(1, 1, 1)`, opacity: 0, offset: 0 },
                { transform: `translateY(-${RYOMMCAT_DROP_HEIGHT}px) scale3d(1, 1, 1)`, opacity: 1, offset: 0.02, easing: 'ease-in' },
                ...RYOMMCAT_JIGGLE_KEYFRAMES.map(frame => ({
                    ...frame,
                    transform: `translateY(0) ${frame.transform}`,
                    opacity: 1,
                    offset: remap(frame.offset)
                }))
            ], {
                duration: totalDuration,
                easing: 'ease-in-out'
            });
        }
    }, totalDuration + 50);
}
