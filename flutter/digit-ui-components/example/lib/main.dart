import 'dart:convert';
import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/services/AppLocalization.dart';
import 'package:digit_ui_components/services/component_localization_delegate.dart';
import 'package:digit_ui_components/theme/ComponentTheme/toast_theme_data.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/theme/digit_theme_wrapper.dart';
import 'package:digit_ui_components/theme/theme_notifier.dart';
import 'package:digit_ui_components/utils/validators/validator.dart';
import 'package:digit_ui_components/widgets/atoms/digit_bread_crumbs.dart';
import 'package:digit_ui_components/widgets/atoms/digit_stepper.dart';
import 'package:digit_ui_components/widgets/atoms/digit_tab.dart';
import 'package:digit_ui_components/widgets/atoms/dropdown_wrapper.dart';
import 'package:digit_ui_components/widgets/atoms/info_DigitButtons.dart';
import 'package:digit_ui_components/widgets/atoms/input_wrapper.dart';
import 'package:digit_ui_components/widgets/atoms/switch.dart';
import 'package:digit_ui_components/widgets/atoms/timeline.dart';
import 'package:digit_ui_components/widgets/atoms/tooltip_2.dart';
import 'package:digit_ui_components/widgets/atoms/upload_image.dart';
import 'package:digit_ui_components/widgets/atoms/upload_popUp.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'localization.dart';

final List<TreeNode> Nodes = [
  TreeNode('A', 'A', [
    TreeNode('A: A1', 'A1', []),
    TreeNode('A: A2', 'A2', []),
    TreeNode('A: A3', 'A3', []),
  ]),
  TreeNode('B', 'B', [
    TreeNode('B: B1', 'B1', []),
    TreeNode('B: B2', 'B2', []),
  ]),
  TreeNode('C', 'C', [
    TreeNode('C: C1', 'C1', []),
    TreeNode('C:C2', 'C2', []),
  ]),
  TreeNode('D', 'D', [
    TreeNode('D: D1', 'D1', []),
    TreeNode('D: D2', 'D2', []),
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
final controller23 = TextEditingController();
final controller24 = TextEditingController();
final controller25 = TextEditingController();
final controller26 = TextEditingController();
final controller27 = TextEditingController();
final controller28 = TextEditingController();
final controller29 = TextEditingController();
final controller30 = TextEditingController();
final controller31 = TextEditingController();
final controller32 = TextEditingController();
final controller33 = TextEditingController();
final controller34 = TextEditingController();
final controller35 = TextEditingController();
final controller36 = TextEditingController();
final controller37 = TextEditingController();
final controller38 = TextEditingController();
final controller39 = TextEditingController();
final controller40 = TextEditingController();
final controller41 = TextEditingController();
final controller42 = TextEditingController();
final TreeSelectController<int> _controller = TreeSelectController();
final controller = MultiSelectController<int>();
final controllerM1 = MultiSelectController<int>();
int stepNumber = 0;

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
    return DigitThemeWrapper(
      initialThemeMode: ThemeMode.dark,
      materialAppBuilder: (context, themeData, themeMode) {
        return MaterialApp(
          themeMode: themeMode,
          theme: themeData,
          locale: const Locale("en","MZ"),
          supportedLocales: const [
            Locale('en', 'US'),
            Locale("en","MZ"),
            Locale('fr', 'Fr'),
          ],
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            ComponentLocalization.getDelegate(loadLocalizedStrings(), [
              Language('French', 'fr_MZ'),
              Language('Portuguese', 'pt_MZ'),
              Language('English', 'en_MZ'),
            ]),
          ],
          home: MyHomePage(title: 'Digit Components Page'),
        );
      },
    );
  }
}

Future<List> loadLocalizedStrings() async{
  String jsonString = await rootBundle.loadString('lib/localization_data.json');
  // Decode the JSON string
  List<dynamic> jsonList = jsonDecode(jsonString);

  // Convert the dynamic list to a list of LocalizedString objects
  return jsonList.map((jsonItem) => Localization.fromJson(jsonItem)).toList();
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({required this.title, super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  late Future<List> _localizationFuture;

  @override
  void initState() {
    // Initialize the Future to load the localization strings
    _localizationFuture = loadLocalizedStrings();
    ComponentLocalizationDelegate delegate = ComponentLocalizationDelegate(_localizationFuture, [Language('English', 'en_MZ')]);
    delegate.load(const Locale("en","MZ"));
    super.initState();
  }

  bool showAllVariantsOfInputField = false;
  bool showAllVariantsOfDateField = false;
  bool showAllVariantsOfTimeField = false;
  bool showAllVariantsOfSearchField = false;
  bool showAllVariantsOfPasswordField = false;
  bool showAllVariantsOfNumericField = false;
  bool showAllVariantsOfTextAreaField = false;
  bool showAllVariantsOfLocationField = false;
  bool showAllVariantsOfPrefixField = false;
  bool showAllVariantsOfSuffixField = false;
  bool showSearchResult = false;
  late String searchResultValue;
  bool showAllVariantsOfRadio = false;

  // DigitButton variants
  bool showAllVariantsPrimaryDigitButton = false;
  bool showAllVariantsOfSecondaryDigitButton = false;
  bool showAllVariantsOfTertiaryDigitButton = false;
  bool showAllVariantsOfLink = false;

  bool showAllVariantsOfDigitCheckbox = false;

  bool showAllVariantsOfDropdown = false;
  bool showAllVariantsOfMultiSelectDropdown = false;
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: _localizationFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the localization data to load, show a loading indicator
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // If an error occurs while loading localization data, show an error message
          return Center(child: Text('Error loading localization data'));
        } else if (snapshot.hasData) {
          // Once the localization data is loaded, build the UI
          return _buildContent();
        } else {
          // Handle any other unexpected cases
          return const Center(child: Text('Unexpected error occurred'));
        }
      },
    );
  }
  Widget _buildContent() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
        ),
      ),
      body: ScrollableContent(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomSwitch(
                  value: isSwitched,
                  label: 'Toggle to switch theme',
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                    final themeNotifier = context.read<ThemeNotifier>();
                    themeNotifier.setThemeMode(
                      themeNotifier.themeMode == ThemeMode.light
                          ? ThemeMode.dark
                          : ThemeMode.light,
                    );
                  },
                ),
                const SizedBox(
                  height: 32,
                ),
                ImageUploader(
                  onImagesSelected: (List<File> imageFile) {
                    // Handle the selected image file here
                    // print('Image selected: ${imageFile.path}');
                  },
                ),
                const SizedBox(height: 16,),
                DigitTabBar(
                  tabs: const ['Tab 1', 'Tab 2', 'Tab 3'],
                  initialIndex: 1, // Preselect the second tab
                  onTabSelected: (index) {
                    // Handle tab selection change
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                DigitTooltip(
                  tooltipContent: const Text(
                    'Hello, Tooltip!',
                    style: TextStyle(color: Colors.white),
                  ),
                  tooltipPosition: TooltipPosition.topStart,
                  child: Container(
                    color: Colors.blue,
                    padding: const EdgeInsets.all(16),
                    child: const Text('Tap me(top start)'),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                DigitTooltip(
                  tooltipContent: const Text(
                    'Hello, Tooltip!',
                    style: TextStyle(color: Colors.white),
                  ),
                  tooltipPosition: TooltipPosition.topCenter,
                  child: Container(
                    color: Colors.blue,
                    padding: const EdgeInsets.all(16),
                    child: const Text('Tap me(top center)'),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                DigitTooltip(
                  tooltipContent: const Text(
                    'Hello, Tooltip!',
                    style: TextStyle(color: Colors.white),
                  ),
                  tooltipPosition: TooltipPosition.topEnd,
                  child: Container(
                    color: Colors.blue,
                    padding: const EdgeInsets.all(16),
                    child: const Text('Tap me(top end)'),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                DigitTooltip(
                  tooltipContent: const Text(
                    'Hello, Tooltip!',
                    style: TextStyle(color: Colors.white),
                  ),
                  tooltipPosition: TooltipPosition.bottomStart,
                  child: Container(
                    color: Colors.blue,
                    padding: const EdgeInsets.all(16),
                    child: const Text('Tap me(bottom start)'),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                DigitTooltip(
                  tooltipContent: const Text(
                    'Hello, Tooltip!',
                    style: TextStyle(color: Colors.white),
                  ),
                  tooltipPosition: TooltipPosition.bottomCenter,
                  child: Container(
                    color: Colors.blue,
                    padding: const EdgeInsets.all(16),
                    child: const Text('Tap me(bottom center)'),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                DigitTooltip(
                  tooltipContent: const Text(
                    'Hello, Tooltip!',
                    style: TextStyle(color: Colors.white),
                  ),
                  tooltipPosition: TooltipPosition.bottomEnd,
                  child: Container(
                    color: Colors.blue,
                    padding: const EdgeInsets.all(16),
                    child: const Text('Tap me(bottom end)'),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                DigitTooltip(
                  tooltipContent: const Text(
                    'Hello, Tooltip!',
                    style: TextStyle(color: Colors.white),
                  ),
                  tooltipPosition: TooltipPosition.leftStart,
                  child: Container(
                    color: Colors.blue,
                    padding: const EdgeInsets.all(16),
                    child: const Text('Tap me(left start)'),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                DigitTooltip(
                  tooltipContent: const Text(
                    'Hello, Tooltip!',
                    style: TextStyle(color: Colors.white),
                  ),
                  tooltipPosition: TooltipPosition.leftCenter,
                  child: Container(
                    color: Colors.blue,
                    padding: const EdgeInsets.all(16),
                    child: const Text('Tap me(left center)'),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                DigitTooltip(
                  tooltipContent: const Text(
                    'Hello, Tooltip!',
                    style: TextStyle(color: Colors.white),
                  ),
                  tooltipPosition: TooltipPosition.leftEnd,
                  child: Container(
                    color: Colors.blue,
                    padding: const EdgeInsets.all(16),
                    child: const Text('Tap me(left end)'),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                DigitTooltip(
                  tooltipContent: const Text(
                    'Hello, Tooltip!',
                    style: TextStyle(color: Colors.white),
                  ),
                  tooltipPosition: TooltipPosition.rightStart,
                  child: Container(
                    color: Colors.blue,
                    padding: const EdgeInsets.all(16),
                    child: const Text('Tap me(right start)'),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                DigitTooltip(
                  tooltipContent: const Text(
                    'Hello, Tooltip!',
                    style: TextStyle(color: Colors.white),
                  ),
                  tooltipPosition: TooltipPosition.rightCenter,
                  child: Container(
                    color: Colors.blue,
                    padding: const EdgeInsets.all(16),
                    child: const Text('Tap me(right center)'),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                DigitTooltip(
                  tooltipContent: const Text(
                    'Hello, Tooltip!',
                    style: TextStyle(color: Colors.white),
                  ),
                  tooltipPosition: TooltipPosition.rightEnd,
                  child: Container(
                    color: Colors.blue,
                    padding: const EdgeInsets.all(16),
                    child: const Text('Tap me(right end)'),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                ImageUploader(
                  onImagesSelected: (List<File> imageFile) {
                    // Handle the selected image file here
                    // print('Image selected: ${imageFile.path}');
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                InputField(
                  type: InputType.text,
                  label: "Text Field",
                  controller: controller1,
                  innerLabel: 'label',
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
                if (showAllVariantsOfInputField)
                  Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      InputField(
                        type: InputType.text,
                        label: "Text Field With Validation",
                        controller: controller2,
                        innerLabel: 'label',
                        helpText: 'help text',
                        charCount: true,
                        validations: [
                          Validator(ValidatorType.maxLength, 10,
                              errorMessage: 'Maximum length is 10.'),
                          Validator(ValidatorType.pattern, r'^[a-zA-Z0-9]+$',
                              errorMessage:
                              'Long error message long error message long error message long error message long error message'),
                        ],
                      ),
                      InputField(
                        type: InputType.text,
                        label: "Text Field With Required State",
                        controller: TextEditingController(),
                        innerLabel: 'label',
                        charCount: true,
                        helpText: 'help text',
                        isRequired: true,
                      ),
                      InputField(
                        type: InputType.text,
                        label: "Text Field With Disabled State",
                        controller: TextEditingController(),
                        innerLabel: 'label',
                        helpText: 'help text',
                        isDisabled: true,
                        charCount: true,
                      ),
                      InputField(
                        type: InputType.text,
                        label: "Text Field With Read Only State",
                        controller: TextEditingController(),
                        innerLabel: 'label',
                        initialValue: 'ReadOnly',
                        helpText: 'help text',
                        readOnly: true,
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                InputField(
                  type: InputType.textArea,
                  controller: controller23,
                  label: "Text Area",
                  innerLabel: 'label',
                  helpText: 'help text',
                  textAreaScroll: TextAreaScroll.smart,
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
                if (showAllVariantsOfTextAreaField)
                  Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      InputField(
                        type: InputType.textArea,
                        label: "TextArea Field With Vertical Scroll",
                        controller: controller24,
                        innerLabel: 'label',
                        helpText: 'help text',
                        textAreaScroll: TextAreaScroll.vertical,
                      ),
                      InputField(
                        type: InputType.textArea,
                        textAreaScroll: TextAreaScroll.none,
                        label: "TextArea Field With Disabled State",
                        controller: TextEditingController(),
                        innerLabel: 'label',
                        helpText: 'help text',
                        isDisabled: true,
                      ),
                      InputField(
                        type: InputType.textArea,
                        textAreaScroll: TextAreaScroll.none,
                        label: "TextArea Field With Required State",
                        controller: TextEditingController(),
                        innerLabel: 'label',
                        helpText: 'help text',
                        isRequired: true,
                      ),
                      InputField(
                        type: InputType.textArea,
                        label: "TextArea Field With Read Only State",
                        controller: TextEditingController(),
                        innerLabel: 'label',
                        initialValue: 'ReadOnly',
                        helpText: 'help text',
                        readOnly: true,
                        textAreaScroll: TextAreaScroll.none,
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                InputField(
                  type: InputType.date,
                  label: "Date Field",
                  controller: controller6,
                  innerLabel: 'innerlabel',
                  helpText: 'help text',
                ),
                const SizedBox(
                  height: 8,
                ),
                DigitCheckbox(
                  label: "Show All The Variants Of Date Field",
                  onChanged: (value) {
                    setState(() {
                      showAllVariantsOfDateField = value;
                    });
                  },
                ),
                if (showAllVariantsOfDateField)
                  Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      InputField(
                        type: InputType.date,
                        label: "Date Field With Editable Input",
                        controller: controller36,
                        innerLabel: 'innerlabel',
                        helpText: 'help text',
                        editable: true,
                      ),
                      InputField(
                        type: InputType.date,
                        label: "Date Field With Disabled State",
                        controller: TextEditingController(),
                        innerLabel: 'innerlabel',
                        helpText: 'help text',
                        isDisabled: true,
                      ),
                      InputField(
                        type: InputType.date,
                        label: "Date Field With ReadOnly State",
                        controller: TextEditingController(),
                        innerLabel: 'innerlabel',
                        initialValue: "12/07/2023",
                        helpText: 'help text',
                        readOnly: true,
                      ),
                      InputField(
                        type: InputType.date,
                        label: "Date Field With Required State",
                        controller: TextEditingController(),
                        innerLabel: 'innerlabel',
                        helpText: 'help text',
                        isRequired: true,
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                InputField(
                  type: InputType.time,
                  label: "Time Field",
                  controller: controller8,
                  innerLabel: 'innerlabel',
                  helpText: 'help text',
                ),
                const SizedBox(
                  height: 8,
                ),
                DigitCheckbox(
                  label: "Show All The Variants Of Time Field",
                  onChanged: (value) {
                    setState(() {
                      showAllVariantsOfTimeField = value;
                    });
                  },
                ),
                if (showAllVariantsOfTimeField)
                  Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      InputField(
                        type: InputType.time,
                        label: "Time Field with Editable Input",
                        controller: controller37,
                        innerLabel: 'innerlabel',
                        helpText: 'help text',
                        editable: true,
                      ),
                      InputField(
                        type: InputType.time,
                        label: "Time Field With Disabled State",
                        controller: TextEditingController(),
                        innerLabel: 'innerlabel',
                        helpText: 'help text',
                        isDisabled: true,
                      ),
                      InputField(
                        type: InputType.time,
                        label: "Time Field With Required State",
                        controller: TextEditingController(),
                        innerLabel: 'innerlabel',
                        helpText: 'help text',
                        isRequired: true,
                      ),
                      InputField(
                        type: InputType.time,
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
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                InputField(
                  type: InputType.search,
                  label: "Search Field",
                  controller: controller10,
                  innerLabel: 'innerlabel',
                  helpText: 'help text',
                ),
                const SizedBox(
                  height: 8,
                ),
                DigitCheckbox(
                  label: "Show All The Variants Of Search Field",
                  onChanged: (value) {
                    setState(() {
                      showAllVariantsOfSearchField = value;
                    });
                  },
                ),
                if (showAllVariantsOfSearchField)
                  Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      InputField(
                        type: InputType.search,
                        isDisabled: true,
                        label: "Search Field With Disabled State",
                        controller: TextEditingController(),
                        innerLabel: 'innerlabel',
                        helpText: 'help text',
                      ),
                      InputField(
                        type: InputType.search,
                        label: "Search Field With ReadOnly State",
                        controller: TextEditingController(),
                        innerLabel: 'innerlabel',
                        initialValue: "search",
                        helpText: 'help text',
                        readOnly: true,
                      ),
                      InputField(
                        type: InputType.search,
                        label: "Search Field With Required State",
                        controller: TextEditingController(),
                        innerLabel: 'innerlabel',
                        helpText: 'help text',
                        isRequired: true,
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                InputField(
                  type: InputType.password,
                  label: "password Field",
                  controller: controller12,
                  innerLabel: 'innerlabel',
                  helpText: 'help text',
                  charCount: true,
                  infoText: 'this is infoText',
                ),
                const SizedBox(
                  height: 8,
                ),
                DigitCheckbox(
                  label: "Show All The Variants Of Password Field",
                  onChanged: (value) {
                    setState(() {
                      showAllVariantsOfPasswordField = value;
                    });
                  },
                ),
                if (showAllVariantsOfPasswordField)
                  Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      InputField(
                        type: InputType.password,
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
                      InputField(
                        type: InputType.password,
                        label: "password Field With ReadOnly State",
                        controller: controller14,
                        innerLabel: 'innerlabel',
                        initialValue: 'initialValue',
                        helpText: 'help text',
                        readOnly: true,
                      ),
                      InputField(
                        type: InputType.password,
                        label: "password Field With Disable State",
                        controller: TextEditingController(),
                        innerLabel: 'innerlabel',
                        helpText: 'help text',
                        isDisabled: true,
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                InputField(
                  type: InputType.numeric,
                  label: "Numeric Field",
                  controller: controller15,
                  innerLabel: 'innerlabel',
                  helpText: 'help text',
                  initialValue: '0',
                ),
                const SizedBox(
                  height: 8,
                ),
                DigitCheckbox(
                  label: "Show All The Variants Of Numeric Field",
                  onChanged: (value) {
                    setState(() {
                      showAllVariantsOfNumericField = value;
                    });
                  },
                ),
                if (showAllVariantsOfNumericField)
                  Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      InputField(
                        type: InputType.numeric,
                        label: "Numeric Field With Editable",
                        controller: controller16,
                        innerLabel: 'innerlabel',
                        helpText: 'help text',
                        initialValue: '0',
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        editable: true,
                      ),
                      InputField(
                        type: InputType.numeric,
                        label: "Numeric Field with Disabled State",
                        controller: TextEditingController(),
                        innerLabel: 'innerlabel',
                        helpText: 'help text',
                        isDisabled: true,
                      ),
                      InputField(
                        type: InputType.numeric,
                        label: "Numeric Field With ReadOnly State",
                        controller: controller38,
                        innerLabel: 'innerlabel',
                        helpText: 'help text',
                        initialValue: '20',
                        readOnly: true,
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                InputField(
                  type: InputType.location,
                  label: "Location Field",
                  controller: controller17,
                  innerLabel: 'innerlabel',
                  helpText: 'help text',
                ),
                const SizedBox(
                  height: 8,
                ),
                DigitCheckbox(
                  label: "Show All The Variants Of Location Field",
                  onChanged: (value) {
                    setState(() {
                      showAllVariantsOfLocationField = value;
                    });
                  },
                ),
                if (showAllVariantsOfLocationField)
                  Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      InputField(
                        type: InputType.location,
                        label: "Location Field With Editable Input",
                        controller: controller26,
                        innerLabel: 'innerlabel',
                        helpText: 'help text',
                        editable: true,
                      ),
                      InputField(
                        type: InputType.location,
                        label: "Location Field With ReadOnly",
                        controller: TextEditingController(),
                        innerLabel: 'innerlabel',
                        helpText: 'help text',
                        initialValue: "23.444444444444444, 43.333333333",
                        readOnly: true,
                      ),
                      InputField(
                        type: InputType.location,
                        label: "Location Field with Disabled State",
                        controller: TextEditingController(),
                        innerLabel: 'innerlabel',
                        helpText: 'help text',
                        isDisabled: true,
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                InputField(
                  type: InputType.text,
                  label: "Text Field With Prefix Icon",
                  controller: controller27,
                  innerLabel: 'innerlabel',
                  helpText: 'help text',
                  prefixText: '+88',
                ),
                DigitCheckbox(
                  label: "Show All The Variants Of prefix Input Field",
                  onChanged: (value) {
                    setState(() {
                      showAllVariantsOfPrefixField = value;
                    });
                  },
                ),
                if (showAllVariantsOfPrefixField)
                  Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      InputField(
                        type: InputType.text,
                        label: "Text Field With Prefix Icon with ReadOnly",
                        controller: TextEditingController(),
                        innerLabel: 'innerlabel',
                        helpText: 'help text',
                        prefixText: '+91',
                        initialValue: 'Value',
                        readOnly: true,
                      ),
                      InputField(
                        type: InputType.text,
                        label: "Text Field With Prefix Icon With Disabled",
                        controller: TextEditingController(),
                        innerLabel: 'innerlabel',
                        helpText: 'help text',
                        isDisabled: true,
                        prefixText: '+91',
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                InputField(
                  type: InputType.text,
                  label: "Text Field With Suffix Icon",
                  controller: controller28,
                  innerLabel: 'innerlabel',
                  helpText: 'help text',
                  suffixText: '#',
                ),
                DigitCheckbox(
                  label: "Show All The Variants Of Suffix Input Field",
                  onChanged: (value) {
                    setState(() {
                      showAllVariantsOfSuffixField = value;
                    });
                  },
                ),
                if (showAllVariantsOfSuffixField)
                  Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      InputField(
                        type: InputType.text,
                        label: "Text Field With Suffix Icon with ReadOnly",
                        controller: TextEditingController(),
                        innerLabel: 'innerlabel',
                        initialValue: 'value',
                        helpText: 'help text',
                        suffixText: '#',
                        readOnly: true,
                      ),
                      InputField(
                        type: InputType.text,
                        label: "Text Field With Suffix Icon With Disabled",
                        controller: TextEditingController(),
                        innerLabel: 'innerlabel',
                        helpText: 'help text',
                        isDisabled: true,
                        suffixText: '#',
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                LabeledField(
                  label: 'Dropdown Variants',
                  child: Dropdown(
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
                ),
                const SizedBox(
                  height: 8,
                ),
                DigitCheckbox(
                    label: 'Show All Variants Of Default Dropdown',
                    onChanged: (value) {
                      setState(() {
                        showAllVariantsOfDropdown = value;
                      });
                    }),
                const SizedBox(
                  height: 8,
                ),
                if (showAllVariantsOfDropdown)
                  Column(
                    children: [
                      const SizedBox(height: 8),
                      const LabeledField(
                        label: "Non Searchable Dropdown",
                        child: Dropdown(
                          isSearchable: false,
                          items: [
                            DropdownItem(
                              name: 'first',
                              code: '1',
                              profileImageUrl:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzBXNuO6PezhC18aYH_2cYtS0I7KbxoKYdwA&usqp=CAU',
                            ),
                            DropdownItem(
                              name: 'second',
                              code: '2',
                              profileImageUrl:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzBXNuO6PezhC18aYH_2cYtS0I7KbxoKYdwA&usqp=CAU',
                            ),
                            DropdownItem(
                              name: 'third',
                              code: '3',
                              profileImageUrl:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzBXNuO6PezhC18aYH_2cYtS0I7KbxoKYdwA&usqp=CAU',
                            ),
                            DropdownItem(
                              name: 'fourth',
                              code: '4',
                              profileImageUrl:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzBXNuO6PezhC18aYH_2cYtS0I7KbxoKYdwA&usqp=CAU',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      const LabeledField(
                        label: "Dropdown with Profile",
                        child: Dropdown(
                          items: [
                            DropdownItem(
                              name: 'first',
                              code: '1',
                              profileImageUrl:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzBXNuO6PezhC18aYH_2cYtS0I7KbxoKYdwA&usqp=CAU',
                            ),
                            DropdownItem(
                              name: 'second',
                              code: '2',
                              profileImageUrl:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzBXNuO6PezhC18aYH_2cYtS0I7KbxoKYdwA&usqp=CAU',
                            ),
                            DropdownItem(
                              name: 'third',
                              code: '3',
                              profileImageUrl:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzBXNuO6PezhC18aYH_2cYtS0I7KbxoKYdwA&usqp=CAU',
                            ),
                            DropdownItem(
                              name: 'fourth',
                              code: '4',
                              profileImageUrl:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzBXNuO6PezhC18aYH_2cYtS0I7KbxoKYdwA&usqp=CAU',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      const LabeledField(
                        label: "Dropdown with Profile And Description",
                        child: Dropdown(
                          items: [
                            DropdownItem(
                              name: 'first',
                              code: '1',
                              description: 'description for first one',
                              profileImageUrl:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzBXNuO6PezhC18aYH_2cYtS0I7KbxoKYdwA&usqp=CAU',
                            ),
                            DropdownItem(
                              name: 'second',
                              code: '2',
                              description: 'description for second one',
                              profileImageUrl:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzBXNuO6PezhC18aYH_2cYtS0I7KbxoKYdwA&usqp=CAU',
                            ),
                            DropdownItem(
                              name: 'third',
                              code: '3',
                              description: 'description for third one',
                              profileImageUrl:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzBXNuO6PezhC18aYH_2cYtS0I7KbxoKYdwA&usqp=CAU',
                            ),
                            DropdownItem(
                              name: 'fourth',
                              code: '4',
                              description: 'description for fourth one',
                              profileImageUrl:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzBXNuO6PezhC18aYH_2cYtS0I7KbxoKYdwA&usqp=CAU',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      LabeledField(
                        label: "Dropdown with Description",
                        child: Dropdown(
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
                                description:
                                'This is just example description'),
                          )
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      LabeledField(
                        label: "Dropdown with Icon",
                        child: Dropdown(
                          items: [
                            'One',
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
                              textIcon: Icons.article,
                            ),
                          )
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const LabeledField(
                        label: "Dropdown with nested Type",
                        child: Dropdown(
                          dropdownSelectionType: SelectionType.nestedSelect,
                          selectedOption: DropdownItem(
                            name: 'one',
                            code: '1',
                            type: 'group B',
                          ),
                          items: [
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
                      ),
                      const LabeledField(
                        label: "Dropdown with nested Type With Icons",
                        child: Dropdown(
                          dropdownSelectionType: SelectionType.nestedSelect,
                          items: [
                            DropdownItem(
                              name: 'one',
                              code: '1',
                              type: 'group B',
                              textIcon: Icons.article,
                            ),
                            DropdownItem(
                              name: 'two',
                              code: '2',
                              type: 'group A',
                              textIcon: Icons.article,
                            ),
                            DropdownItem(
                              name: 'three',
                              code: '3',
                              type: 'group B',
                              textIcon: Icons.article,
                            ),
                            DropdownItem(
                              name: 'four',
                              code: '4',
                              type: 'group A',
                              textIcon: Icons.article,
                            ),
                            DropdownItem(
                              name: 'five',
                              code: '5',
                              type: 'group B',
                              textIcon: Icons.article,
                            ),
                            DropdownItem(
                              name: 'six',
                              code: '6',
                              type: 'group A',
                              textIcon: Icons.article,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      const LabeledField(
                        label:
                        "Dropdown with nested Type With Icons and description",
                        child: Dropdown(
                          dropdownSelectionType: SelectionType.nestedSelect,
                          items: [
                            DropdownItem(
                              name: 'one',
                              code: '1',
                              type: 'group B',
                              textIcon: Icons.article,
                              description: 'this is description',
                            ),
                            DropdownItem(
                              name: 'two',
                              code: '2',
                              type: 'group A',
                              textIcon: Icons.article,
                              description: 'this is description',
                            ),
                            DropdownItem(
                              name: 'three',
                              code: '3',
                              type: 'group B',
                              textIcon: Icons.article,
                              description: 'this is description',
                            ),
                            DropdownItem(
                              name: 'four',
                              code: '4',
                              type: 'group A',
                              textIcon: Icons.article,
                              description: 'this is description',
                            ),
                            DropdownItem(
                              name: 'five',
                              code: '5',
                              type: 'group B',
                              textIcon: Icons.article,
                              description: 'this is description',
                            ),
                            DropdownItem(
                              name: 'six',
                              code: '6',
                              type: 'group A',
                              textIcon: Icons.article,
                              description: 'this is description',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      const LabeledField(
                        label: "Dropdown Disabled",
                        child: Dropdown(
                          isDisabled: true,
                          items: [
                            DropdownItem(
                              name: 'one',
                              code: '1',
                            ),
                            DropdownItem(
                              name: 'two',
                              code: '2',
                            ),
                            DropdownItem(
                              name: 'three',
                              code: '3',
                            ),
                            DropdownItem(
                              name: 'four',
                              code: '4',
                            ),
                            DropdownItem(
                              name: 'five',
                              code: '5',
                            ),
                            DropdownItem(
                              name: 'six',
                              code: '6',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                LabeledField(
                  label: 'MultiSelect Dropdowns',
                  child: Dropdown(
                    dropdownType: DropdownType.multiSelect,
                    onOptionSelected: (List<DropdownItem> selectedOptions) {},
                    options: const [
                      DropdownItem(code: '1', name: 'first'),
                      DropdownItem(code: '2', name: 'second'),
                      DropdownItem(code: '3', name: 'third'),
                      DropdownItem(code: '4', name: 'four'),
                      DropdownItem(code: '5', name: 'five'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                DigitCheckbox(
                    label: 'Show All Variants Of MultiSelect Dropdown',
                    onChanged: (value) {
                      setState(() {
                        showAllVariantsOfMultiSelectDropdown = value;
                      });
                    }),
                const SizedBox(
                  height: 8,
                ),
                if (showAllVariantsOfMultiSelectDropdown)
                  Column(
                    children: [
                      const SizedBox(height: 8),
                      LabeledField(
                        label: "MultiSelect Dropdown with value mapper",
                        child: Dropdown(
                          dropdownType: DropdownType.multiSelect,
                          onOptionSelected:
                              (List<DropdownItem> selectedOptions) {},
                          valueMapper: const [
                            ValueMapper(code: '1', name: 'first mapper'),
                            ValueMapper(code: '2', name: 'second mapper'),
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
                        ),
                      ),
                      const SizedBox(height: 8),
                      LabeledField(
                        label: "MultiSelect Dropdown with Selected Option",
                        child: Dropdown(
                          dropdownType: DropdownType.multiSelect,
                          onOptionSelected:
                              (List<DropdownItem> selectedOptions) {},
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
                        ),
                      ),
                      const SizedBox(height: 8),
                      LabeledField(
                        label: "MultiSelect Dropdown with Description",
                        child: Dropdown(
                          dropdownType: DropdownType.multiSelect,
                          onOptionSelected:
                              (List<DropdownItem> selectedOptions) {},
                          options: const [
                            DropdownItem(
                              code: '1',
                              name: 'first',
                              description: 'this is description',
                            ),
                            DropdownItem(
                              code: '2',
                              name: 'second',
                              description: 'this is description',
                            ),
                            DropdownItem(
                              code: '3',
                              name: 'third',
                              description: 'this is description',
                            ),
                            DropdownItem(
                              code: '4',
                              name: 'four',
                              description: 'this is description',
                            ),
                            DropdownItem(
                              code: '5',
                              name: 'five',
                              description: 'this is description',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      LabeledField(
                        label: "MultiSelect Dropdown with Description and Icon",
                        child: Dropdown(
                          dropdownType: DropdownType.multiSelect,
                          onOptionSelected:
                              (List<DropdownItem> selectedOptions) {},
                          options: const [
                            DropdownItem(
                              code: '1',
                              name: 'first',
                              description: 'this is description',
                              textIcon: Icons.article,
                            ),
                            DropdownItem(
                              code: '2',
                              name: 'second',
                              description: 'this is description',
                              textIcon: Icons.article,
                            ),
                            DropdownItem(
                              code: '3',
                              name: 'third',
                              description: 'this is description',
                              textIcon: Icons.article,
                            ),
                            DropdownItem(
                              code: '4',
                              name: 'four',
                              description: 'this is description',
                              textIcon: Icons.article,
                            ),
                            DropdownItem(
                              code: '5',
                              name: 'five',
                              description: 'this is description',
                              textIcon: Icons.article,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      LabeledField(
                        label: "MultiSelect Dropdown with Icon",
                        child: Dropdown(
                          dropdownType: DropdownType.multiSelect,
                          onOptionSelected:
                              (List<DropdownItem> selectedOptions) {},
                          options: const [
                            DropdownItem(
                              code: '1',
                              name: 'first',
                              textIcon: Icons.article,
                            ),
                            DropdownItem(
                              code: '2',
                              name: 'second',
                              textIcon: Icons.article,
                            ),
                            DropdownItem(
                              code: '3',
                              name: 'third',
                              textIcon: Icons.article,
                            ),
                            DropdownItem(
                              code: '4',
                              name: 'four',
                              textIcon: Icons.article,
                            ),
                            DropdownItem(
                              code: '5',
                              name: 'five',
                              textIcon: Icons.article,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      LabeledField(
                        label: "MultiSelect Dropdown with nested Type",
                        child: Dropdown(
                          dropdownType: DropdownType.multiSelect,
                          dropdownSelectionType: SelectionType.nestedSelect,
                          onOptionSelected:
                              (List<DropdownItem> selectedOptions) {},
                          options: const [
                            DropdownItem(
                                code: '1', name: 'first', type: "Type A"),
                            DropdownItem(
                                code: '2', name: 'second', type: "Type A"),
                            DropdownItem(
                                code: '3', name: 'third', type: "Type A"),
                            DropdownItem(
                                code: '4', name: 'four', type: "Type B"),
                            DropdownItem(
                                code: '5', name: 'five', type: "Type B"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      LabeledField(
                        label: "MultiSelect Dropdown with nested Type and Icon",
                        child: Dropdown(
                          dropdownType: DropdownType.multiSelect,
                          dropdownSelectionType: SelectionType.nestedSelect,
                          onOptionSelected:
                              (List<DropdownItem> selectedOptions) {},
                          options: const [
                            DropdownItem(
                                code: '1',
                                name: 'first',
                                type: "Type A",
                                textIcon: Icons.article),
                            DropdownItem(
                                code: '2',
                                name: 'second',
                                type: "Type A",
                                textIcon: Icons.article),
                            DropdownItem(
                                code: '3',
                                name: 'third',
                                type: "Type A",
                                textIcon: Icons.article),
                            DropdownItem(
                                code: '4',
                                name: 'four',
                                type: "Type B",
                                textIcon: Icons.article),
                            DropdownItem(
                                code: '5',
                                name: 'five',
                                type: "Type B",
                                textIcon: Icons.article),
                          ],
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                LabeledField(
                  label: 'Tree Select Dropdowns',
                  child: Dropdown(
                    dropdownSelectionType: SelectionType.treeSelect,
                    onTreeOptionSelected: (List<TreeNode> selectedOptions) {
                      // print(selectedOptions);
                      for (TreeNode node in selectedOptions) {
                        // print("Node: ${node.value}");
                      }
                    },
                    treeOptions: Nodes,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                LabeledField(
                  label: 'Tree Multi Select Dropdowns',
                  child: Dropdown(
                    dropdownType: DropdownType.multiSelect,
                    dropdownSelectionType: SelectionType.treeSelect,
                    onTreeOptionSelected: (List<TreeNode> selectedOptions) {
                      // print(selectedOptions);
                      for (TreeNode node in selectedOptions) {
                        // print("Node: ${node.value}");
                      }
                    },
                    valueMapper: const [
                      ValueMapper(code: 'A: A1', name: "A: A1"),
                      ValueMapper(code: 'A: A2', name: "A: A2"),
                      ValueMapper(code: 'A: A3', name: "A: A3"),
                      ValueMapper(code: 'B: B1', name: "B: B1"),
                      ValueMapper(code: 'B: B2', name: "B: B2"),
                      ValueMapper(code: 'C: C1', name: "C: C1"),
                      ValueMapper(code: 'C: C2', name: "C: C2"),
                      ValueMapper(code: 'D: D1', name: "D: D1"),
                      ValueMapper(code: 'D: D2', name: "D: D2")
                    ],
                    treeOptions: Nodes,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                RadioList(
                  onChanged: (value) {},
                  radioDigitButtons: [
                    RadioDigitButtonModel(
                      code: '1',
                      name: 'One',
                    ),
                    RadioDigitButtonModel(code: '2', name: 'Two'),
                    RadioDigitButtonModel(code: '3', name: 'Three'),
                    // Add more radio DigitButtons as needed
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                DigitCheckbox(
                  label: "Show All The Variants Of Radio DigitButtons",
                  onChanged: (value) {
                    setState(() {
                      showAllVariantsOfRadio = value;
                    });
                  },
                ),
                if (showAllVariantsOfRadio)
                  Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      RadioList(
                        onChanged: (value) {},
                        radioDigitButtons: [
                          RadioDigitButtonModel(
                            code: '',
                            name: 'One',
                          ),
                          RadioDigitButtonModel(code: '2', name: 'Two'),
                          RadioDigitButtonModel(code: '3', name: 'Three'),
                          // Add more radio DigitButtons as needed
                        ],
                      ),
                      RadioList(
                        onChanged: (value) {},
                        isDisabled: true,
                        radioDigitButtons: [
                          RadioDigitButtonModel(
                            code: '',
                            name: 'One',
                          ),
                          RadioDigitButtonModel(code: '2', name: 'Two'),
                          RadioDigitButtonModel(code: '3', name: 'Three'),
                          // Add more radio DigitButtons as needed
                        ],
                      ),
                      RadioList(
                        onChanged: (value) {},
                        isDisabled: true,
                        radioDigitButtons: [
                          RadioDigitButtonModel(
                            code: '1',
                            name: 'One',
                          ),
                          RadioDigitButtonModel(code: '2', name: 'Two'),
                          RadioDigitButtonModel(code: '3', name: 'Three'),
                          // Add more radio DigitButtons as needed
                        ],
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                ToggleList(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  toggleDigitButtons: [
                    ToggleDigitButtonModel(name: 'Toggle 1', code: 'key1'),
                    ToggleDigitButtonModel(name: 'Toggle 2', code: 'key2'),
                    ToggleDigitButtonModel(name: 'Toggle 3', code: 'key3'),
                  ],
                  selectedIndex: 1,
                  onChanged: (selectedValues) {},
                ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  // height: 45,
                  child: Column(
                    children: [
                      Center(
                        child: InfoDigitButton(
                          size: DigitButtonSize.large,
                          label: 'Primary DigitButton',
                          onPressed: () {},
                          type: InfoDigitButtonType.success,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: InfoDigitButton(
                          size: DigitButtonSize.large,
                          label: 'Primary DigitButton',
                          onPressed: () {},
                          type: InfoDigitButtonType.error,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: InfoDigitButton(
                          size: DigitButtonSize.large,
                          label: 'Primary DigitButton',
                          onPressed: () {},
                          type: InfoDigitButtonType.warning,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: InfoDigitButton(
                          size: DigitButtonSize.large,
                          label: 'Primary DigitButton',
                          onPressed: () {},
                          type: InfoDigitButtonType.info,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  // height: 45,
                  child: Center(
                    child: DigitButton(
                      size: DigitButtonSize.large,
                      label: 'Primary DigitButton',
                      onPressed: () {},
                      type: DigitButtonType.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                DigitCheckbox(
                    label: 'Show All Variants Of Primary DigitButton',
                    onChanged: (value) {
                      setState(() {
                        showAllVariantsPrimaryDigitButton = value;
                      });
                    }),
                if (showAllVariantsPrimaryDigitButton)
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        SizedBox(
                          // height: 45,
                          child: DigitButton(
                            size: DigitButtonSize.large,
                            label: 'Primary DigitButton With Prefix Icon',
                            onPressed: () {},
                            type: DigitButtonType.primary,
                            prefixIcon: Icons.arrow_forward,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          // height: 45,
                          child: DigitButton(
                            size: DigitButtonSize.medium,
                            label: 'Primary DigitButton With Suffix Icon',
                            onPressed: () {},
                            type: DigitButtonType.primary,
                            suffixIcon: Icons.arrow_forward,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          // height: 45,
                          child: DigitButton(
                            size: DigitButtonSize.small,
                            label: 'Primary DigitButton With Disabled State',
                            onPressed: () {},
                            type: DigitButtonType.primary,
                            isDisabled: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 45,
                  child: Center(
                    child: DigitButton(
                      size: DigitButtonSize.large,
                      label: 'secondary DigitButton',
                      onPressed: () {},
                      type: DigitButtonType.secondary,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                DigitCheckbox(
                    label: 'Show All Variants Of Secondary DigitButton',
                    onChanged: (value) {
                      setState(() {
                        showAllVariantsOfSecondaryDigitButton = value;
                      });
                    }),
                if (showAllVariantsOfSecondaryDigitButton)
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        SizedBox(
                          // height: 45,
                          child: DigitButton(
                            size: DigitButtonSize.medium,
                            label: 'Secondary DigitButton With Prefix Icon',
                            onPressed: () {},
                            type: DigitButtonType.secondary,
                            prefixIcon: Icons.arrow_forward,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          // height: 45,
                          child: DigitButton(
                            size: DigitButtonSize.small,
                            label: 'Secondary DigitButton With Suffix Icon',
                            onPressed: () {},
                            type: DigitButtonType.secondary,
                            suffixIcon: Icons.arrow_forward,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          // height: 45,
                          child: DigitButton(
                            size: DigitButtonSize.small,
                            label: 'Secondary DigitButton With Disabled State',
                            onPressed: () {},
                            type: DigitButtonType.secondary,
                            isDisabled: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                Center(
                  child: DigitButton(
                    size: DigitButtonSize.large,
                    label: 'tertiary DigitButton',
                    onPressed: () {},
                    type: DigitButtonType.tertiary,
                  ),
                ),
                const SizedBox(height: 8),
                DigitCheckbox(
                    label: 'Show All Variants Of Tertiary DigitButton',
                    onChanged: (value) {
                      setState(() {
                        showAllVariantsOfTertiaryDigitButton = value;
                      });
                    }),
                if (showAllVariantsOfTertiaryDigitButton)
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        DigitButton(
                          size: DigitButtonSize.medium,
                          label: 'Tertiary DigitButton With Prefix Icon',
                          onPressed: () {},
                          type: DigitButtonType.tertiary,
                          prefixIcon: Icons.arrow_forward,
                        ),
                        const SizedBox(height: 8),
                        DigitButton(
                          size: DigitButtonSize.small,
                          label: 'Tertiary DigitButton With Suffix Icon',
                          onPressed: () {},
                          type: DigitButtonType.tertiary,
                          suffixIcon: Icons.arrow_forward,
                        ),
                        const SizedBox(height: 8),
                        DigitButton(
                          size: DigitButtonSize.large,
                          label: 'Tertiary DigitButton With Disabled State',
                          onPressed: () {},
                          type: DigitButtonType.tertiary,
                          isDisabled: true,
                        ),
                      ],
                    ),
                  ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                Center(
                  child: DigitButton(
                    size: DigitButtonSize.large,
                    label: 'link',
                    onPressed: () {},
                    type: DigitButtonType.link,
                  ),
                ),
                const SizedBox(height: 8),
                DigitCheckbox(
                    label: 'Show All Variants Of Link',
                    onChanged: (value) {
                      setState(() {
                        showAllVariantsOfLink = value;
                      });
                    }),
                if (showAllVariantsOfLink)
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        DigitButton(
                          size: DigitButtonSize.small,
                          label: 'Link With Prefix Icon',
                          onPressed: () {},
                          type: DigitButtonType.link,
                          prefixIcon: Icons.arrow_forward,
                        ),
                        const SizedBox(height: 8),
                        DigitButton(
                          size: DigitButtonSize.medium,
                          label: 'Link With Suffix Icon',
                          onPressed: () {},
                          type: DigitButtonType.link,
                          suffixIcon: Icons.arrow_forward,
                        ),
                        const SizedBox(height: 8),
                        DigitButton(
                          size: DigitButtonSize.large,
                          label: 'Link With Disabled State',
                          onPressed: () {},
                          type: DigitButtonType.link,
                          isDisabled: true,
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                Column(
                  children: [
                    DigitButton(
                        label: 'Click to increase steps',
                        onPressed: () {
                          setState(() {
                            stepNumber += 1;
                          });
                        },
                        type: DigitButtonType.primary,
                        size: DigitButtonSize.large),
                    const SizedBox(
                      height: 8,
                    ),
                    DigitButton(
                        label: 'Click to decrease steps',
                        onPressed: () {
                          setState(() {
                            if (stepNumber > 0) {
                              stepNumber -= 1;
                            }
                          });
                        },
                        type: DigitButtonType.primary,
                        size: DigitButtonSize.large),
                    SizedBox(
                      height: 500,
                      width: MediaQuery.of(context).size.width,
                      child: DigitStepper(
                        activeIndex: stepNumber,
                        stepperList: [
                          StepperData(
                            title: "Preparing",
                            onStepTap: () {},
                          ),
                          const StepperData(
                            title: "Preparing",
                          ),
                          const StepperData(
                            title: "Preparing",
                          ),
                          const StepperData(
                            title: "Preparing",
                          ),
                          const StepperData(
                            title: "Preparing",
                          ),
                          const StepperData(
                            title: "Preparing",
                          ),
                          const StepperData(
                            title: "Preparing",
                          ),
                          const StepperData(
                            title: "Preparing",
                          ),
                          const StepperData(
                            title: "Preparing",
                          ),
                          const StepperData(
                            title: "Preparing",
                          ),
                          const StepperData(
                            title: "Preparing",
                          ),
                          const StepperData(
                            title: "Preparing",
                          ),
                          const StepperData(
                            title: "Preparing",
                          ),
                          const StepperData(
                            title: "Preparing",
                          ),
                          const StepperData(
                            title: "Preparing",
                          ),
                          const StepperData(
                            title: "Preparing",
                          ),
                          const StepperData(
                            title: "Preparing",
                          ),
                        ],
                        stepperDirection: Axis.horizontal,
                        inverted: true,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                DigitCard(
                  inline: true,
                  cardType: CardType.primary,
                  children: [
                    LabeledField(
                        labelInline: false,
                        label: 'Text Field',
                        child: DigitTextFormInput(
                          controller: TextEditingController(),
                        )),
                    LabeledField(
                      labelInline: false,
                      label: "Dropdown",
                      child: MultiSelectDropDown<int>(
                        onOptionSelected:
                            (List<DropdownItem> selectedOptions) {},
                        options: const [
                          DropdownItem(code: '1', name: 'one'),
                          DropdownItem(code: '2', name: 'two'),
                          DropdownItem(code: '3', name: 'three'),
                          DropdownItem(code: '4', name: 'four'),
                          DropdownItem(code: '5', name: 'five'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 32,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              DigitButton(
                                  label: 'Clear All',
                                  onPressed: () {},
                                  type: DigitButtonType.tertiary,
                                  size: DigitButtonSize.large),
                              const SizedBox(
                                width: 16,
                              ),
                              Flexible(
                                child: Container(
                                    width: 300,
                                    child: DigitButton(
                                        mainAxisSize: MainAxisSize.max,
                                        label: 'Submit',
                                        onPressed: () {},
                                        type: DigitButtonType.primary,
                                        size: DigitButtonSize.large)),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                LabeledField(
                  label: 'File Upload with single selected',
                  child: FileUploadWidget(
                    label: 'Upload',
                    onFilesSelected: (List<PlatformFile> files) {
                      Map<PlatformFile, String?> fileErrors = {};

                      return fileErrors;
                    },
                    showPreview: false,
                  ),
                ),
                const SizedBox(height: 8),
                LabeledField(
                  label: 'File Upload with single selected with preview',
                  child: FileUploadWidget(
                    label: 'Upload',
                    onFilesSelected: (List<PlatformFile> files) {
                      Map<PlatformFile, String?> fileErrors = {};
                      return fileErrors;
                    },
                    showPreview: true,
                  ),
                ),
                const SizedBox(height: 8),
                LabeledField(
                  label: 'File Upload with Multiple selected',
                  child: FileUploadWidget(
                    label: 'Upload',
                    onFilesSelected: (List<PlatformFile> files) {
                      Map<PlatformFile, String?> fileErrors = {};
                      return fileErrors;
                    },
                    allowMultiples: true,
                    showPreview: false,
                  ),
                ),
                const SizedBox(height: 8),
                LabeledField(
                  label: 'File Upload with Multiple selected with preview',
                  child: FileUploadWidget(
                    label: 'Upload',
                    onFilesSelected: (List<PlatformFile> files) {
                      Map<PlatformFile, String?> fileErrors = {};
                      return fileErrors;
                    },
                    allowMultiples: true,
                    showPreview: true,
                  ),
                ),
                const SizedBox(height: 8),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                DigitCheckbox(
                  label: 'Click to see the success toast',
                  value: false,
                  onChanged: (value) {
                    if (value) {
                      Toast.showToast(
                        context,
                        digitToastThemeData:
                        const DigitToastThemeData().copyWith(maxLine: 4),
                        message:
                        'This is a success toastThis is a success toastThis is a success toastThis is a success toastThis is a success toastThis is a success toastThis is a success toastThis is a success toastThis is a success toastThis is a success toastThis is a success toastThis is a success toastThis is a success toastThis is a success toastThis is a success toastThis is a success toastThis is a success toastThis is a success toastThis is a success toast!',
                        type: ToastType.success,
                      );
                    }
                  },
                ),
                const SizedBox(height: 8),
                DigitCheckbox(
                  label: 'Click to see the error toast',
                  value: false,
                  onChanged: (value) {
                    if (value) {
                      Toast.showToast(
                        context,
                        message: 'This is a error toast!',
                        type: ToastType.error,
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                DigitCheckbox(
                  label: 'Click to see the warning toast',
                  value: false,
                  onChanged: (value) {
                    if (value) {
                      Toast.showToast(
                        context,
                        message: 'This is a Warning toast!',
                        type: ToastType.warning,
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                DigitCheckbox(
                  label: 'Click to see the warning toast with long message',
                  value: false,
                  onChanged: (value) {
                    if (value) {
                      Toast.showToast(
                        context,
                        message:
                        'Message token created successfully and Users Are Unable to Login to the Professional after an Upgrade to Version it is working fine. Learn about token based authentication and how to easily implement JWT in your application',
                        type: ToastType.warning,
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                DigitCheckbox(
                  label: 'Click to see the error toast with long message',
                  value: false,
                  onChanged: (value) {
                    if (value) {
                      Toast.showToast(
                        context,
                        message:
                        'Message token created successfully and Users Are Unable to Login to the Professional after an Upgrade to Version it is working fine. Learn about token based authentication and how to easily implement JWT in your application',
                        type: ToastType.error,
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                DigitCheckbox(
                  label: 'Click to see the Success toast with long message',
                  value: false,
                  onChanged: (value) {
                    if (value) {
                      Toast.showToast(
                        context,
                        message:
                        'Message token created successfully and Users Are Unable to Login to the Professional after an Upgrade to Version it is working fine. Learn about token based authentication and how to easily implement JWT in your application",',
                        type: ToastType.success,
                      );
                    }
                  },
                ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                DigitCheckbox(
                  label: 'DigitCheckbox',
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 8),
                DigitCheckbox(
                    label: 'Show All Variants Of DigitCheckbox',
                    onChanged: (value) {
                      setState(() {
                        showAllVariantsOfDigitCheckbox = value;
                      });
                    }),
                if (showAllVariantsOfDigitCheckbox)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      DigitCheckbox(
                        label: 'DigitCheckbox With Checked State',
                        value: true,
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 8),
                      DigitCheckbox(
                        label: 'DigitCheckbox with Disabled State',
                        value: false,
                        isDisabled: true,
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 8),
                      DigitCheckbox(
                        label:
                        'DigitCheckbox With Checked and Disabled StateDigitCheckbox With Checked and Disabled StateDigitCheckbox With Checked and Disabled StateDigitCheckbox With Checked and Disabled StateDigitCheckbox With Checked and Disabled StateDigitCheckbox With Checked and Disabled StateDigitCheckbox With Checked and Disabled StateDigitCheckbox With Checked and Disabled StateDigitCheckbox With Checked and Disabled StateDigitCheckbox With Checked and Disabled StateDigitCheckbox With Checked and Disabled StateDigitCheckbox With Checked and Disabled StateDigitCheckbox With Checked and Disabled State',
                        value: true,
                        isDisabled: true,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                const DigitTimeline(
                  currentStep: TimelineStepState.present,
                  label: 'Current',
                  description: ['18 / 02 / 2023'],
                ),
                const SizedBox(
                  height: 8,
                ),
                const DigitTimeline(
                  currentStep: TimelineStepState.future,
                  label: 'Future',
                  description: ['18 / 02 / 2023'],
                ),
                const SizedBox(
                  height: 8,
                ),
                const DigitTimeline(
                  currentStep: TimelineStepState.completed,
                  label: 'Completed',
                  description: ['18 / 02 / 2023'],
                ),
                const SizedBox(
                  height: 8,
                ),
                DigitTimeline(
                  currentStep: TimelineStepState.completed,
                  label: 'Completed',
                  description: const [
                    '18 / 02 / 2023',
                    '11:10 AM',
                    'processing'
                  ],
                  additionalHideWidgets: [
                    Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
                    Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
                    Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s'),
                    const InfoCard(
                        title: "Info Text",
                        type: InfoType.error,
                        description: 'This is the warning')
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                const InfoCard(
                  title: 'Info',
                  type: InfoType.info,
                  description:
                  'Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect theservice to get completed in 24 hrs from the time of payment.',
                ),
                const SizedBox(
                  height: 8,
                ),
                const InfoCard(
                  title: 'Success',
                  type: InfoType.success,
                  description:
                  'Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect theservice to get completed in 24 hrs from the time of payment.',
                ),
                const SizedBox(
                  height: 8,
                ),
                const InfoCard(
                  title: 'Error',
                  type: InfoType.error,
                  description:
                  'Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect theservice to get completed in 24 hrs from the time of payment.',
                ),
                const SizedBox(
                  height: 8,
                ),
                const InfoCard(
                  title: 'Warning',
                  type: InfoType.warning,
                  description:
                  'Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect theservice to get completed in 24 hrs from the time of payment.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
