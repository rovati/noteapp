class Ordering {
  final List<int> ordering;

  Ordering() : ordering = [-2];

  Ordering.fromString(String encoded) : ordering = elaborateString(encoded);

  static List<int> elaborateString(String encoded) {
    List<String> list = encoded.split(';');
    return list.map((e) => int.parse(e)).toList();
  }

  @override
  String toString() {
    String s = ordering[0].toString();
    for (int i = 1; i < ordering.length; i++) {
      s += ';' + ordering[i].toString();
    }
    return s;
  }

  void prepend(int id) {
    removePlaceHolder();
    ordering.insert(0, id);
  }

  void append(int id) {
    removePlaceHolder();
    ordering.add(id);
  }

  void bump(int id) {
    ordering.remove(id);
    prepend(id);
  }

  void remove(id) {
    ordering.remove(id);
    addPlaceHolder();
  }

  void removeAt(int idx) {
    ordering.removeAt(idx);
    addPlaceHolder();
  }

  int idAt(int idx) => ordering[idx];

  int get length => ordering.length;

  void removePlaceHolder() {
    if (ordering.length == 1 && ordering[0] == -2) {
      ordering.clear();
    }
  }

  void addPlaceHolder() {
    if (ordering.length == 0) {
      append(-2);
    }
  }
}
