Function compose(List<Function> fns) {
  return (w) {
    for (Function fn in fns) {
      w = fn(w);
    }
    return w;
  };
}
