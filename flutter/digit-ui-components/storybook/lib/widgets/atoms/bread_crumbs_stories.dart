import 'package:digit_ui_components/theme/ComponentTheme/bread_crumb_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_bread_crumbs.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';

import '../../plugins/code_view_wrapper.dart';

List<Story> DigitBreadCrumbStories() {
  return [
    Story(
      name: 'Atom/DigitBreadCrumbs/Default',
      builder: (context){
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
DigitBreadCrumb(
          crumbs: [
            DigitBreadCrumbItem(content: 'Home',),
            DigitBreadCrumbItem(content: 'Category',),
            DigitBreadCrumbItem(content: 'Product',),
            DigitBreadCrumbItem(content: 'Details'),
          ],
          onClick: (item){},
        )
          ''');
        });
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
        name: 'Atom/DigitBreadCrumbs/With icon',
        builder: (context){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CodeViewProvider.of(context)?.updateCodeString('''
DigitBreadCrumb(
            crumbs: [
              DigitBreadCrumbItem(content: 'Home', icon: Icons.home),
              DigitBreadCrumbItem(content: 'Category', icon: Icons.category),
              DigitBreadCrumbItem(content: 'Product', icon: Icons.production_quantity_limits),
              DigitBreadCrumbItem(content: 'Details', icon:  Icons.details),
            ],
            onClick: (item){},
          )
          ''');
          });
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
      name: 'Atom/DigitBreadCrumbs/Custom separator',
      builder: (context){
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
DigitBreadCrumb(
          crumbs: [
            DigitBreadCrumbItem(content: 'Home', icon: Icons.home),
            DigitBreadCrumbItem(content: 'Category',),
            DigitBreadCrumbItem(content: 'Product',),
            DigitBreadCrumbItem(content: 'Details'),
          ],
          customSeparator: Icon(Icons.chevron_right),
          onClick: (item){},
        )
          ''');
        });
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
      name: 'Atom/DigitBreadCrumbs/With collapsed items',
      builder: (context){
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
DigitBreadCrumb(
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
        )
          ''');
        });
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
        name: 'Atom/DigitBreadCrumbs/With expanded text',
        builder: (context){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CodeViewProvider.of(context)?.updateCodeString('''
DigitBreadCrumb(
            crumbs: [
              DigitBreadCrumbItem(content: 'Home', icon: Icons.home),
              DigitBreadCrumbItem(content: 'Category',),
              DigitBreadCrumbItem(content: 'Product',),
              DigitBreadCrumbItem(content: 'Details'),
              DigitBreadCrumbItem(content: 'Details 2'),
            ],
            maxItems: 3,
            expandText: 'click to expand',
            onClick: (item){},
          )
          ''');
          });
          return DigitBreadCrumb(
            crumbs: [
              DigitBreadCrumbItem(content: 'Home', icon: Icons.home),
              DigitBreadCrumbItem(content: 'Category',),
              DigitBreadCrumbItem(content: 'Product',),
              DigitBreadCrumbItem(content: 'Details'),
              DigitBreadCrumbItem(content: 'Details 2'),
            ],
            maxItems: 3,
            expandText: 'click to expand',
            onClick: (item){},
          );
        }
    ),
    Story(
      name: 'Atom/DigitBreadCrumbs/Custom styles',
      builder: (context){
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
DigitBreadCrumb(
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
        )
          ''');
        });
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