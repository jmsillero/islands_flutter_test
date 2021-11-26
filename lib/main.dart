import 'package:flutter/material.dart';
import 'package:island_counter_test/cell.dart';
import 'package:island_counter_test/compute.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Compute compute = Compute(10);
  int islands = 0;
  int n = 0;
  List<List<Cell>> cells = [];

  @override
  void initState() {
    cells = compute.cells;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  children: [
                    const Text(
                      'Cantidad de islas',
                      style: TextStyle(fontSize: 36),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      islands.toString(),
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Center(
                      child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: cells.length,
                    children: generateCells(),
                  )),
                ),
              ),
              TextFormField(
                onChanged: (value) => n = int.parse(value),
                keyboardType: TextInputType.number,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          islands = compute.reorder();
                          cells = compute.cells;
                        });
                      },
                      child: const Text('Reordenar')),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          islands = compute.configure(n);
                          cells = compute.cells;
                        });
                      },
                      child: const Text('Configurar')),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          islands = compute.invertCell();
                          cells = compute.cells;
                        });
                      },
                      child: const Text('Calcular')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  generateCells() {
    List<Widget> widgets = [];
    for (var x = 0; x < cells.length; x++) {
      for (var y = 0; y < cells.length; y++) {
        var cell = cells[x][y];
        widgets.add(Padding(
          padding: const EdgeInsets.all(.8),
          child: InkWell(
            onTap: () {
              setState(() {
                islands = compute.invertCell(cell);
              });
            },
            child: Container(
              color: cell.value >= 1
                  ? Colors.primaries[cell.value % Colors.primaries.length]
                  : Colors.blueGrey.withOpacity(.6),
            ),
          ),
        ));
      }
    }
    return widgets;
  }
}
