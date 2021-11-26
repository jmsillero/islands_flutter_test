import 'package:flutter/material.dart';
import 'package:island_counter_test/compute.dart';
import 'package:island_counter_test/coordinate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  final Compute compute = Compute(1);
  int islands = 0;
  List<List<int>> cells = [];
  TextEditingController gridSizeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final duration = const Duration(seconds: 1);

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
                padding: const EdgeInsets.all(24),
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
                    children: generateGrid(),
                  )),
                ),
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
                      onPressed: showForm, child: const Text('Configurar')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  showForm() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text('Configurar rejilla')),
            content: Form(
                key: formKey,
                child: TextFormField(
                  controller: gridSizeController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.parse(value) < 1) {
                      return 'La rejilla debe tener al menos una celda';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      hintText: '10', labelText: 'Tamaño de la rejilla'),
                )),
            actionsAlignment: MainAxisAlignment.spaceAround,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                    onPressed: () {
                      gridSizeController.clear();
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          islands = compute
                              .configure(int.parse(gridSizeController.text));
                          cells = compute.cells;
                        });
                        Navigator.pop(context);
                        gridSizeController.clear();
                      }
                    },
                    child: const Text('Generar')),
              ),
            ],
          );
        });
  }

  generateGrid() {
    List<Widget> widgets = [];
    for (var x = 0; x < cells.length; x++) {
      for (var y = 0; y < cells.length; y++) {
        var cell = cells[x][y];
        widgets.add(Padding(
          padding: const EdgeInsets.all(.8),
          child: InkWell(
            onTap: () {
              setState(() {
                islands = compute.invertCell(Coordinate(x, y));
                cells = compute.cells;
              });
            },
            child: AnimatedContainer(
              duration: duration,
              color: cell >= 1
                  ? Colors.primaries[cell % Colors.primaries.length]
                  : Colors.blueGrey.withOpacity(.6),
            ),
          ),
        ));
      }
    }
    return widgets;
  }
}
