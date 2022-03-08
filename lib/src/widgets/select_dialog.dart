import 'package:flutter/material.dart';
import 'package:select_modal_flutter/src/models/item_select.dart';

class SelectDialogWidget extends StatefulWidget {
  final List<ItemSelect> itemList;
  final ItemSelect selectedItem;
  final ValueChanged<ItemSelect> onItemChanged;
  final String searchText;
  final List<ItemSelect> filteredItems;

  SelectDialogWidget({
    Key? key,
    required this.searchText,
    required this.itemList,
    required this.onItemChanged,
    required this.selectedItem,
    required this.filteredItems,
  }) : super(key: key);

  @override
  _SelectDialogWidgetState createState() => _SelectDialogWidgetState();
}

class _SelectDialogWidgetState extends State<SelectDialogWidget> {
  late List<ItemSelect> _filteredItems;
  late ItemSelect _selectedItem;

  @override
  void initState() {
    _selectedItem = widget.selectedItem;
    _filteredItems = widget.filteredItems;

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Dialog(
        backgroundColor: Colors.white,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(0),
                child: TextField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    labelText: widget.searchText,
                  ),
                  onChanged: (value) {
                    _filteredItems = widget.itemList
                        .where((item) => item.label!
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                    if (this.mounted) setState(() {});
                  },
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _filteredItems.length,
                  itemBuilder: (ctx, index) => Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          _filteredItems[index].label!,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        onTap: () {
                          _selectedItem = _filteredItems[index];
                          widget.onItemChanged(_selectedItem);
                          Navigator.of(context).pop();
                        },
                      ),
                      Divider(thickness: 1),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
