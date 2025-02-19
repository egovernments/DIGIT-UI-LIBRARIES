import 'package:digit_ui_components/theme/ComponentTheme/bread_crumb_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_bread_crumbs.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';
import 'package:flutter/material.dart';

import '../../iframe/iframe_widget.dart';

List<Story> DigitBreadCrumbStories() {
  return [
    Story(
      name: 'Atom/Breadcrumbs/Documentation',
      builder: (context) {
        return IframeWidget(
          url: 'https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-components-v0.2.0',
        );
      },
    ),
    Story(
      name: 'Atom/Breadcrumbs/Basic',
      builder: (context) {
        // Add a knob to enable/disable icons
        final showIcons = context.knobs.boolean(label: 'Show Icons', initial: false);
        final showCustomSeparator = context.knobs.boolean(label: 'Show Custom Separator', initial: false);

        return DigitBreadCrumb(
          crumbs: [
            DigitBreadCrumbItem(
              content: 'Home',
              icon: showIcons ? Icons.home : null,
            ),
            DigitBreadCrumbItem(
              content: 'Category',
              icon: showIcons ? Icons.category : null,
            ),
            DigitBreadCrumbItem(
              content: 'Product',
              icon: showIcons ? Icons.production_quantity_limits : null,
            ),
            DigitBreadCrumbItem(
              content: 'Details',
              icon: showIcons ? Icons.details : null,
            ),
          ],
          onClick: (item) {},
          customSeparator: showCustomSeparator ? Icon(Icons.chevron_right) : null,
        );
      },
    ),

    Story(
      name: 'Atom/Breadcrumbs/Collapsed',
      builder: (context){

        // Add a knob to enable/disable icons
        final showIcons = context.knobs.boolean(label: 'Show Icons', initial: false);
        final showCustomSeparator = context.knobs.boolean(label: 'Show Custom Separator', initial: false);

        return DigitBreadCrumb(
          crumbs: [
            DigitBreadCrumbItem(
              content: 'Home',
              icon: showIcons ? Icons.home : null,
            ),
            DigitBreadCrumbItem(
              content: 'Category',
              icon: showIcons ? Icons.category : null,
            ),
            DigitBreadCrumbItem(
              content: 'Product',
              icon: showIcons ? Icons.production_quantity_limits : null,
            ),
            DigitBreadCrumbItem(
              content: 'Details',
              icon: showIcons ? Icons.details : null,
            ),
          ],
          customSeparator: showCustomSeparator ? Icon(Icons.chevron_right) : null,
          maxItems: 3,
          expandText: '...',
          onClick: (item){},
        );
      }
    ),
    Story(
      name: 'Atom/Breadcrumbs/Custom',
      builder: (context){

        return DigitBreadCrumb(
          crumbs: [
            DigitBreadCrumbItem(content: 'Home', icon: Icons.home),
            DigitBreadCrumbItem(content: 'Category',),
            DigitBreadCrumbItem(content: 'Product',),
            DigitBreadCrumbItem(content: 'Details'),
          ],
          onClick: (item){},
          themeData: const DigitBreadCrumbThemeData().copyWith(
            activeTextStyle: const TextStyle(color: Colors.red),
            separatorTextStyle: const TextStyle(color: Colors.blue),
          ),
        );
      }
    ),
  ];
}