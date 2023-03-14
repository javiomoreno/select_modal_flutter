import 'package:flutter/material.dart';
import 'package:select_modal_flutter/src/models/item_select.dart';
import 'package:select_modal_flutter/src/widgets/widgets.dart';

export 'package:select_modal_flutter/src/models/item_select.dart';

///Main class,
///[title] hintText in searh
///[searchText] optional, text in modal search,
///[listItemSelect] List to search
///[boxDecoration] optional, boxdecoration to container
///[borderTextField] optiona, border to container
///[icon] optional, icon to trailing in container
///[colorIcon] optional, color icon to trailing in container
///[error] optional, error to border and icon in to container
///[onItemSelect] Function return list items select
///[colorButtonSelect] optional, color button select
class MultiSelectModalFlutter extends StatefulWidget {
  final String title;
  final String? searchText;
  final List<ItemSelect> listItemSelect;
  final BoxDecoration? boxDecoration;
  final InputBorder? borderTextField;
  final IconData? icon;
  final Color? colorIcon;
  final bool? error;
  final Function onItemSelect;
  final Color? colorButtonSelect;

  const MultiSelectModalFlutter({
    Key? key,
    required this.title,
    this.searchText,
    required this.listItemSelect,
    this.boxDecoration,
    this.borderTextField,
    this.icon,
    this.colorIcon,
    this.error,
    required this.onItemSelect,
    this.colorButtonSelect,
  }) : super(key: key);

  @override
  State<MultiSelectModalFlutter> createState() =>
      _MultiSelectModalFlutterState();
}

class _MultiSelectModalFlutterState extends State<MultiSelectModalFlutter> {
  late List<ItemSelect> _selectedItem = [];

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
        builder: (ctx, setState) => MultiSelectDialogWidget(
          filteredItems: filteredItems,
          searchText: widget.searchText ?? 'Buscar',
          itemList: filteredItems,
          selectedItem: _selectedItem,
          colorButtonSelect: widget.colorButtonSelect,
        ),
      ),
    ).then((value) {
      if (value is List<ItemSelect>) {
        _selectedItem = value;
        widget.onItemSelect(value);
        setState(() {});
      }
    });
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

    return Column(
      children: [
        Container(
          decoration: widget.boxDecoration != null
              ? widget.error != null
                  ? newDecoration
                  : widget.boxDecoration
              : null,
          child: Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: TextField(
              onTap: _changeSelectOption,
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
        ),
        SizedBox(height: 10.0),
        SizedBox(
          width: MediaQuery.of(context).size.width - 50.0,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _selectedItem.map((item) => _item(item)).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _item(ItemSelect item) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
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
      child: Text(item.label!),
    );
  }
}
