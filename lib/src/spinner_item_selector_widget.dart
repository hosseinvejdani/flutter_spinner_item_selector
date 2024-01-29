// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class SpinnerItemSelector<T> extends StatefulWidget {
  // Initialize parameters for the item picker
  final int initSelectedIndex; // Initial selected item index
  final List<T> items; // List of items should be shown
  final Axis? scrollAxis; // Axis of scroll
  final double height; // Height of the widget
  final double width; // Width of the widget
  final double itemHeight; // Height of individual items
  final double itemWidth; // Width of individual items
  final Color spinnerBgColor; // Background color of the widget
  final Widget Function(dynamic item) selectedItemToWidget; // selected item to Widget function
  final Widget Function(dynamic item) nonSelectedItemToWidget; // non-selected item to Widget function
  final void Function(dynamic item) onSelectedItemChanged; // Callback for value selection

  SpinnerItemSelector({
    super.key,
    this.initSelectedIndex = 0,
    required this.items,
    this.scrollAxis = Axis.vertical,
    required this.height,
    required this.width,
    required this.itemHeight,
    required this.itemWidth,
    required this.selectedItemToWidget,
    required this.nonSelectedItemToWidget,
    required this.onSelectedItemChanged,
    required this.spinnerBgColor,
  })  : assert(items.isNotEmpty, "[items] couldn't be an empty list!"),
        assert(initSelectedIndex < items.length, "provided items not included initSelectedIndex");

  @override
  State<SpinnerItemSelector> createState() => _SpinnerItemSelectorState();
}

// Define the state for the ItemElementPicker widget
class _SpinnerItemSelectorState<T> extends State<SpinnerItemSelector<T>> {
  late FixedExtentScrollController scrollController;
  late int _selectedIndex;
  late T _selectedItem;

  @override
  void initState() {
    // Initialize state variables and scroll controller
    setState(() {
      _selectedIndex = widget.initSelectedIndex;
      _selectedItem = widget.items[_selectedIndex];
      scrollController = FixedExtentScrollController(initialItem: _selectedIndex);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Build the item picker layout
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: widget.spinnerBgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: RotatedBox(
        quarterTurns: widget.scrollAxis == Axis.horizontal ? -1 : 0,
        child: ListWheelScrollView.useDelegate(
          controller: scrollController,
          itemExtent: widget.scrollAxis == Axis.horizontal ? widget.itemWidth : widget.itemHeight, // size of each item in the picker
          physics: const FixedExtentScrollPhysics(),
          childDelegate: ListWheelChildBuilderDelegate(
            builder: (context, index) {
              final wrappedIndex = index % widget.items.length; // Wrap around the values
              final wrappedItem = widget.items[wrappedIndex];

              final isSelectedThis = wrappedIndex == _selectedIndex;
              final wrappedItemWidget =
                  isSelectedThis ? widget.selectedItemToWidget(wrappedItem) : widget.nonSelectedItemToWidget(wrappedItem);

              return RotatedBox(
                quarterTurns: widget.scrollAxis == Axis.horizontal ? 1 : 0,
                child: Center(child: wrappedItemWidget),
              );
            },
          ),
          onSelectedItemChanged: (index) {
            final wrappedIndex = index % widget.items.length; // Wrap around the values

            setState(() {
              _selectedIndex = wrappedIndex;
              _selectedItem = widget.items[wrappedIndex];
            });
            widget.onSelectedItemChanged(_selectedItem); // Notify the parent about the value change
          },
        ),
      ),
    );
  }
}
