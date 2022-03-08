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
  ];

  List<ItemSelect> listItemSelectCountries = [
    const ItemSelect(value: 1, label: 'Venezuela'),
    const ItemSelect(value: 2, label: 'Colombia'),
    const ItemSelect(value: 3, label: 'Alemania'),
    const ItemSelect(value: 4, label: 'Peru'),
  ];

  List<ItemSelect> listItemSelectNames = [
    const ItemSelect(value: 1, label: 'Pedro'),
    const ItemSelect(value: 2, label: 'Juan'),
    const ItemSelect(value: 3, label: 'Maria'),
    const ItemSelect(value: 4, label: 'Antonio'),
  ];

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
              const Text('Cities'),
              const SizedBox(
                height: 15.0,
              ),
              SelectModalFlutter(
                title: 'City',
                searchText: 'Select city',
                controller: controllerCity,
                listItemSelect: listItemSelectCities,
                borderTextField: InputBorder.none,
                boxDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 1.0),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              const Text('Countries'),
              const SizedBox(
                height: 15.0,
              ),
              SelectModalFlutter(
                title: 'Country',
                searchText: 'Select country',
                controller: controllerCountry,
                listItemSelect: listItemSelectCountries,
              ),
              const SizedBox(
                height: 15.0,
              ),
              const Text('Names'),
              const SizedBox(
                height: 15.0,
              ),
              SelectModalFlutter(
                title: 'Name',
                searchText: 'Select names',
                controller: controllerName,
                listItemSelect: listItemSelectNames,
                borderTextField: InputBorder.none,
                boxDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 1.0),
                ),
                icon: Icons.person,
                colorIcon: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
