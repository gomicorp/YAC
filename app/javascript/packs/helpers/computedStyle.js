
export function outerHeight(el) {
  const style = getComputedStyle(el);

  const mt = parseInt(style.marginTop);
  const mb = parseInt(style.marginBottom);
  const bt = parseInt(style.borderTopWidth) || 0;
  const bb = parseInt(style.borderBottomWidth) || 0;

  return innerHeight(el) + mt + mb + bt + bb;
}

export function innerHeight(el) {
  return el.clientHeight;
}
