/// 注意：这个组合函数是先调用后面的函数
Function compose(List<Function> fns) {
  return (w) {
    for (Function fn in fns.reversed) {
      w = fn(w);
    }
    return w;
  };
}
