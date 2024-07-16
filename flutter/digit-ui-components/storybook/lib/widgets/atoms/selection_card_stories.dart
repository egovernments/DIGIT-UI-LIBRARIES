import 'package:digit_ui_components/widgets/atoms/selection_card.dart';
import 'package:digit_ui_components/widgets/atoms/tool_tip.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';

List<Story> selectionCardStories() {
  return [
    Story(
      name: 'Atom/Selection Card/Default',
      builder: (context) => SelectionBox(
        options: [
          SelectionOption(name: 'Option 1', code: '001'),
          SelectionOption(name: 'Option 2', code: '002'),
          SelectionOption(name: 'Option 3', code: '003'),
          SelectionOption(name: 'Option 4', code: '004'),
        ],
        onSelectionChanged: (selectedOptions) {
          print('Selected options: ${selectedOptions.map((e) => e.name).toList()}');
        },
      ),
    ),
    Story(
      name: 'Atom/Selection Card/With prefix icon',
      builder: (context) => SelectionBox(
        options: [
          SelectionOption(name: 'Option 1sdfffffffffffffffff', code: '001', prefixIcon: Icons.add, ),
          SelectionOption(name: 'Option 2sdffffffffffff', code: '002', prefixIcon: Icons.add,),
          SelectionOption(name: 'Option 3sdffffffffffffff', code: '003', prefixIcon: Icons.add,),
          SelectionOption(name: 'Option 4sdfffffffffffffffff', code: '004'),
        ],
        onSelectionChanged: (selectedOptions) {
          print('Selected options: ${selectedOptions.map((e) => e.name).toList()}');
        },
      ),
    ),
    Story(
      name: 'Atom/Selection Card/With suffix icon',
      builder: (context) => SelectionBox(
        options: [
          SelectionOption(name: 'Option 1sdfffffffffffffffff', code: '001', suffixIcon: Icons.add, ),
          SelectionOption(name: 'Option 2sdffffffffffff', code: '002', suffixIcon: Icons.add,),
          SelectionOption(name: 'Option 3sdffffffffffffff', code: '003', suffixIcon: Icons.add,),
          SelectionOption(name: 'Option 4sdfffffffffffffffff', code: '004'),
        ],
        onSelectionChanged: (selectedOptions) {
          print('Selected options: ${selectedOptions.map((e) => e.name).toList()}');
        },
      ),
    ),
    Story(
      name: 'Atom/Selection Card/With long label',
      builder: (context) => SelectionBox(
        options: [
          SelectionOption(name: 'Option 1sdfffffffffffffffff1sdfffffffffffffffff1sdfffffffffffffffff', code: '001', suffixIcon: Icons.add, ),
          SelectionOption(name: 'Option 2sdffffffffffff1sdfffffffffffffffff1sdfffffffffffffffff1sdfffffffffffffffff', code: '002', suffixIcon: Icons.add,),
          SelectionOption(name: 'Option 3sdffffffffffffff1sdfffffffffffffffff1sdfffffffffffffffff1sdfffffffffffffffff1sdfffffffffffffffff1sdfffffffffffffffff1sdfffffffffffffffff1sdfffffffffffffffff4sdfffffffffffffffff4sdfffffffffffffffff', code: '003', suffixIcon: Icons.add,),
          SelectionOption(name: 'Option 4sdfffffffffffffffff', code: '004'),
        ],
        onSelectionChanged: (selectedOptions) {
          print('Selected options: ${selectedOptions.map((e) => e.name).toList()}');
        },
      ),
    ),
    Story(
      name: 'Atom/Selection Card/With defined width',
      builder: (context) => SelectionBox(
        width: 200,
        options: [
          SelectionOption(name: 'Option 1sdfffffffffffffffff1sdfffffffffffffffff1sdfffffffffffffffff', code: '001', suffixIcon: Icons.add, ),
          SelectionOption(name: 'Option 2sdffffffffffff1sdfffffffffffffffff1sdfffffffffffffffff1sdfffffffffffffffff', code: '002', suffixIcon: Icons.add,),
          SelectionOption(name: 'Option 3sdffffffffffffff1sdfffffffffffffffff1sdfffffffffffffffff1sdfffffffffffffffff1sdfffffffffffffffff1sdfffffffffffffffff1sdfffffffffffffffff1sdfffffffffffffffff4sdfffffffffffffffff4sdfffffffffffffffff', code: '003', suffixIcon: Icons.add,),
          SelectionOption(name: 'Option 4sdfffffffffffffffff', code: '004'),
        ],
        onSelectionChanged: (selectedOptions) {
          print('Selected options: ${selectedOptions.map((e) => e.name).toList()}');
        },
      ),
    ),
    Story(
      name: 'Atom/Selection Card/With error Message',
      builder: (context) => SelectionBox(
        width: 200,
        options: [
          SelectionOption(name: 'Option 1sdfffffffffffffffff1sdfffffffffffffffff1sdfffffffffffffffff', code: '001', suffixIcon: Icons.add, ),
          SelectionOption(name: 'Option 2sdffffffffffff1sdfffffffffffffffff1sdfffffffffffffffff1sdfffffffffffffffff', code: '002', suffixIcon: Icons.add,),
          SelectionOption(name: 'Option 3sdffffffffffffff1sdfffffffffffffffff1sdfffffffffffffffff1sdfffffffffffffffff1sdfffffffffffffffff1sdfffffffffffffffff1sdfffffffffffffffff1sdfffffffffffffffff4sdfffffffffffffffff4sdfffffffffffffffff', code: '003', suffixIcon: Icons.add,),
          SelectionOption(name: 'Option 4sdfffffffffffffffff', code: '004'),
        ],
        onSelectionChanged: (selectedOptions) {
          print('Selected options: ${selectedOptions.map((e) => e.name).toList()}');
        },
        errorMessage: 'Selection is required',
      ),
    ),
    Story(
      name: 'Atom/Selection Card/Hcm Figma',
      builder: (context) => Container(
        width: 360,
        margin: const EdgeInsets.all(16),
        child: Column(
          children: [
            SelectionBox(
              options: [
                SelectionOption(name: 'Incompatible', code: '001',),
                SelectionOption(name: 'Refused', code: '002',),
                SelectionOption(name: 'Sick', code: '003',),
                SelectionOption(name: 'Funeral', code: '004'),
              ],
              onSelectionChanged: (selectedOptions) {
                print('Selected options: ${selectedOptions.map((e) => e.name).toList()}');
              },
            ),
            const SizedBox(height: 8,),
            SelectionBox(
              options: [
                SelectionOption(name: 'Sumishield', code: '001',),
                SelectionOption(name: 'Fludora', code: '002',),
                SelectionOption(name: 'Delt', code: '003',),
                SelectionOption(name: 'Acetellic', code: '004'),
                SelectionOption(name: 'Dot', code: '005',),
                SelectionOption(name: 'Bendiocarb', code: '006'),
              ],
              onSelectionChanged: (selectedOptions) {
                print('Selected options: ${selectedOptions.map((e) => e.name).toList()}');
              },
            ),
            const SizedBox(height: 8,),
            SelectionBox(
              options: [
                SelectionOption(name: 'Cement', code: '001',),
                SelectionOption(name: 'Reeds', code: '002',),
                SelectionOption(name: 'Clay', code: '003',),
                SelectionOption(name: 'Metal / Glass', code: '004'),
              ],
              onSelectionChanged: (selectedOptions) {
                print('Selected options: ${selectedOptions.map((e) => e.name).toList()}');
              },
            ),
            const SizedBox(height: 8,),
            SelectionBox(
              options: [
                SelectionOption(name: 'Yes', code: '001',),
                SelectionOption(name: 'No', code: '002',),
              ],
              onSelectionChanged: (selectedOptions) {
                print('Selected options: ${selectedOptions.map((e) => e.name).toList()}');
              },
            ),
          ],
        ),
      ),
    ),
    Story(
      name: 'Atom/Selection Card/Hcm Figma without multiple selection',
      builder: (context) => Container(
        width: 360,
        margin: const EdgeInsets.all(16),
        child: Column(
          children: [
            SelectionBox(
              allowMultipleSelection: false,
              options: [
                SelectionOption(name: 'Incompatible', code: '001',),
                SelectionOption(name: 'Refused', code: '002',),
                SelectionOption(name: 'Sick', code: '003',),
                SelectionOption(name: 'Funeral', code: '004'),
              ],
              onSelectionChanged: (selectedOptions) {
                print('Selected options: ${selectedOptions.map((e) => e.name).toList()}');
              },
            ),
            const SizedBox(height: 8,),
            SelectionBox(
              allowMultipleSelection: false,
              options: [
                SelectionOption(name: 'Sumishield', code: '001',),
                SelectionOption(name: 'Fludora', code: '002',),
                SelectionOption(name: 'Delt', code: '003',),
                SelectionOption(name: 'Acetellic', code: '004'),
                SelectionOption(name: 'Dot', code: '005',),
                SelectionOption(name: 'Bendiocarb', code: '006'),
              ],
              onSelectionChanged: (selectedOptions) {
                print('Selected options: ${selectedOptions.map((e) => e.name).toList()}');
              },
            ),
            const SizedBox(height: 8,),
            SelectionBox(
              allowMultipleSelection: false,
              options: [
                SelectionOption(name: 'Cement', code: '001',),
                SelectionOption(name: 'Reeds', code: '002',),
                SelectionOption(name: 'Clay', code: '003',),
                SelectionOption(name: 'Metal / Glass', code: '004'),
              ],
              onSelectionChanged: (selectedOptions) {
                print('Selected options: ${selectedOptions.map((e) => e.name).toList()}');
              },
            ),
            const SizedBox(height: 8,),
            SelectionBox(
              allowMultipleSelection: false,
              options: [
                SelectionOption(name: 'Yes', code: '001',),
                SelectionOption(name: 'No', code: '002',),
              ],
              onSelectionChanged: (selectedOptions) {
                print('Selected options: ${selectedOptions.map((e) => e.name).toList()}');
              },
            ),
          ],
        ),
      ),
    ),
  ];
}