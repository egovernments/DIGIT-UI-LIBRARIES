import 'package:digit_components/enum/app_enums.dart';
import 'package:digit_components/models/DropdownModels.dart';
import 'package:digit_components/models/RadioButtonModel.dart';
import 'package:digit_components/models/TreeModel.dart';
import 'package:digit_components/models/toggleButtonModel.dart';
import 'package:digit_components/theme/digit_theme.dart';
import 'package:digit_components/utils/validators/validator.dart';
import 'package:digit_components/widgets/atoms/digit_button.dart';
import 'package:digit_components/widgets/atoms/digit_checkbox.dart';
import 'package:digit_components/widgets/atoms/digit_date_form_input.dart';
import 'package:digit_components/widgets/atoms/digit_dropdown_input.dart';
import 'package:digit_components/widgets/atoms/digit_location_form_input.dart';
import 'package:digit_components/widgets/atoms/digit_multiselect_dropdown.dart';
import 'package:digit_components/widgets/atoms/digit_numeric_form_input.dart';
import 'package:digit_components/widgets/atoms/digit_password_form_input.dart';
import 'package:digit_components/widgets/atoms/digit_radio_list.dart';
import 'package:digit_components/widgets/atoms/digit_search_form_input.dart';
import 'package:digit_components/widgets/atoms/digit_text_area_form_input.dart';
import 'package:digit_components/widgets/atoms/digit_text_form_input.dart';
import 'package:digit_components/widgets/atoms/digit_time_form_input.dart';
import 'package:digit_components/widgets/atoms/digit_toggle_list.dart';
import 'package:digit_components/widgets/atoms/digit_tree_select_dropdown.dart';
import 'package:digit_components/widgets/scrollable_content.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';


final List<TreeNode> Nodes = [
  TreeNode('A', 'A', [
    TreeNode('A.A1', 'A1', [
      TreeNode('A.A1.A3', 'A3', [
        TreeNode('A.A1.A3.A5', 'A5', []),
        TreeNode('A.A1.A3.A6', 'A6', []),
      ]),
      TreeNode('A.A1.A4', 'A4', []),
    ]),
    TreeNode('A.A2', 'A2', []),
  ]),
  TreeNode('B', 'B', [
    TreeNode('B.B1', 'B1', []),
    TreeNode('B.B2', 'B2', []),
  ]),
  TreeNode('C', 'C', [
    TreeNode('C.C1', 'C1', []),
    TreeNode('C.C2', 'C2', []),
  ]),
  TreeNode('D', 'D', [
    TreeNode('D.D1', 'D1', []),
    TreeNode('D.D2', 'D2', []),
  ]),
];

final TreeSelectController<int> _controller = TreeSelectController();
final controller = MultiSelectController<int>();

void main() {
  /// Here we set the URL strategy for our web app.
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Custom Text Field Example',
      theme: DigitTheme.instance.mobileTheme,
      home: const MyHomePage(title: 'Digit Components Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({required this.title, super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(widget.title, textAlign: TextAlign.center,),
        ),
        body:ScrollableContent(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DigitTextFormInput(
                    label: "Text Field",
                    initialValue: 'value',
                    controller: TextEditingController(),
                    innerLabel: 'label',
                    helpText: 'help text',
                    charCount: true,
                    validations: [
                      Validator(ValidatorType.maxLength, 10,
                          errorMessage: 'Maximum length is 10.'),
                      Validator(ValidatorType.pattern, r'^[a-zA-Z0-9]+$',
                          errorMessage: 'Invalid format.'),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DigitTextAreaFormInput(
                    label: "Text Area",
                    controller: TextEditingController(),
                    innerLabel: 'label',
                    helpText: 'help text',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DigitDateFormInput(
                    label: "Date Field",
                    controller: TextEditingController(),
                    innerLabel: 'innerlabel',
                    helpText: 'help text',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DigitTimeFormInput(
                    label: "Time Field",
                    controller: TextEditingController(),
                    innerLabel: 'innerlabel',
                    helpText: 'help text',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DigitSearchFormInput(
                    label: "Search Field",
                    controller: TextEditingController(),
                    innerLabel: 'innerlabel',
                    helpText: 'help text',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DigitPasswordFormInput(
                    label: "password Field",
                    controller: TextEditingController(),
                    innerLabel: 'innerlabel',
                    helpText: 'help text',
                    validations: [
                      Validator(ValidatorType.minLength, 6,
                          errorMessage:
                          'Password must be at least 6 characters.'),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DigitTextFormInput(
                    label: "Text Field With Suffix Icon",
                    controller: TextEditingController(),
                    innerLabel: 'innerlabel',
                    helpText: 'help text',
                    suffixIcon: Icons.currency_rupee_sharp,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DigitNumericFormInput(
                    label: "Numeric Field",
                    controller: TextEditingController(),
                    innerLabel: 'innerlabel',
                    helpText: 'help text',
                    initialValue: '0',
                    step: 1,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DigitLocationFormInput(
                    label: "Location Field",
                    controller: TextEditingController(),
                    innerLabel: 'innerlabel',
                    helpText: 'help text',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text('Dropdown Varients'),
                  DigitDropdown<int>(
                    onChange: (String value, String index) => {},
                    textEditingController: TextEditingController(),
                    items: const [
                      DropdownItem(
                        name: 'first',
                        code: '1',
                        description: 'description for first one',
                        profileImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzBXNuO6PezhC18aYH_2cYtS0I7KbxoKYdwA&usqp=CAU',
                        ),
                      ),
                      DropdownItem(
                        name: 'second',
                        code: '2',
                        description: 'description for second one',
                        profileImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzBXNuO6PezhC18aYH_2cYtS0I7KbxoKYdwA&usqp=CAU',
                        ),
                      ),
                      DropdownItem(
                        name: 'third',
                        code: '3',
                        description: 'description for third one',
                        profileImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzBXNuO6PezhC18aYH_2cYtS0I7KbxoKYdwA&usqp=CAU',
                        ),
                      ),
                      DropdownItem(
                        name: 'fourth',
                        code: '4',
                        description: 'description for fourth one',
                        profileImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzBXNuO6PezhC18aYH_2cYtS0I7KbxoKYdwA&usqp=CAU',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DigitDropdown<int>(
                    onChange: (String value, String index) => {},
                    textEditingController: TextEditingController(),
                    items: [
                      'one',
                      'two',
                      'three',
                      'four',
                    ]
                        .asMap()
                        .entries
                        .map(
                          (item) => DropdownItem(
                        name: item.value,
                        code: item.key.toString(),
                      ),
                    )
                        .toList(),
                  ),
                  const SizedBox(height: 16,),
                  DigitDropdown<int>(
                    onChange: (String value, String index) => {},
                    textEditingController: TextEditingController(),
                    textIcon: Icons.article,
                    items: [
                      'one',
                      'two',
                      'three',
                      'four',
                      'five',
                      'six',
                      'seven',
                      'eight',
                    ]
                        .asMap()
                        .entries
                        .map(
                          (item) => DropdownItem(
                        name: item.value,
                        code: item.key.toString(),
                        description: 'description for ${item.value} one',
                      ),
                    )
                        .toList(),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DigitDropdown(
                    onChange: (String value, String type) => {},
                    textEditingController: TextEditingController(),
                    dropdownType: DropdownType.nestedSelect,
                    selectedOption: const DropdownItem(
                      name: 'one',
                      code: '1',
                      type: 'group B',
                    ),
                    items: const [
                      DropdownItem(
                        name: 'one',
                        code: '1',
                        type: 'group B',
                      ),
                      DropdownItem(
                        name: 'two',
                        code: '2',
                        type: 'group A',
                      ),
                      DropdownItem(
                        name: 'three',
                        code: '3',
                        type: 'group B',
                      ),
                      DropdownItem(
                        name: 'four',
                        code:'4',
                        type: 'group A',
                      ),
                      DropdownItem(
                        name: 'five',
                        code: '5',
                        type: 'group B',
                      ),
                      DropdownItem(
                        name: 'six',
                        code: '6',
                        type: 'group A',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text('MultiSelect Dropdowns'),
                  MultiSelectDropDown<int>(
                    onOptionSelected:
                        (List<DropdownItem> selectedOptions) {},
                    options: const [
                      DropdownItem(code: '1', name: 'first'),
                      DropdownItem(
                          code: '2', name: 'second'),
                      DropdownItem(code: '3', name: 'third'),
                      DropdownItem(code: '4', name: 'four'),
                      DropdownItem(code: '5', name: 'five'),
                    ],
                    selectionType: SelectionType.multiSelect,
                  ),
                  const SizedBox(height: 8,),
                  MultiSelectDropDown<int>(
                    onOptionSelected:
                        (List<DropdownItem> selectedOptions) {},
                    options: const [
                      DropdownItem(code: '1', name: 'first'),
                      DropdownItem(
                          code: '2', name: 'second'),
                      DropdownItem(code: '3', name: 'third'),
                      DropdownItem(code: '4', name: 'four'),
                      DropdownItem(code: '5', name: 'five'),
                    ],
                    selectionType: SelectionType.multiSelect,
                  ),
                  const SizedBox(height: 8,),
                  MultiSelectDropDown<int>(
                    onOptionSelected:
                        (List<DropdownItem> selectedOptions) {},
                    selectedOptions: const [DropdownItem(
                      code: '1',
                      name: 'first',
                      description: 'description',
                    ),],
                    options: const [
                      DropdownItem(
                        code: '1',
                        name: 'first',
                        description: 'description',
                      ),
                      DropdownItem(
                        code: '2',
                        name: 'second',
                        description: 'description',
                      ),
                      DropdownItem(
                        code: '3',
                        name: 'third',
                        description: 'description',
                      ),
                      DropdownItem(
                        code: '4',
                        name: 'four',
                        description: 'description',
                      ),
                      DropdownItem(
                        code: '5',
                        name: 'five',
                        description: 'description',
                      ),
                    ],
                    selectionType: SelectionType.multiSelect,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text('TreeSelect Dropdowns'),
                  TreeSelectDropDown<int>(
                    onOptionSelected: (List<TreeNode> selectedOptions) {
                      // print(selectedOptions);
                      for (TreeNode node in selectedOptions) {
                        // print("Node: ${node.value}");
                      }
                    },
                    options: Nodes,
                    treeSelectionType: TreeSelectionType.MultiSelect,
                    controller: _controller,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TreeSelectDropDown<int>(
                    onOptionSelected: (List<TreeNode> selectedOptions) {
                      // print(selectedOptions);
                      for (TreeNode node in selectedOptions) {
                        // print("Node: ${node.value}");
                      }
                    },
                    options: Nodes,
                    treeSelectionType: TreeSelectionType.singleSelect,
                  ),
                  const SizedBox(
                    height: 8,
                  ),

                  DigitRadioList(
                    onChanged: (value) {},
                    radioButtons: [
                      RadioButtonModel(
                        code: '1',
                        name: 'One',
                      ),
                      RadioButtonModel(code: '2', name: 'Two'),
                      RadioButtonModel(code: '3', name: 'Three'),
                      // Add more radio buttons as needed
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DigitToggleList(
                    toggleButtons: [
                      ToggleButtonModel(
                          name: 'Toggle 1',
                          key: 'key1',
                          onSelected: (value) {}),
                      ToggleButtonModel(
                          name: 'Toggle 2',
                          key: 'key2',
                          onSelected: (value) {}),
                      ToggleButtonModel(
                          name: 'Toggle 3',
                          key: 'key3',
                          onSelected: (value) {}),
                    ],
                    selectedIndex: 1,
                    onChanged: (selectedValues) {},
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DigitButton(
                    prefixIcon: Icons.add,
                    label: 'p',
                    onPressed: () {},
                    type: ButtonType.primary,
                  ),
                  const SizedBox(height: 8),
                  DigitButton(
                    label: 'secondary Button',
                    onPressed: () {},
                    type: ButtonType.secondary,
                  ),
                  const SizedBox(height: 8),
                  DigitButton(
                    label: 'link',
                    onPressed: () {},
                    type: ButtonType.link,
                  ),
                  const SizedBox(height: 8),
                  DigitButton(
                    label: 'tertiary Button',
                    onPressed: () {},
                    type: ButtonType.tertiary,
                  ),
                  const SizedBox(height: 8,),
                  DigitCheckbox(
                    label: 'checkbox',
                    value: false,
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
          ],
        ),
    );

  }

}

