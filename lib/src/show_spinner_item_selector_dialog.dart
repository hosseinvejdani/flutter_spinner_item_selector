// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_spinner_item_selector/flutter_spinner_item_selector.dart';

// Function to show a dialog with a spinner-based item selector
Future<T?> showSpinnerItemSelector<T>(
  BuildContext context, {
  required List<T> items,
  final Axis? scrollAxis, // Axis of scroll
  required Widget Function(dynamic item) selectedItemToWidget, // selected item to Widget function
  required Widget Function(dynamic item) nonSelectedItemToWidget, // non-selected item to Widget function
  int initSelectedIndex = 0,
  String? title, // title of selector dialog
  TextStyle? titleStyle, // style of tile at selector dialog
  Color? backgroundColor, // bgColor of selector dialog
  Color? foregroundColor, // fgColor of selector dialog
  ButtonStyle? buttonStyle, // style of buttons at selector dialog
  TextStyle? buttonTextStyle, // style of text in buttons at selector dialog
  bool barrierDismissible = true,
  double? height, // height of dialog box
  double? width, // width of dialog box
  double? spinnerHeight, // Height of spinner
  double? spinnerWidth, // Width of spinner
  double? itemHeight, // Height of items in spinner
  double? itemWidth, // Width of items in spinner
  Color? spinnerBgColor, // bgColor of spinner at selector dialog
  EdgeInsets? contentPadding,
  String? cancelButtonLabel,
  String? okButtonLabel,
}) async {
  assert(items.isNotEmpty, "[items] couldn't be an empty list!");
  assert(initSelectedIndex < items.length, "provided items not included initSelectedIndex");

  T? selectedItem;

  // Get the color scheme and screen size from the current theme
  final colorScheme = Theme.of(context).colorScheme;
  final size = MediaQuery.of(context).size;
  final Brightness currentBrightness = MediaQuery.of(context).platformBrightness;

  // Check the current brightness mode
  final bool isDarkMode = currentBrightness == Brightness.dark;

  // Set default values for various optional parameters
  final _foregroundColor = foregroundColor ?? colorScheme.onBackground.withAlpha(200);
  final _backgroundColor = backgroundColor ?? colorScheme.background;
  final _title = title ?? "Select a item";
  final _titleStyle = titleStyle ?? TextStyle(fontSize: 18, color: _foregroundColor);
  final _height = height ?? 0.25 * size.height; // height of dialog box
  final _width = width ?? 0.8 * size.width; // width of dialog box
  final _spinnerHeight = spinnerHeight ?? 0.7 * _height; // height spinner
  final _spinnerWidth = spinnerWidth ?? 0.21 * _width; // width spinner
  final _itemHeight = itemHeight ?? 0.35 * _spinnerHeight;
  final _itemWidth = itemWidth ?? 0.35 * _spinnerWidth;

  assert(_itemHeight <= _spinnerHeight, "should itemHeight > spinnerHeight");
  assert(_spinnerHeight <= _height, "should spinnerHeight > height");
  assert(_spinnerWidth <= _width, "should spinnerWidth > width");

  // Set spinner background color based on dark mode status
  final _spinnerBgColor = spinnerBgColor ?? (isDarkMode ? colorScheme.primary : colorScheme.primaryContainer);

  // Set default text style for buttons
  final _buttonTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: colorScheme.primary,
  );

  // Set default labels for cancel and done buttons
  final _cancelButtonLabel = cancelButtonLabel ?? 'Cancel';
  final _okButtonLabel = okButtonLabel ?? "Done";

  String pressedButton = "Cancel";

  // Create the Cancel and Done buttons with their respective actions
  final actionsButtons = <Widget>[
    TextButton(
      style: buttonStyle,
      onPressed: () {
        pressedButton = "Cancel";
        Navigator.of(context).pop();
      },
      child: Text(_cancelButtonLabel, style: _buttonTextStyle),
    ),
    TextButton(
      style: buttonStyle,
      onPressed: () {
        pressedButton = "Done";
        Navigator.of(context).pop();
      },
      child: Text(_okButtonLabel, style: _buttonTextStyle),
    ),
  ];

  selectedItem = items[initSelectedIndex];

  // Show the dialog and get the selected item when the dialog is dismissed
  await showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) {
      return Theme(
        data: Theme.of(context).copyWith(dialogBackgroundColor: _backgroundColor),
        child: AlertDialog(
          contentPadding: contentPadding,
          title: Center(child: Text(_title, style: _titleStyle)),
          content: SizedBox(
            height: _height,
            width: _width,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: SpinnerItemSelector(
                items: items,
                initSelectedIndex: initSelectedIndex,
                scrollAxis: scrollAxis,
                height: _spinnerHeight,
                width: _spinnerWidth,
                itemHeight: _itemHeight,
                itemWidth: _itemWidth,
                spinnerBgColor: _spinnerBgColor,
                selectedItemToWidget: selectedItemToWidget,
                nonSelectedItemToWidget: nonSelectedItemToWidget,
                onSelectedItemChanged: (item) => selectedItem = item,
              ),
            ),
          ),
          actions: actionsButtons,
        ),
      );
    },
  );

  // Return null if Cancel was pressed, otherwise return the selected item
  if (pressedButton == "Cancel") return null;

  return selectedItem;
}
