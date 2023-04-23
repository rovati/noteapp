class NotesOrder {
  final List<int> ordering;

  NotesOrder() : ordering = [-2];

  NotesOrder.fromString(String encoded) : ordering = elaborateString(encoded);

  static List<int> elaborateString(String encoded) {
    List<String> list = encoded.split(';');
    return list.map((e) => int.parse(e)).toList();
  }

  @override
  String toString() {
    String s = ordering[0].toString();
    for (int i = 1; i < ordering.length; i++) {
      s += ';${ordering[i]}';
    }
    return s;
  }

  void append(int id) {
    removePlaceHolder();
    ordering.add(id);
  }

  void insertAt(int id, int idx) {
    removePlaceHolder();
    ordering.insert(idx, id);
  }

  void moveTo(int id, int idx) {
    ordering.remove(id);
    ordering.insert(idx, id);
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
    if (ordering.isEmpty) {
      append(-2);
    }
  }
}
