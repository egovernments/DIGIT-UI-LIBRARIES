import 'dart:convert';
import 'package:digit_ui_components/models/DropdownModels.dart';
import 'package:digit_ui_components/services/component_localization_delegate.dart';
import 'package:digit_ui_components/theme/colors.dart';
import 'package:digit_ui_components/utils/date_utils.dart';
import 'package:digit_ui_components/widgets/atoms/digit_dob_picker.dart';
import 'package:digit_ui_components/widgets/molecules/digit_header.dart';
import 'package:digit_ui_components/widgets/molecules/hamburger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inspector/inspector.dart';
import 'package:storybook/plugins/code_view_plugin.dart';
import 'package:storybook/plugins/code_view_wrapper.dart';
import 'package:storybook/widgets/atoms/Info_card_stories.dart';
import 'package:storybook/widgets/atoms/accordian_stories.dart';
import 'package:storybook/widgets/atoms/action_card_stories.dart';
import 'package:storybook/widgets/atoms/back_button_stories.dart';
import 'package:storybook/widgets/atoms/bread_crumbs_stories.dart';
import 'package:storybook/widgets/atoms/button_list_stories.dart';
import 'package:storybook/widgets/atoms/button_stories.dart';
import 'package:storybook/widgets/atoms/checkbox_stories.dart';
import 'package:storybook/widgets/atoms/chip_stories.dart';
import 'package:storybook/widgets/atoms/digit_loader_stories.dart';
import 'package:storybook/widgets/atoms/digit_search_bar_stories.dart';
import 'package:storybook/widgets/atoms/digit_tab_stories.dart';
import 'package:storybook/widgets/atoms/digit_tag_stories.dart';
import 'package:storybook/widgets/atoms/divider_stories.dart';
import 'package:storybook/widgets/atoms/dropdown_stories.dart';
import 'package:storybook/widgets/atoms/flie_upload_stories.dart';
import 'package:storybook/widgets/atoms/group_menu_card_stories.dart';
import 'package:storybook/widgets/atoms/input_field_stories.dart';
import 'package:storybook/widgets/atoms/list_view_stories.dart';
import 'package:storybook/widgets/atoms/matrix_card_stories.dart';
import 'package:storybook/widgets/atoms/menu_card_stories.dart';
import 'package:storybook/widgets/atoms/otp_input_stories.dart';
import 'package:storybook/widgets/atoms/panel_stories.dart';
import 'package:storybook/widgets/atoms/pop_up_card_stories.dart';
import 'package:storybook/widgets/atoms/radio_list_stories.dart';
import 'package:storybook/widgets/atoms/selection_card_stories.dart';
import 'package:storybook/widgets/atoms/stepper_stories.dart';
import 'package:storybook/widgets/atoms/switch_stories.dart';
import 'package:storybook/widgets/atoms/text_block_stories.dart';
import 'package:storybook/widgets/atoms/timeline_stories.dart';
import 'package:storybook/widgets/atoms/toast_stories.dart';
import 'package:storybook/widgets/atoms/toggle_stories.dart';
import 'package:storybook/widgets/atoms/tooltip_2_stories.dart';
import 'package:storybook/widgets/molecules/bottom_sheet_stories.dart';
import 'package:storybook/widgets/molecules/card_stories.dart';
import 'package:storybook/widgets/molecules/digit_slider_stories.dart';
import 'package:storybook/widgets/molecules/digit_table_stories.dart';
import 'package:storybook/widgets/molecules/footer_stories.dart';
import 'package:storybook/widgets/molecules/hamburger_stories.dart';
import 'package:storybook/widgets/molecules/header_stories.dart';
import 'package:storybook/widgets/molecules/landing_page_card_stories.dart';
import 'package:storybook/widgets/molecules/language_selection_card_stories.dart';
import 'package:storybook/widgets/molecules/panel_card_stories.dart';
import 'package:storybook/widgets/molecules/show_pop_up_stories.dart';
import 'package:storybook/widgets/molecules/side_nav_stories.dart';
import 'package:storybook/widgets/molecules/timeline_molecule_stories.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'localization.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'Digit Components Page'),
    );
  }
}

Future<List> loadLocalizedStrings() async {
  String jsonString = await rootBundle.loadString('assets/localized_data.json');
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
    super.initState();
    // Initialize the Future to load the localization strings
    _localizationFuture = loadLocalizedStrings();
    ComponentLocalizationDelegate delegate = ComponentLocalizationDelegate(
      _localizationFuture,
      [Language('English', 'en_MZ')],
    );
    delegate.load(const Locale("en", "MZ"));
  }

  Widget _buildContent() {
    // Your widget tree goes here
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size.width < 500
            ? const Size.fromHeight(56)
            : const Size.fromHeight(64), // here the desired height
        child: Builder(
          builder: (context) => CustomHeaderMolecule(
            title: 'Digit UI Library',
            type: HeaderType.light,
            leadingDigitLogo: false,
            trailingDigitLogo: true,
            onMenuTap: () {
              Scaffold.of(context).openDrawer();
            },
            actions: [
              HeaderAction(
                widget: Row(
                  children: [
                    const Text('City'),
                    const SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: const DigitColors().light.textPrimary,
                    )
                  ],
                ),
                isSearchable: true,
                dropdownItems: const [
                  DropdownItem(code: '1', name: 'Option 1'),
                  DropdownItem(code: '2', name: 'Option 2'),
                  DropdownItem(code: '3', name: 'Option 3'),
                  DropdownItem(code: '4', name: 'Option 4'),
                ],
              ),
              HeaderAction(
                widget: Row(
                  children: [
                    const Text('Language'),
                    const SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: const DigitColors().light.textPrimary,
                    )
                  ],
                ),
                dropdownItems: const [
                  DropdownItem(code: '1', name: 'Hindi'),
                  DropdownItem(code: '2', name: 'English'),
                  DropdownItem(code: '3', name: 'French'),
                ],
              ),
              HeaderAction(
                widget: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: DigitColors().light.primary2, width: 1.0),
                    color: DigitColors().light.primary2,
                  ),
                  child: Center(
                    child: Text(
                      'R',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: DigitColors().light.paperPrimary),
                    ),
                  ),
                ),
                dropdownItems: const [
                  DropdownItem(code: '1', name: 'Edit Profile'),
                  DropdownItem(code: '2', name: 'Logout'),
                ],
              ),
            ],
          ),
        ),
      ),
      drawer: SideBar(
        logOutDigitButtonLabel: 'logout',
        sidebarItems: [
          SidebarItem(
            title: 'Home',
            icon: Icons.home,
            onPressed: () {
              Navigator.of(context).pop();
              // Navigate to Home
            },
          ),
          SidebarItem(
            title: 'Language',
            icon: Icons.language,
            onPressed: () {
              // Implement language change
            },
          ),
          SidebarItem(
            title: 'Profile',
            icon: Icons.person,
            onPressed: () {
              Navigator.of(context).pop();
              // Navigate to Profile
            },
          ),
          SidebarItem(
            title: 'View Downloaded Data',
            icon: Icons.download,
            onPressed: () {
              Navigator.of(context).pop();
              // Navigate to Downloaded Data
            },
          ),
        ],
      ),
      body: Inspector(
        isEnabled: true,
        child: CodeViewWrapper(
          child: Storybook(
            plugins: [
              //ThemeModePlugin(),
              CodeViewPlugin(
                enableCodeView: true,
                onShowCodeView: (isEnabled) {
                  // Handle code view toggle state here if needed
                },
              ),
            ],
            initialStory: 'Screens/Scaffold',
            stories: [
              ...accordionStories(),
              ...actionStories(),
              ...digitBackButtonStories(),
              ...DigitBreadCrumbStories(),
              ...DigitButtonStories(),
              ...digitButtonListStories(),
              ...checkboxStories(),
              ...chipStories(),
              ...dividerStories(),
              ...dropdownStories(),
              ...fileUploaderStories(),
              ...inputFieldStories(),
              ...infoCardStories(),
              ...listViewStories(),
              ...loaderStories(),
              ...matrixCardStories(),
              ...menuCardStories(),
              ...otpInputStories(),
              ...groupMenuCardStories(),
              ...panelStories(),
              ...popUpStories(),
              ...radioListStories(),
              ...selectionCardStories(),
              ...switchStories(),
              ...stepperStories(),
              ...searchBarStories(),
              ...timeLineStories(),
              ...toastStories(),
              ...toggleGroupStories(),
              ...toolTip2Stories(),
              ...digitTagStories(),
              ...tabStories(),
              ...textBlockStories(),

              /// molecules stories...
              ...bottomSheetStories(),
              ...cardStories(),
              ...footerMoleculeStories(),
              ...headerMoleculeStories(),
              ...hamBurgerStories(),
              ...landingPageCardStories(),
              ...languageSelectionCardStories(),
              ...panelCardStories(),
              ...showPopUPStories(),
              ...sideNavStories(),
              //...sliderStories(),
              ...tableStories(),
              ...timelineMoleculeStories(),
              // Story(
              //   name: 'DOB',
              //   builder: (context) => DigitDobPicker(
              //     datePickerFormControl: 'sdlkfjsdlkf',
              //     datePickerLabel: 'date of birth',
              //     ageFieldLabel: 'Age',
              //     yearsHintLabel: 'years',
              //     monthsHintLabel: 'months',
              //     separatorLabel: '(or)',
              //     yearsAndMonthsErrMsg: 'error',
              //     initialDate: DateTime(DateTime.now().year - 150, DateTime.now().month, DateTime.now().day),
              //     onChangeOfFormControl: (formControl) {
              //       // // Handle changes to the control's value here
              //       // final value = formControl.value;
              //       // if (value == null) {
              //       //   formControl.setErrors({'': true});
              //       // } else {
              //       //   DigitDOBAgeConvertor age = DigitDateUtils.calculateAge(value);
              //       //   if ((age.years == 0 && age.months == 0) ||
              //       //       age.months > 11 ||
              //       //       (age.years >= 150 && age.months >= 0)) {
              //       //     formControl.setErrors({'': true});
              //       //   } else {
              //       //     formControl.removeError('');
              //       //   }
              //       // }
              //     },
              //     cancelText:'cancel',
              //     confirmText: 'ok',
              //   ),
              // ),
              // Story(
              //   name: 'DOB/age error',
              //   builder: (context) => DigitDobPicker(
              //     datePickerFormControl: 'sdlkfjsdlkf',
              //     datePickerLabel: 'date of birth',
              //     ageFieldLabel: 'Age',
              //     yearsHintLabel: 'years',
              //     monthsHintLabel: 'months',
              //     separatorLabel: '(or)',
              //     yearsAndMonthsErrMsg: 'error',
              //     initialDate: DateTime(DateTime.now().year - 150, DateTime.now().month, DateTime.now().day),
              //     onChangeOfFormControl: (date) {
              //       // Handle changes to the control's value here
              //       final value = date;
              //       if (value == null) {
              //         //formControl.setErrors({'': true});
              //       } else {
              //         DigitDOBAgeConvertor age = DigitDateUtils.calculateAge(value);
              //         if ((age.years == 0 && age.months == 0) ||
              //             age.months > 11 ||
              //             (age.years >= 150 && age.months >= 0)) {
              //           //formControl.setErrors({'': true});
              //         } else {
              //           //formControl.removeError('');
              //         }
              //       }
              //     },
              //     ageErrorMessage: 'age error',
              //     cancelText:'cancel',
              //     confirmText: 'ok',
              //   ),
              // ),
              // Story(
              //   name: 'DOB/month error',
              //   builder: (context) => DigitDobPicker(
              //     datePickerFormControl: 'sdlkfjsdlkf',
              //     datePickerLabel: 'date of birth',
              //     ageFieldLabel: 'Age',
              //     yearsHintLabel: 'years',
              //     monthsHintLabel: 'months',
              //     monthErrorMessage: 'month error',
              //     separatorLabel: '(or)',
              //     yearsAndMonthsErrMsg: 'error',
              //     initialDate: DateTime(DateTime.now().year - 150, DateTime.now().month, DateTime.now().day),
              //     onChangeOfFormControl: (formControl) {
              //       // Handle changes to the control's value here
              //       // final value = formControl.value;
              //       // if (value == null) {
              //       //   formControl.setErrors({'': true});
              //       // } else {
              //       //   DigitDOBAgeConvertor age = DigitDateUtils.calculateAge(value);
              //       //   if ((age.years == 0 && age.months == 0) ||
              //       //       age.months > 11 ||
              //       //       (age.years >= 150 && age.months >= 0)) {
              //       //     formControl.setErrors({'': true});
              //       //   } else {
              //       //     formControl.removeError('');
              //       //   }
              //       // }
              //     },
              //     cancelText:'cancel',
              //     confirmText: 'ok',
              //   ),
              // ),
              // Story(
              //   name: 'DOB/field error',
              //   builder: (context) => DigitDobPicker(
              //     datePickerFormControl: 'sdlkfjsdlkf',
              //     datePickerLabel: 'date of birth',
              //     ageFieldLabel: 'Age',
              //     yearsHintLabel: 'years',
              //     monthsHintLabel: 'months',
              //     errorMessage: 'Field level error message',
              //     separatorLabel: '(or)',
              //     yearsAndMonthsErrMsg: 'error',
              //     initialDate: DateTime(DateTime.now().year - 150, DateTime.now().month, DateTime.now().day),
              //     onChangeOfFormControl: (formControl) {
              //       // Handle changes to the control's value here
              //       // final value = formControl.value;
              //       // if (value == null) {
              //       //   formControl.setErrors({'': true});
              //       // } else {
              //       //   DigitDOBAgeConvertor age = DigitDateUtils.calculateAge(value);
              //       //   if ((age.years == 0 && age.months == 0) ||
              //       //       age.months > 11 ||
              //       //       (age.years >= 150 && age.months >= 0)) {
              //       //     formControl.setErrors({'': true});
              //       //   } else {
              //       //     formControl.removeError('');
              //       //   }
              //       // }
              //     },
              //     cancelText:'cancel',
              //     confirmText: 'ok',
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: _localizationFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading localization data'));
        } else if (snapshot.hasData) {
          return _buildContent();
        } else {
          return const Center(child: Text('Unexpected error occurred'));
        }
      },
    );
  }
}
