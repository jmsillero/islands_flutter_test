import 'dart:math';

import 'package:island_counter_test/coordinate.dart';
import 'package:island_counter_test/integer_pair.dart';

class Compute {
  int n;
  late List<List<int>> cells;
  final Random rand = Random();

  Compute(this.n) {
    generateGrid(true);
  }

  generateGrid([bool isDefault = false]) {
    cells = List.generate(
        n, (x) => List.generate(n, (y) => isDefault ? 0 : rand.nextInt(2)));
  }

  computeNumberOfIslands() {
    final positions = [Pair(0, -1), Pair(1, 0), Pair(0, 1), Pair(-1, 0)];
    final queue = [];
    int max = 1;
    for (var x = 0; x < n; x++) {
      for (var y = 0; y < n; y++) {
        if (cells[x][y] == 1) {
          cells[x][y] = ++max;
          queue.add(Coordinate(x, y));
          while (queue.isNotEmpty) {
            var firstElement = queue.removeAt(0);

            for (var pos in positions) {
              var xIndex = firstElement.x + pos.first;
              var yIndex = firstElement.y + pos.second;

              if (xIndex >= 0 && xIndex < n && yIndex >= 0 && yIndex < n) {
                if (cells[xIndex][yIndex] == 1) {
                  cells[xIndex][yIndex] = max;
                  queue.add(Coordinate(xIndex, yIndex));
                }
              }
            }
          }
        }
      }
    }
    return max - 1;
  }

  invertCell([Coordinate? coordinate]) {
    cells = cells
        .map((x) => x.map((y) {
              if (y != 0) {
                y = 1;
              }
              return y;
            }).toList())
        .toList();

    if (coordinate != null) {
      cells[coordinate.x][coordinate.y] =
          cells[coordinate.x][coordinate.y] == 0 ? 1 : 0;
    }

    return computeNumberOfIslands();
  }

  reorder() {
    generateGrid();
    return computeNumberOfIslands();
  }

  configure(int n) {
    this.n = n;
    return reorder();
  }
}
