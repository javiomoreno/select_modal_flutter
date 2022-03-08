library select_modal_flutter;

import 'package:flutter/material.dart';
import 'package:select_modal_flutter/src/models/item_select.dart';
import 'package:select_modal_flutter/src/widgets/select_dialog.dart';

export 'package:select_modal_flutter/src/models/item_select.dart';

class SelectModalFlutter extends StatefulWidget {
  final String title;
  final String? searchText;
  final TextEditingController controller;
  final List<ItemSelect> listItemSelect;
  final BoxDecoration? boxDecoration;
  final InputBorder? borderTextField;
  final IconData? icon;
  final Color? colorIcon;

  const SelectModalFlutter({
    Key? key,
    required this.title,
    required this.controller,
    this.searchText,
    required this.listItemSelect,
    this.boxDecoration,
    this.borderTextField,
    this.icon,
    this.colorIcon,
  }) : super(key: key);

  @override
  State<SelectModalFlutter> createState() => _SelectModalFlutterState();
}

class _SelectModalFlutterState extends State<SelectModalFlutter> {
  late ItemSelect _selectedItem = new ItemSelect();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _changeSelectOption() async {
    List<ItemSelect> filteredItems = widget.listItemSelect;
    await showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) => StatefulBuilder(
        builder: (ctx, setState) => SelectDialogWidget(
          filteredItems: filteredItems,
          searchText: widget.searchText ?? 'Buscar',
          itemList: filteredItems,
          selectedItem: _selectedItem,
          onItemChanged: (ItemSelect item) {
            _selectedItem = item;
            widget.controller.text = item.label!;
            setState(() {});
          },
        ),
      ),
    );
    if (this.mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.boxDecoration ?? null,
      child: Padding(
        padding: EdgeInsets.only(left: 5.0),
        child: TextField(
          onTap: _changeSelectOption,
          controller: widget.controller,
          readOnly: true,
          decoration: InputDecoration(
            hintText: widget.title,
            border: widget.borderTextField ?? null,
            suffixIcon: widget.icon != null ? Icon(
              widget.icon,
              color: widget.colorIcon
            ) : null,
          ),
        ),
      ),
    );
  }
}
