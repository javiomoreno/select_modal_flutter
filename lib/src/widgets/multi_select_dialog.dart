import 'package:flutter/material.dart';
import 'package:select_modal_flutter/src/models/item_select.dart';

///Main widget,
///[itemList] List original to search
///[selectedItem] List items selected
///[onItemChanged] Function to return value selected
///[searchText] Text in search textfield
///[filteredItems] List filtered to search
class MultiSelectDialogWidget extends StatefulWidget {
  final List<ItemSelect> itemList;
  final List<ItemSelect> selectedItem;
  final ValueChanged<List<ItemSelect>> onItemChanged;
  final String searchText;
  final List<ItemSelect> filteredItems;
  final Color? colorButtonSelect;

  MultiSelectDialogWidget({
    Key? key,
    required this.searchText,
    required this.itemList,
    required this.onItemChanged,
    required this.selectedItem,
    required this.filteredItems,
    this.colorButtonSelect,
  }) : super(key: key);

  @override
  _MultiSelectDialogWidgetState createState() =>
      _MultiSelectDialogWidgetState();
}

class _MultiSelectDialogWidgetState extends State<MultiSelectDialogWidget> {
  late List<ItemSelect> _filteredItems;
  late List<ItemSelect> _selectedItem;

  @override
  void initState() {
    _selectedItem = widget.selectedItem;
    _filteredItems = widget.filteredItems;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(0),
                child: Row(
                  children: [
                    SizedBox(
                      width: _selectedItem.isNotEmpty
                          ? width - 140.0
                          : width - 100.0,
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
                    if (_selectedItem.isNotEmpty) _iconSave()
                  ],
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
  }

  Widget _iconSave() {
    return GestureDetector(
      onTap: () {
        widget.onItemChanged(_selectedItem);
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: widget.colorButtonSelect != null
              ? widget.colorButtonSelect!.withOpacity(.2)
              : Colors.green.withOpacity(.2),
          border: Border.all(
            color: widget.colorButtonSelect != null
                ? widget.colorButtonSelect!
                : Colors.green,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Icon(Icons.check),
      ),
    );
  }

  Widget _item(ItemSelect item) {
    return Column(
      children: [
        Container(
          color: _selectedItem.contains(item) ? Colors.grey[200] : null,
          child: ListTile(
            title: Text(
              item.label!,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            trailing: _selectedItem.contains(item) ? Icon(Icons.check) : null,
            onTap: () {
              final elementExists = _selectedItem.contains(item);
              if (!elementExists) {
                _selectedItem.add(item);
              } else {
                var indice = _selectedItem.indexOf(item);
                this._selectedItem.removeAt(indice);
              }
              setState(() {});
            },
          ),
        ),
        const Divider(thickness: 1)
      ],
    );
  }
}
