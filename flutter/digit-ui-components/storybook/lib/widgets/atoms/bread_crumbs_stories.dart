import 'package:digit_ui_components/theme/ComponentTheme/bread_crumb_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_bread_crumbs.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';
import 'package:flutter/material.dart';

import '../../plugins/code_view_wrapper.dart';

List<Story> DigitBreadCrumbStories() {
  return [
    Story(
      name: 'Atom/Breadcrumbs/Default',
      builder: (context){
        return DigitBreadCrumb(
          crumbs: [
            DigitBreadCrumbItem(content: 'Home',),
            DigitBreadCrumbItem(content: 'Category',),
            DigitBreadCrumbItem(content: 'Product',),
            DigitBreadCrumbItem(content: 'Details'),
          ],
          onClick: (item){},
        );
      }
    ),
    Story(
        name: 'Atom/Breadcrumbs/With icon',
        builder: (context){

          return DigitBreadCrumb(
            crumbs: [
              DigitBreadCrumbItem(content: 'Home', icon: Icons.home),
              DigitBreadCrumbItem(content: 'Category', icon: Icons.category),
              DigitBreadCrumbItem(content: 'Product', icon: Icons.production_quantity_limits),
              DigitBreadCrumbItem(content: 'Details', icon:  Icons.details),
            ],
            onClick: (item){},
          );
        }
    ),
    Story(
      name: 'Atom/Breadcrumbs/Custom separator',
      builder: (context){

        return DigitBreadCrumb(
          crumbs: [
            DigitBreadCrumbItem(content: 'Home', icon: Icons.home),
            DigitBreadCrumbItem(content: 'Category',),
            DigitBreadCrumbItem(content: 'Product',),
            DigitBreadCrumbItem(content: 'Details'),
          ],
          customSeparator: Icon(Icons.chevron_right),
          onClick: (item){},
        );
      }
    ),
    Story(
      name: 'Atom/Breadcrumbs/With collapsed items',
      builder: (context){

        return DigitBreadCrumb(
          crumbs: [
            DigitBreadCrumbItem(content: 'Home', icon: Icons.home),
            DigitBreadCrumbItem(content: 'Category',),
            DigitBreadCrumbItem(content: 'Product',),
            DigitBreadCrumbItem(content: 'Details'),
            DigitBreadCrumbItem(content: 'Details 2'),
          ],
          maxItems: 3,
          expandText: '...',
          onClick: (item){},
        );
      }
    ),
    Story(
      name: 'Atom/Breadcrumbs/Custom styles',
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