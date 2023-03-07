import 'package:flutter/material.dart';
import 'package:select_modal_flutter/src/models/item_select.dart';

///Main widget,  
///[itemList] List original to search
///[selectedItem] Item selected
///[onItemChanged] Function to return value selected
///[searchText] Text in search textfield
///[filteredItems] List filtered to search
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                Column(
                  children: _filteredItems.map((item) => _item(item)).toList(),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _item(ItemSelect item) {
    return Column(
      children: [
        Container(
          color: _selectedItem.value == item.value ? Colors.grey[200] : null,
          child: ListTile(
            title: Text(
              item.label!,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            trailing: _selectedItem.value == item.value ? Icon(Icons.check) : null,
            onTap: () {
              widget.onItemChanged(item);
              Navigator.of(context).pop();
            },
          ),
        ),
        const Divider(thickness: 1)
      ],
    );
  }
}
