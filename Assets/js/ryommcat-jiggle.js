// Squash-and-stretch keyframes that make an element wobble like a slime.
// The element is expected to have `transform-origin: 50% 100%` so it looks
// like it's sitting on the ground. Called from the ryommcat image's onclick.
function ryommcatJiggle(element) {
    // Cancel any in-flight animation so rapid clicks restart cleanly.
    element.getAnimations().forEach(animation => animation.cancel());

    element.animate([
        { transform: 'scale3d(1, 1, 1)' },
        { transform: 'scale3d(1.25, 0.75, 1)', offset: 0.2 },
        { transform: 'scale3d(0.8, 1.2, 1)', offset: 0.4 },
        { transform: 'scale3d(1.12, 0.9, 1)', offset: 0.6 },
        { transform: 'scale3d(0.95, 1.05, 1)', offset: 0.8 },
        { transform: 'scale3d(1, 1, 1)' }
    ], {
        duration: 800,
        easing: 'ease-in-out'
    });
}
