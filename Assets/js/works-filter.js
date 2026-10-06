// Filters the Works list by kind.
//
// Each filter chip carries a `data-work-filter` attribute (`all`, `talk`,
// `article`, `project`) and each card a `data-work-kind` attribute.
// Bootstrap's reboot styles `[hidden]` as `display: none !important`, so
// toggling the attribute is enough to hide cards.
function filterWorks(button) {
    const kind = button.dataset.workFilter ?? 'all';

    document.querySelectorAll('[data-work-kind]').forEach(card => {
        card.hidden = kind !== 'all' && card.dataset.workKind !== kind;
    });

    // Mark the selected button as active within its group.
    button.parentElement.querySelectorAll('.btn').forEach(other => {
        const isSelected = other === button;
        other.classList.toggle('active', isSelected);
        other.setAttribute('aria-pressed', String(isSelected));
    });
}
