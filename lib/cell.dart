class Cell {
  int value;

  int x;
  int y;

  Cell(this.value, this.x, this.y);

  @override
  String toString() {
    return 'Cell{value: $value, x: $x, y: $y}';
  }
}
