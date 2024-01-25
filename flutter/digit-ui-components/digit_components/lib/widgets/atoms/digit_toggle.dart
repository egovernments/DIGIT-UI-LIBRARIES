import 'package:digit_components/digit_components.dart';
import 'package:flutter/material.dart';
/// DigitToggle is a custom toggle button widget that provides visual feedback on hover and supports selection.

class DigitToggle extends StatefulWidget {
  final void Function(bool isSelected) onChanged;
  final String label;
  bool isSelected;
  final double maxLabelWidth;

  DigitToggle({
    Key? key,
    required this.onChanged,
    required this.label,
    this.isSelected = false,
    required this.maxLabelWidth,
  }) : super(key: key);

  @override
  _DigitToggleState createState() => _DigitToggleState();
}

class _DigitToggleState extends State<DigitToggle> {
  bool isHovered = false;
  bool isMouseDown = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            isHovered = false;
          });
        },
        child: GestureDetector(
          onTapDown: (_) {
            /// Handle mouse down state
            setState(() {
              isMouseDown = true;
            });
          },
          onTapUp: (_) {
            /// Handle mouse up state
            setState(() {
              isMouseDown = false;
            });
          },
          onTap: () {
            if(widget.isSelected==false){
              widget.onChanged(true);
            }
          },
          child: Container(
            height: 32,
            width: widget.maxLabelWidth+40,
            constraints: const BoxConstraints(
              minWidth: 40,
              maxWidth: 200,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.zero,
              border: Border.all(
                color: (isHovered || widget.isSelected || isMouseDown)
                    ? const DigitColors().burningOrange
                    : const DigitColors().cloudGray,
                width: 1.0,
              ),
              color: widget.isSelected
                  ? const DigitColors().burningOrange
                  : const DigitColors().white,
              boxShadow: [
                BoxShadow(
                  color: isMouseDown ? const DigitColors().shadowColor : const DigitColors().transaparent,
                  offset: const Offset(
                    0,
                    0,
                  ),
                  spreadRadius: 0,
                  blurRadius: 6,
                ),
              ],
            ),
            child: Center(
              child: Text(
                widget.label,
                textAlign: TextAlign.center,
                style: DigitTheme.instance.mobileTheme.textTheme.bodyMedium?.copyWith(
                  color: (isHovered && !widget.isSelected || isMouseDown)
                      ? const DigitColors().burningOrange
                      : widget.isSelected
                      ? const DigitColors().white
                      : const DigitColors().cloudGray,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// Widget _buildListView() {
//   return ConstrainedBox(
//     constraints: const BoxConstraints(
//       maxHeight: 200,
//     ),
//     child: ListView.separated(
//       separatorBuilder: (_, __) => const SizedBox(height: 0),
//       shrinkWrap: true,
//       padding: EdgeInsets.zero,
//       itemCount: filteredItems.length,
//       itemBuilder: (context, index) {
//         final item = filteredItems[index];
//         // bool isSelected = selectedOptions.any(
//         //         (item) => item.code == option.code && item.name == option.name);
//         Color backgroundColor = index % 2 == 0
//             ? const DigitColors().white
//             : const DigitColors().alabasterWhite;
//         return ListTile(
//           contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//           splashColor: const DigitColors().transaparent,
//           focusColor: const DigitColors().transaparent,
//           hoverColor: const DigitColors().transaparent,
//
//           title: Container(
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color
//                     : Colors.transparent,
//               ),
//               color:  backgroundColor,
//             ),
//             padding: EdgeInsets.zero,
//             child: Padding(
//               padding: widget.dropdownType == DropdownType.defaultSelect &&
//                   item.description == null
//                   ? DropdownConstants.defaultPadding
//                   : DropdownConstants.nestedItemPadding,
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   if (widget.dropdownType == DropdownType.profileSelect)
//                     SizedBox(
//                       height: DropdownConstants.defaultProfileSize,
//                       width: DropdownConstants.defaultProfileSize,
//                       child: CircleAvatar(
//                         radius: DropdownConstants.defaultImageRadius,
//
//                         /// This radius is the radius of the picture in the circle avatar itself.
//                         backgroundImage: item.profileImage,
//                         backgroundColor: const DigitColors().davyGray,
//                       ),
//                     ),
//                   if (widget.dropdownType == DropdownType.profileSelect)
//                     const SizedBox(
//                       width: 6,
//                     ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           if (item.textIcon != null)
//                             Icon(
//                               item.textIcon,
//                               size: DropdownConstants.textIconSize,
//                               color: const DigitColors().davyGray,
//                             ),
//                           if (item.textIcon != null)
//                             const SizedBox(
//                               width: kPadding / 2,
//                             ),
//                           Text(
//                             item.name,
//                             style: DigitTheme
//                                 .instance.mobileTheme.textTheme.bodyLarge
//                                 ?.copyWith(
//                                 color: const DigitColors().davyGray),
//                           )
//                         ],
//                       ),
//                       if (item.description != null)
//                         Text(
//                           item.description!,
//                           style: DigitTheme
//                               .instance.mobileTheme.textTheme.bodySmall
//                               ?.copyWith(
//                             color: const DigitColors().davyGray,
//                           ),
//                         ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           textColor: const DigitColors().davyGray,
//           selectedColor: const DigitColors().white,
//           // selected: isSelected,
//           autofocus: true,
//           // tileColor: widget.selectionType == SelectionType.nestedMultiSelect
//           //     ? const DigitColors().white
//           //     : backgroundColor,
//           selectedTileColor: const DigitColors().burningOrange,
//           onTap: () {
//             setState(() => _currentIndex = item.code);
//             widget.onChange(item.name, item.code);
//             _toggleDropdown();
//           },
//         );
//       },
//     ),
//   );
// }
//
// Widget _buildNestedListView() {
//   return ConstrainedBox(
//     constraints: const BoxConstraints(
//       maxHeight: 200,
//     ),
//     child: _buildNestedContent(),
//   );
// }
//
// Widget _buildNestedContent() {
//   Set<String?> uniqueTypes = filteredItems.map((item) => item.type).toSet();
//
//   return ListView.separated(
//     separatorBuilder: (_, __) => const SizedBox(height: 0),
//     shrinkWrap: true,
//     padding: EdgeInsets.zero,
//     itemCount: uniqueTypes.length,
//     itemBuilder: (context, index) {
//       String? type = uniqueTypes.elementAt(index);
//
//       if (type != null) {
//         return Column(
//           children: [
//             Container(
//               padding: DropdownConstants.nestedItemHeaderPadding,
//               color: const DigitColors().alabasterWhite,
//               child:
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   type,
//                   style: DigitTheme.instance.mobileTheme.textTheme.headlineSmall
//                       ?.copyWith(
//                     color: const DigitColors().davyGray,
//                   ),
//                 ),
//               ),
//             ),
//             ..._buildGroupedItems(type),
//             if (index != uniqueTypes.length - 1) const SizedBox(height: 16),
//             // Adjust the spacing as needed
//           ],
//         );
//       } else {
//         return const SizedBox.shrink();
//       }
//     },
//   );
// }
