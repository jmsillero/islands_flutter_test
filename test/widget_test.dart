// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:island_counter_test/compute.dart';

void main() {
  test('Test island counter', () {
    var compute = Compute(10);
    // 10 setup islands
    var seed = [
      [0, 0, 1, 1, 1, 0, 0, 1, 0, 0],
      [1, 0, 0, 0, 1, 0, 1, 1, 0, 0],
      [1, 1, 0, 1, 0, 0, 1, 1, 0, 1],
      [0, 1, 1, 1, 0, 1, 0, 1, 1, 0],
      [0, 0, 0, 0, 1, 0, 1, 0, 0, 0],
      [1, 0, 0, 1, 0, 1, 1, 1, 1, 0],
      [1, 1, 1, 0, 0, 1, 0, 1, 1, 1],
      [0, 0, 0, 1, 1, 1, 1, 1, 1, 0],
      [1, 1, 1, 0, 1, 1, 1, 0, 1, 0],
      [1, 1, 0, 1, 1, 1, 1, 0, 1, 1],
    ];

    compute.cells = seed;
    final counter = compute.computeNumberOfIslands();
    expect(counter, 10);
  });
}
