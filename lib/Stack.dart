class myStack {
  final List<num> _numList = [];

  peek() {
    return _numList.last;
  }

  length() {
    return _numList.length;
  }

  pop() {
    num popped = _numList.last;
    _numList.remove(popped);
    return popped;
  }

  push(num value) {
    _numList.add(value);
  }

  Iterable<num> getStack() {
    return _numList;
  }

  clear(){
    _numList.clear();
  }

}
