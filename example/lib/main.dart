import 'package:flutter/material.dart';
import 'package:select_modal_flutter/select_modal_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example Select Modal Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controllerCity = TextEditingController();
  TextEditingController controllerCountry = TextEditingController();
  TextEditingController controllerName = TextEditingController();

  List<ItemSelect> listItemSelectCities = [
    const ItemSelect(value: 1, label: 'Caracas'),
    const ItemSelect(value: 2, label: 'San Cristobal'),
    const ItemSelect(value: 3, label: 'Merida'),
    const ItemSelect(value: 4, label: 'Maracaibo'),
    const ItemSelect(value: 4, label: 'Barquisimeto'),
    const ItemSelect(value: 4, label: 'Los Teques'),
    const ItemSelect(value: 4, label: 'La Guaira'),
  ];

  List<ItemSelect> listItemSelectNames = [
    const ItemSelect(value: 1, label: 'Pedro'),
    const ItemSelect(value: 2, label: 'Juan'),
    const ItemSelect(value: 3, label: 'Maria'),
    const ItemSelect(value: 4, label: 'Antonio'),
  ];

  bool errorSelectName = false;

  @override
  void dispose() {
    controllerCity.dispose();
    controllerCountry.dispose();
    controllerName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Select Modal Flutter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '--- Select ---',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15.0),
              const Text('Names'),
              const SizedBox(
                height: 15.0,
              ),
              SelectModalFlutter(
                title: 'Name',
                searchText: 'Select names',
                onItemSelect: (ItemSelect value) {
                  print(value);
                },
                listItemSelect: listItemSelectNames,
                borderTextField: InputBorder.none,
                boxDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 1.0),
                ),
                icon: Icons.person,
                colorIcon: Colors.blue,
                error: errorSelectName,
              ),
              const SizedBox(
                height: 15.0,
              ),
              const Text(
                '--- Multi Select ---',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15.0),
              const Text('Cities'),
              const SizedBox(
                height: 15.0,
              ),
              MultiSelectModalFlutter(
                  title: 'City',
                  searchText: 'Select city',
                  listItemSelect: listItemSelectCities,
                  borderTextField: InputBorder.none,
                  boxDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 1.0),
                  ),
                  colorButtonSelect: Colors.blue,
                  onItemSelect: (List<ItemSelect> items) {
                    print(items);
                  }),
              const SizedBox(height: 15.0),
              ElevatedButton(
                onPressed: () {
                  if (controllerName.text.isEmpty) {
                    setState(() {
                      errorSelectName = true;
                    });
                  } else {
                    setState(() {
                      errorSelectName = false;
                    });
                  }
                },
                child: const Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
