class ItemSelect {
  final int? value;
  final String? label;

  const ItemSelect({this.value, this.label});

  @override
  String toString() {
    return '{value: $value, label: $label}';
  }
}
