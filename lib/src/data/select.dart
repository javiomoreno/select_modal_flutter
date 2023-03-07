import 'package:flutter/material.dart';
import 'package:select_modal_flutter/src/models/item_select.dart';
import 'package:select_modal_flutter/src/widgets/select_dialog.dart';

export 'package:select_modal_flutter/src/models/item_select.dart';

///Main class,
///[title] hintText in searh
///[searchText] optional, text in modal search,
///[controller] TextEditingController to TextField
///[listItemSelect] List to search
///[boxDecoration] optional, boxdecoration to container
///[borderTextField] optiona, border to container
///[icon] optional, icon to trailing in container
///[colorIcon] optional, color icon to trailing in container
///[error] optional, error to border and icon in to container
class SelectModalFlutter extends StatefulWidget {
  final String title;
  final String? searchText;
  final TextEditingController controller;
  final List<ItemSelect> listItemSelect;
  final BoxDecoration? boxDecoration;
  final InputBorder? borderTextField;
  final IconData? icon;
  final Color? colorIcon;
  final bool? error;

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
    this.error,
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
    BoxDecoration? newDecoration;
    if (widget.error != null) {
      newDecoration = widget.boxDecoration?.copyWith(
          border: widget.error == true
              ? widget.borderTextField == null
                  ? Border(bottom: BorderSide(color: Colors.red, width: 1.0))
                  : Border.all(color: Colors.red, width: 1.0)
              : null);
    }

    return Container(
      decoration: widget.boxDecoration != null
          ? widget.error != null
              ? newDecoration
              : widget.boxDecoration
          : null,
      child: Padding(
        padding: EdgeInsets.only(left: 5.0),
        child: TextField(
          onTap: _changeSelectOption,
          controller: widget.controller,
          readOnly: true,
          decoration: InputDecoration(
            hintText: widget.title,
            border: widget.borderTextField ?? null,
            suffixIcon: widget.icon != null
                ? Icon(widget.icon,
                    color: widget.error != null
                        ? widget.error == true
                            ? Colors.red
                            : widget.colorIcon
                        : widget.colorIcon)
                : null,
          ),
        ),
      ),
    );
  }
}
