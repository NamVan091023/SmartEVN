import 'package:flutter/material.dart';

/// Usage:
/// CustomDropdown<String>(
//     items: ['A', 'B', 'C'],
//     onChanged: (val) => _selectedValue = val,
//     center: true,
//  ),
/// --> Remember: f.toString() at line 105 is @override String toString() in your class
// @override
// String toString() {
//   return name;
// }
class CustomDropdown<T> extends StatefulWidget {
  CustomDropdown({
    Key? key,
    required this.items,
    required this.onChanged,
    this.onInit,
    this.padding = const EdgeInsets.all(10),
    this.height = 40,
    this.center = false,
    this.itemText,
  }) : super(key: key);

  /// list item
  final List<T> items;

  /// onChanged
  final void Function(T? value) onChanged;

  /// onInit
  final void Function(T value)? onInit;

  ///padding
  final EdgeInsetsGeometry padding;

  /// container height
  final double height;

  /// center
  final bool center;

  final String Function(T? value)? itemText;

  @override
  _CustomDropdownState<T> createState() => _CustomDropdownState();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T?>> {
  /// current selected value
  T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _initValue();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  /// set default selected value when init
  _initValue() {
    if (widget.items.isEmpty) {
      _selectedValue = null;
    } else
      _selectedValue = widget.items[0];
    if (widget.onInit != null) widget.onInit!(_selectedValue);
  }

  _buildBody() {
    Color borderLine = Color(0xffc0c0c0);
    return Padding(
      padding: widget.padding,
      child: Row(
        mainAxisAlignment: (widget.center)
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: <Widget>[
          new Container(
            height: widget.height,
            padding: EdgeInsets.only(left: 10.0),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 0.8, style: BorderStyle.solid, color: borderLine),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
            child: new DropdownButtonHideUnderline(
              child: new DropdownButton<T>(
                value: _selectedValue,
                onChanged: (T? newValue) {
                  setState(() {
                    _selectedValue = newValue;
                    widget.onChanged(newValue);
                  });
                },
                menuMaxHeight: 300,
                isExpanded: true,
                items: widget.items.map((T? f) {
                  return new DropdownMenuItem<T>(
                    value: f,
                    child: new Text(
                      (widget.itemText != null)
                          ? widget.itemText!(f)
                          : f.toString(),
                      style: new TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
