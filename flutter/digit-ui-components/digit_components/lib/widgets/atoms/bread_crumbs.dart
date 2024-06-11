import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';
import '../../constants/AppView.dart';

class Breadcrumb extends StatefulWidget {
  final List<String> items;
  final Function(int) onTap;

  const Breadcrumb({Key? key, required this.items, required this.onTap}) : super(key: key);

  @override
  _BreadcrumbState createState() => _BreadcrumbState();
}

class _BreadcrumbState extends State<Breadcrumb> {
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    DigitTypography currentTypography = getTypography(context, false);
    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    bool isTab = AppView.isTabletView(MediaQuery.of(context).size);

    return Row(
      children: widget.items.asMap().entries.map((entry) {
        int idx = entry.key;
        String item = entry.value;

        return Row(
          children: [
            InkWell(
              highlightColor: const DigitColors().transparent,
              hoverColor: const DigitColors().transparent,
              splashColor: const DigitColors().transparent,
              onHover:idx < widget.items.length - 1 ? (hover) {
                setState(() {
                  if(hover){
                    _hoveredIndex = idx;
                  }else{
                    _hoveredIndex = null;
                  }
                });
              } : null,
              onTap: idx < widget.items.length - 1 ? () => widget.onTap(idx) : null,
              child: Text(
                item,
                style: currentTypography.bodyS.copyWith(
                  color: idx < widget.items.length - 1
                      ? const DigitColors().light.primary1
                      : const DigitColors().light.textSecondary,
                  decoration: _hoveredIndex == idx
                      ? TextDecoration.underline
                      : TextDecoration.none,
                  decorationColor: const DigitColors().light.primary1,
                ),
              ),
            ),
            if (idx < widget.items.length - 1)
              const SizedBox(width: 8,),
            if (idx < widget.items.length - 1)
              Text(
                '/',
                style: currentTypography.bodyS.copyWith(
                  color: const DigitColors().light.textSecondary,
                ),
              ),
            if (idx < widget.items.length - 1)
              const SizedBox(width: 8,),
          ],
        );
      }).toList(),
    );
  }
}
