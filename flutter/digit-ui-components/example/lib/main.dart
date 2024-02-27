import 'package:digit_components/constants/AppView.dart';
import 'package:digit_components/enum/app_enums.dart';
import 'package:digit_components/models/DropdownModels.dart';
import 'package:digit_components/models/RadioButtonModel.dart';
import 'package:digit_components/models/TreeModel.dart';
import 'package:digit_components/models/toggleButtonModel.dart';
import 'package:digit_components/theme/digit_theme.dart';
import 'package:digit_components/theme/typography.dart';
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

final controller1 = TextEditingController();
final controller2 = TextEditingController();
final controller3 = TextEditingController();
final controller4 = TextEditingController();
final controller5 = TextEditingController();
final controller6 = TextEditingController();
final controller7 = TextEditingController();
final controller8 = TextEditingController();
final controller9 = TextEditingController();
final controller10 = TextEditingController();
final controller11 = TextEditingController();
final controller12 = TextEditingController();
final controller13 = TextEditingController();
final controller14 = TextEditingController();
final controller15 = TextEditingController();
final controller16 = TextEditingController();
final controller17 = TextEditingController();
final controller18 = TextEditingController();
final controller19 = TextEditingController();
final controller20 = TextEditingController();
final controller21 = TextEditingController();
final controller22 = TextEditingController();
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
    ThemeData _getTypography() {
      // Get screen width from MediaQuery
      bool isMobile = AppView.isMobileView(MediaQuery.of(context).size.width);
      bool isTab = AppView.isMobileView(MediaQuery.of(context).size.width);
      bool isDesktop = AppView.isMobileView(MediaQuery.of(context).size.width);

      // Adjust the threshold as needed
      if (isDesktop) {
        // Desktop
        return DigitTheme.instance.desktopTheme;
      } else if (isTab) {
        // Tablet
        return DigitTheme.instance.tabTheme;
      } else {
        // Mobile
        return DigitTheme.instance.mobileTheme;
      }
    }
    return MaterialApp(
      title: 'Digit UI Flutter',
      theme: _getTypography().copyWith(
          appBarTheme: AppBarTheme(
        backgroundColor: DigitTheme.instance.colorScheme.secondary,
      )),
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

  bool showAllVariantsOfInputField = false;
  bool showAllVariantsOfDateField = false;
  bool showAllVariantsOfTimeField = false;
  bool showAllVariantsOfSearchField = false;
  bool showAllVariantsOfPasswordField = false;
  bool showAllVariantsOfNumericField = false;
  bool showAllVariantsOfTextAreaField = false;
  bool showSearchResult = false;
  late String searchResultValue;

  // button variants
  bool showAllVariantsPrimaryButton = false;
  bool showAllVariantsOfSecondaryButton = false;
  bool showAllVariantsOfTertiaryButton = false;
  bool showAllVariantsOfLink = false;

  bool showAllVariantsOfCheckbox = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
        ),
      ),
      body: ScrollableContent(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DigitTextFormInput(
                  label: "Text Field",
                  controller: controller1,
                  innerLabel: 'label',
                  info: true,
                  infoText: 'this is infoText',
                  helpText: 'help text',
                  charCount: true,
                ),
                const SizedBox(
                  height: 8,
                ),
                DigitCheckbox(
                  label: "Show All The Variants Of Text Field",
                  onChanged: (value) {
                      setState(() {
                        showAllVariantsOfInputField = value;
                      });
                  },
                ),
                if(showAllVariantsOfInputField)
                  Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      DigitTextFormInput(
                        label: "Text Field With Validation",
                        controller: controller2,
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
                      DigitTextFormInput(
                        label: "Text Field With Disabled State",
                        controller: TextEditingController(),
                        innerLabel: 'label',
                        helpText: 'help text',
                        isDisabled: true,
                        charCount: true,
                      ),
                      DigitTextFormInput(
                        label: "Text Field With Read Only State",
                        controller: TextEditingController(),
                        innerLabel: 'label',
                        initialValue: 'ReadOnly',
                        helpText: 'help text',
                        isDisabled: true,
                        charCount: true,
                        readOnly: true,
                      ),
                      DigitTextFormInput(
                        label: "Text Field With Suffix Icon",
                        controller: controller3,
                        innerLabel: 'innerlabel',
                        helpText: 'help text',
                        suffixText: '@',
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 8,
                ),
                DigitTextAreaFormInput(
                  controller: TextEditingController(),
                  maxLine: 10000,
                  label: "Text Area",
                  innerLabel: 'label',
                  helpText: 'help text',
                ),
                const SizedBox(
                  height: 8,
                ),
                DigitCheckbox(
                  label: "Show All The Variants Of Text Area Field",
                  onChanged: (value) {
                      setState(() {
                        showAllVariantsOfTextAreaField = value;
                      });
                  },
                ),
                if(showAllVariantsOfTextAreaField)
                  // Column(
                  //   children: [
                  //     const SizedBox(
                  //       height: 8,
                  //     ),
                  //     DigitTextAreaFormInput(
                  //       label: "Text Field With Validation",
                  //       controller: controller5,
                  //       innerLabel: 'label',
                  //       helpText: 'help text',
                  //       charCount: true,
                  //       validations: [
                  //         Validator(ValidatorType.maxLength, 10,
                  //             errorMessage: 'Maximum length is 10.'),
                  //         Validator(ValidatorType.pattern, r'^[a-zA-Z0-9]+$',
                  //             errorMessage: 'Invalid format.'),
                  //       ],
                  //     ),
                  //     DigitTextAreaFormInput(
                  //       // label: "Text Field With Disabled State",
                  //       // controller: TextEditingController(),
                  //       // innerLabel: 'label',
                  //       // helpText: 'help text',
                  //       // isDisabled: true,
                  //       // charCount: true,
                  //     ),
                  //     DigitTextAreaFormInput(
                  //       label: "Text Field With Read Only State",
                  //       controller: TextEditingController(),
                  //       innerLabel: 'label',
                  //       initialValue: 'ReadOnly',
                  //       helpText: 'help text',
                  //       isDisabled: true,
                  //       charCount: true,
                  //       readOnly: true,
                  //     ),
                  //   ],
                  // ),
                const SizedBox(
                  height: 8,
                ),
                DigitDateFormInput(
                  label: "Date Field",
                  controller: controller6,
                  innerLabel: 'innerlabel',
                  helpText: 'help text',
                ),
                const SizedBox(height: 8,),
                DigitCheckbox(
                  label: "Show All The Variants Of Date Field",
                  onChanged: (value) {
                      setState(() {
                        showAllVariantsOfDateField = value;
                      });
                  },
                ),
                if(showAllVariantsOfDateField)
                  Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      DigitDateFormInput(
                        label: "Date Field With Disabled State",
                        controller: TextEditingController(),
                        innerLabel: 'innerlabel',
                        helpText: 'help text',
                        isDisabled: true,
                      ),
                      DigitDateFormInput(
                        label: "Date Field with Current Date as Max Date",
                        controller: controller7,
                        lastDate: DateTime.now(),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 8,
                ),
                DigitTimeFormInput(
                  label: "Time Field",
                  controller: controller8,
                  innerLabel: 'innerlabel',
                  helpText: 'help text',
                ),
                const SizedBox(height: 8,),
                DigitCheckbox(
                  label: "Show All The Variants Of Time Field",
                  onChanged: (value) {
                      setState(() {
                        showAllVariantsOfTimeField = value;
                      });
                  },
                ),
                if(showAllVariantsOfTimeField)
                  Column(
                    children: [
                      const SizedBox(height: 8,),
                      DigitTimeFormInput(
                        label: "Time Field With Disabled State",
                        controller: TextEditingController(),
                        innerLabel: 'innerlabel',
                        helpText: 'help text',
                        isDisabled: true,
                      ),
                      DigitTimeFormInput(
                        label: "Time Field with ReadOnly State",
                        controller: controller9,
                        innerLabel: 'innerlabel',
                        readOnly: true,
                        initialValue: '11:56 PM',
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 8,
                ),
                DigitSearchFormInput(
                  label: "Search Field",
                  controller: controller10,
                  innerLabel: 'innerlabel',
                  helpText: 'help text',
                ),
                const SizedBox(height: 8,),
                DigitCheckbox(
                  label: "Show All The Variants Of Search Field",
                  onChanged: (value) {
                      setState(() {
                        showAllVariantsOfSearchField = value;
                      });
                  },
                ),
                if(showAllVariantsOfSearchField)
                  Column(
                    children: [
                      const SizedBox(height: 8,),
                      DigitSearchFormInput(
                        label: "Search Field With Disabled State",
                        controller: TextEditingController(),
                        innerLabel: 'innerlabel',
                        helpText: 'help text',
                      ),
                      DigitSearchFormInput(
                        label: "Search Field With on SearchIcon click",
                        controller: controller11,
                        innerLabel: 'innerlabel',
                        helpText: 'help text',
                        onSuffixTap: (value){
                          setState(() {
                            showSearchResult = true;
                            searchResultValue = value;
                          });
                        },
                      ),
                      if(showSearchResult)
                        Text(searchResultValue),
                    ],
                  ),
                const SizedBox(
                  height: 8,
                ),
                DigitPasswordFormInput(
                  label: "password Field",
                  controller: controller12,
                  innerLabel: 'innerlabel',
                  helpText: 'help text',
                  charCount: true,
                  info: true,
                  infoText: 'this is infoText',
                ),
                const SizedBox(height: 8,),
                DigitCheckbox(
                  label: "Show All The Variants Of Password Field",
                  onChanged: (value) {
                      setState(() {
                        showAllVariantsOfPasswordField = value;
                      });
                  },
                ),
                if(showAllVariantsOfPasswordField)
                  Column(
                    children: [
                      const SizedBox(height: 8,),
                      DigitPasswordFormInput(
                        label: "password Field With min 8 char validation",
                        controller: controller13,
                        innerLabel: 'innerlabel',
                        helpText: 'help text',
                        validations: [
                          Validator(ValidatorType.minLength, 8,
                              errorMessage:
                              'Password must be at least 8 characters.'),
                        ],
                      ),
                      DigitPasswordFormInput(
                        label: "password Field",
                        controller: controller14,
                        innerLabel: 'innerlabel',
                        initialValue: 'initialValue',
                        helpText: 'help text',
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 8,
                ),
                DigitNumericFormInput(
                  label: "Numeric Field",
                  controller: controller15,
                  innerLabel: 'innerlabel',
                  helpText: 'help text',
                  initialValue: '0',
                  step: 1,
                ),
                const SizedBox(height: 8,),
                DigitCheckbox(
                  label: "Show All The Variants Of Numeric Field",
                  onChanged: (value) {
                      setState(() {
                        showAllVariantsOfNumericField = value;
                      });
                  },
                ),
                if(showAllVariantsOfNumericField)
                  Column(
                    children: [
                      const SizedBox(height: 8,),
                      DigitNumericFormInput(
                        label: "Numeric Field With Max value 100 and step 5 and Min value -10",
                        controller: controller16,
                        innerLabel: 'innerlabel',
                        helpText: 'help text',
                        initialValue: '0',
                        step: 5,
                        maxValue: 100,
                        minValue: -10,
                      ),
                      DigitNumericFormInput(
                        label: "Numeric Field with Disabled State",
                        controller: TextEditingController(),
                        innerLabel: 'innerlabel',
                        helpText: 'help text',
                        isDisabled: true,
                      ),
                      DigitNumericFormInput(
                        label: "Numeric Field With ReadOnly State",
                        controller: TextEditingController(),
                        innerLabel: 'innerlabel',
                        helpText: 'help text',
                        initialValue: '20',
                        step: 1,
                        readOnly: true,
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 8,
                ),
                DigitLocationFormInput(
                  label: "Location Field",
                  controller: controller17,
                  innerLabel: 'innerlabel',
                  helpText: 'help text',
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text('Dropdown Varients'),
                DigitDropdown<int>(
                  onChange: (String value, String index) => {},
                  textEditingController: controller18,
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
                  textEditingController: controller19,
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
                const SizedBox(
                  height: 16,
                ),
                DigitDropdown<int>(
                  onChange: (String value, String index) => {},
                  textEditingController: controller20,
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
                  textEditingController: controller21,
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
                      code: '4',
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
                  onOptionSelected: (List<DropdownItem> selectedOptions) {},
                  options: const [
                    DropdownItem(code: '1', name: 'first'),
                    DropdownItem(code: '2', name: 'second'),
                    DropdownItem(code: '3', name: 'third'),
                    DropdownItem(code: '4', name: 'four'),
                    DropdownItem(code: '5', name: 'five'),
                  ],
                  selectionType: SelectionType.multiSelect,
                ),
                const SizedBox(
                  height: 8,
                ),
                MultiSelectDropDown<int>(
                  onOptionSelected: (List<DropdownItem> selectedOptions) {},
                  options: const [
                    DropdownItem(code: '1', name: 'first', type: "Type A"),
                    DropdownItem(code: '2', name: 'second', type: "Type A"),
                    DropdownItem(code: '3', name: 'third', type: "Type A"),
                    DropdownItem(code: '4', name: 'four', type: "Type B"),
                    DropdownItem(code: '5', name: 'five', type: "Type B"),
                  ],
                  selectionType: SelectionType.nestedMultiSelect,
                ),
                const SizedBox(
                  height: 8,
                ),
                MultiSelectDropDown<int>(
                  onOptionSelected: (List<DropdownItem> selectedOptions) {},
                  selectedOptions: const [
                    DropdownItem(
                      code: '1',
                      name: 'first',
                      description: 'description',
                    ),
                  ],
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
                    ToggleButtonModel(name: 'Toggle 1', code: 'key1'),
                    ToggleButtonModel(name: 'Toggle 2', code: 'key2'),
                    ToggleButtonModel(name: 'Toggle 3', code: 'key3'),
                  ],
                  selectedIndex: 1,
                  onChanged: (selectedValues) {},
                ),
                const SizedBox(
                  height: 8,
                ),

                DigitButton(
                  label: 'Primary Button',
                  onPressed: () {},
                  type: ButtonType.primary,
                ),
                const SizedBox(height: 8),
                DigitCheckbox(label: 'Show All Variants Of Primary Button', onChanged: (value){
                  setState(() {
                    showAllVariantsPrimaryButton = value;
                  });
                }),
                if(showAllVariantsPrimaryButton)
                  Column(
                    children: [
                      const SizedBox(height: 8),
                      DigitButton(
                        label: 'Primary Button With Prefix Icon',
                        onPressed: () {},
                        type: ButtonType.primary,
                        prefixIcon: Icons.arrow_forward,
                      ),
                      const SizedBox(height: 8),
                      DigitButton(
                        label: 'Primary Button With Suffix Icon',
                        onPressed: () {},
                        type: ButtonType.primary,
                        suffixIcon: Icons.arrow_forward,
                      ),
                      const SizedBox(height: 8),
                      DigitButton(
                        label: 'Primary Button With Disabled State',
                        onPressed: () {},
                        type: ButtonType.primary,
                        isDisabled: true,
                      ),
                    ],
                  ),
                const SizedBox(height: 8),
                DigitButton(
                  label: 'secondary Button',
                  onPressed: () {},
                  type: ButtonType.secondary,
                ),
                const SizedBox(height: 8),
                DigitCheckbox(label: 'Show All Variants Of Secondary Button', onChanged: (value){
                  setState(() {
                    showAllVariantsOfSecondaryButton = value;
                  });
                }),
                if(showAllVariantsOfSecondaryButton)
                  Column(
                    children: [
                      const SizedBox(height: 8),
                      DigitButton(
                        label: 'Secondary Button With Prefix Icon',
                        onPressed: () {},
                        type: ButtonType.secondary,
                        prefixIcon: Icons.arrow_forward,
                      ),
                      const SizedBox(height: 8),
                      DigitButton(
                        label: 'Secondary Button With Suffix Icon',
                        onPressed: () {},
                        type: ButtonType.secondary,
                        suffixIcon: Icons.arrow_forward,
                      ),
                      const SizedBox(height: 8),
                      DigitButton(
                        label: 'Secondary Button With Disabled State',
                        onPressed: () {},
                        type: ButtonType.secondary,
                        isDisabled: true,
                      ),
                    ],
                  ),
                const SizedBox(height: 8),
                DigitButton(
                  label: 'tertiary Button',
                  onPressed: () {},
                  type: ButtonType.tertiary,
                ),
                const SizedBox(height: 8),
                DigitCheckbox(label: 'Show All Variants Of Tertiary Button', onChanged: (value){
                  setState(() {
                    showAllVariantsOfTertiaryButton = value;
                  });
                }),
                if(showAllVariantsOfTertiaryButton)
                  Column(
                    children: [
                      const SizedBox(height: 8),
                      DigitButton(
                        label: 'Tertiary Button With Prefix Icon',
                        onPressed: () {},
                        type: ButtonType.tertiary,
                        prefixIcon: Icons.arrow_forward,
                      ),
                      const SizedBox(height: 8),
                      DigitButton(
                        label: 'Tertiary Button With Suffix Icon',
                        onPressed: () {},
                        type: ButtonType.tertiary,
                        suffixIcon: Icons.arrow_forward,
                      ),
                      const SizedBox(height: 8),
                      DigitButton(
                        label: 'Tertiary Button With Disabled State',
                        onPressed: () {},
                        type: ButtonType.tertiary,
                        isDisabled: true,
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 8,
                ),
                DigitButton(
                  label: 'link',
                  onPressed: () {},
                  type: ButtonType.link,
                ),
                const SizedBox(height: 8),
                DigitCheckbox(label: 'Show All Variants Of Link', onChanged: (value){
                  setState(() {
                    showAllVariantsOfLink = value;
                  });
                }),
                if(showAllVariantsOfLink)
                  Column(
                    children: [
                      const SizedBox(height: 8),
                      DigitButton(
                        label: 'Link With Prefix Icon',
                        onPressed: () {},
                        type: ButtonType.link,
                        prefixIcon: Icons.arrow_forward,
                      ),
                      const SizedBox(height: 8),
                      DigitButton(
                        label: 'Link With Suffix Icon',
                        onPressed: () {},
                        type: ButtonType.link,
                        suffixIcon: Icons.arrow_forward,
                      ),
                      const SizedBox(height: 8),
                      DigitButton(
                        label: 'Link With Disabled State',
                        onPressed: () {},
                        type: ButtonType.link,
                        isDisabled: true,
                      ),
                    ],
                  ),
                const SizedBox(height: 8),
                DigitCheckbox(
                  label: 'checkbox',
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 8),
                DigitCheckbox(label: 'Show All Variants Of Checkbox', onChanged: (value){
                  setState(() {
                    showAllVariantsOfCheckbox = value;
                  });
                }),
                if(showAllVariantsOfCheckbox)
                  Column(
                    children: [
                      const SizedBox(height: 8),
                      DigitCheckbox(
                        label: 'CheckBox With Checked State',
                        value: true,
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 8),
                      DigitCheckbox(
                        label: 'Checkbox with Disabled State',
                        value: false,
                        disabled: true,
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 8),
                      DigitCheckbox(
                        label: 'Checkbox With Checked and Disabled State',
                        value: true,
                        disabled: true,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
