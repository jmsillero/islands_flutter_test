import 'dart:math';

import 'package:island_counter_test/cell.dart';
import 'package:island_counter_test/integer_pair.dart';

class Compute {
  int n;
  late List<List<Cell>> cells;
  final Random rand = Random();

  Compute(this.n) {
    generateCells();
  }

  generateCells() {
    cells = List.generate(
        n, (x) => List.generate(n, (y) => Cell(rand.nextInt(2), x, y)));
  }

  computeNumberOfIslands() {
    final positions = [Pair(0, -1), Pair(1, 0), Pair(0, 1), Pair(-1, 0)];
    final queue = [];
    int max = 1;
    for (var x = 0; x < n; x++) {
      for (var y = 0; y < n; y++) {
        var cell = cells[x][y];
        if (cell.value == 1) {
          cell.value = ++max;
          queue.add(cell);
          while (queue.isNotEmpty) {
            var firstElement = queue.removeAt(0);
            for (var pos in positions) {
              var xIndex = firstElement.x + pos.first;
              var yIndex = firstElement.y + pos.second;
              if (xIndex >= 0 && xIndex < n && yIndex >= 0 && yIndex < n) {
                var adjacent = cells[xIndex][yIndex];
                if (adjacent.value == 1) {
                  adjacent.value = max;
                  queue.add(adjacent);
                }
              }
            }
          }
        }
      }
    }
    return max - 1;
  }

  invertCell([Cell? cell]) {
    cells = cells
        .map((x) => x.map((y) {
              if (y.value != 0) {
                y.value = 1;
              }
              return y;
            }).toList())
        .toList();

    if (cell != null) {
      cells[cell.x][cell.y].value = cell.value == 0 ? 1 : 0;
    }

    return computeNumberOfIslands();
  }

  reorder() {
    generateCells();
    return computeNumberOfIslands();
  }

  configure(int n) {
    this.n = n;
    return reorder();
  }
}
