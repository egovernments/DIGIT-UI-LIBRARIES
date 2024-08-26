import 'package:digit_ui_components/theme/ComponentTheme/bread_crumb_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_bread_crumbs.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';

import '../../plugins/code_view_wrapper.dart';

List<Story> breadCrumbStories() {
  return [
    Story(
      name: 'Atom/BreadCrumbs/Default',
      builder: (context){
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
Breadcrumb(
          crumbs: [
            BreadcrumbItem(content: 'Home',),
            BreadcrumbItem(content: 'Category',),
            BreadcrumbItem(content: 'Product',),
            BreadcrumbItem(content: 'Details'),
          ],
          onClick: (item){},
        )
          ''');
        });
        return Breadcrumb(
          crumbs: [
            BreadcrumbItem(content: 'Home',),
            BreadcrumbItem(content: 'Category',),
            BreadcrumbItem(content: 'Product',),
            BreadcrumbItem(content: 'Details'),
          ],
          onClick: (item){},
        );
      }
    ),
    Story(
        name: 'Atom/BreadCrumbs/With icon',
        builder: (context){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CodeViewProvider.of(context)?.updateCodeString('''
Breadcrumb(
            crumbs: [
              BreadcrumbItem(content: 'Home', icon: Icons.home),
              BreadcrumbItem(content: 'Category', icon: Icons.category),
              BreadcrumbItem(content: 'Product', icon: Icons.production_quantity_limits),
              BreadcrumbItem(content: 'Details', icon:  Icons.details),
            ],
            onClick: (item){},
          )
          ''');
          });
          return Breadcrumb(
            crumbs: [
              BreadcrumbItem(content: 'Home', icon: Icons.home),
              BreadcrumbItem(content: 'Category', icon: Icons.category),
              BreadcrumbItem(content: 'Product', icon: Icons.production_quantity_limits),
              BreadcrumbItem(content: 'Details', icon:  Icons.details),
            ],
            onClick: (item){},
          );
        }
    ),
    Story(
      name: 'Atom/BreadCrumbs/Custom separator',
      builder: (context){
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
Breadcrumb(
          crumbs: [
            BreadcrumbItem(content: 'Home', icon: Icons.home),
            BreadcrumbItem(content: 'Category',),
            BreadcrumbItem(content: 'Product',),
            BreadcrumbItem(content: 'Details'),
          ],
          customSeparator: Icon(Icons.chevron_right),
          onClick: (item){},
        )
          ''');
        });
        return Breadcrumb(
          crumbs: [
            BreadcrumbItem(content: 'Home', icon: Icons.home),
            BreadcrumbItem(content: 'Category',),
            BreadcrumbItem(content: 'Product',),
            BreadcrumbItem(content: 'Details'),
          ],
          customSeparator: Icon(Icons.chevron_right),
          onClick: (item){},
        );
      }
    ),
    Story(
      name: 'Atom/BreadCrumbs/With collapsed items',
      builder: (context){
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
Breadcrumb(
          crumbs: [
            BreadcrumbItem(content: 'Home', icon: Icons.home),
            BreadcrumbItem(content: 'Category',),
            BreadcrumbItem(content: 'Product',),
            BreadcrumbItem(content: 'Details'),
            BreadcrumbItem(content: 'Details 2'),
          ],
          maxItems: 3,
          expandText: '...',
          onClick: (item){},
        )
          ''');
        });
        return Breadcrumb(
          crumbs: [
            BreadcrumbItem(content: 'Home', icon: Icons.home),
            BreadcrumbItem(content: 'Category',),
            BreadcrumbItem(content: 'Product',),
            BreadcrumbItem(content: 'Details'),
            BreadcrumbItem(content: 'Details 2'),
          ],
          maxItems: 3,
          expandText: '...',
          onClick: (item){},
        );
      }
    ),
    Story(
        name: 'Atom/BreadCrumbs/With expanded text',
        builder: (context){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CodeViewProvider.of(context)?.updateCodeString('''
Breadcrumb(
            crumbs: [
              BreadcrumbItem(content: 'Home', icon: Icons.home),
              BreadcrumbItem(content: 'Category',),
              BreadcrumbItem(content: 'Product',),
              BreadcrumbItem(content: 'Details'),
              BreadcrumbItem(content: 'Details 2'),
            ],
            maxItems: 3,
            expandText: 'click to expand',
            onClick: (item){},
          )
          ''');
          });
          return Breadcrumb(
            crumbs: [
              BreadcrumbItem(content: 'Home', icon: Icons.home),
              BreadcrumbItem(content: 'Category',),
              BreadcrumbItem(content: 'Product',),
              BreadcrumbItem(content: 'Details'),
              BreadcrumbItem(content: 'Details 2'),
            ],
            maxItems: 3,
            expandText: 'click to expand',
            onClick: (item){},
          );
        }
    ),
    Story(
      name: 'Atom/BreadCrumbs/Custom styles',
      builder: (context){
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString('''
Breadcrumb(
          crumbs: [
            BreadcrumbItem(content: 'Home', icon: Icons.home),
            BreadcrumbItem(content: 'Category',),
            BreadcrumbItem(content: 'Product',),
            BreadcrumbItem(content: 'Details'),
          ],
          onClick: (item){},
          themeData: const BreadcrumbThemeData().copyWith(
            activeTextStyle: const TextStyle(color: Colors.red),
            separatorTextStyle: const TextStyle(color: Colors.blue),
          ),
        )
          ''');
        });
        return Breadcrumb(
          crumbs: [
            BreadcrumbItem(content: 'Home', icon: Icons.home),
            BreadcrumbItem(content: 'Category',),
            BreadcrumbItem(content: 'Product',),
            BreadcrumbItem(content: 'Details'),
          ],
          onClick: (item){},
          themeData: const BreadcrumbThemeData().copyWith(
            activeTextStyle: const TextStyle(color: Colors.red),
            separatorTextStyle: const TextStyle(color: Colors.blue),
          ),
        );
      }
    ),
  ];
}