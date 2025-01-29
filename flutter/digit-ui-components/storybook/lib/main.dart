import 'dart:convert';
import 'package:digit_ui_components/services/component_localization_delegate.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inspector/inspector.dart';
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
import 'package:storybook/widgets/molecules/filter_card_stories.dart';
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
import 'package:storybook/widgets/foundations/animations_stories.dart';
import 'package:storybook/widgets/foundations/colors_stories.dart';
import 'package:storybook/widgets/foundations/icons_stories.dart';
import 'package:storybook/widgets/foundations/illustrations_stories.dart';
import 'package:storybook/widgets/foundations/spacers_stories.dart';
import 'package:storybook/widgets/foundations/typography_stories.dart';
import 'package:storybook/widgets/introduction/introduction_story.dart';
import 'package:storybook/widgets/molecules/accordion_list_stories.dart';
import 'package:storybook/widgets/molecules/bottom_sheet_stories.dart';
import 'package:storybook/widgets/molecules/card_stories.dart';
import 'package:storybook/widgets/molecules/digit_slider_stories.dart';
import 'package:storybook/widgets/molecules/digit_table_stories.dart';
import 'package:storybook/widgets/molecules/footer_stories.dart';
import 'package:storybook/widgets/molecules/form_card_stories.dart';
import 'package:storybook/widgets/molecules/hamburger_stories.dart';
import 'package:storybook/widgets/molecules/header_stories.dart';
import 'package:storybook/widgets/molecules/landing_page_card_stories.dart';
import 'package:storybook/widgets/molecules/language_selection_card_stories.dart';
import 'package:storybook/widgets/molecules/list_view_summary_stories.dart';
import 'package:storybook/widgets/molecules/panel_card_stories.dart';
import 'package:storybook/widgets/molecules/show_pop_up_stories.dart';
import 'package:storybook/widgets/molecules/side_nav_stories.dart';
import 'package:storybook/widgets/molecules/timeline_molecule_stories.dart';
import 'package:storybook/widgets/privacy_policy/privacy_policy_story.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';
import 'localization.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: DigitExtendedTheme.instance.getLightTheme(),
      darkTheme: DigitExtendedTheme.instance.getDarkTheme(),
      locale: Locale("en", "MZ"),
      localizationsDelegates: [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        ComponentLocalizationDelegate(
          loadLocalizedStrings(),
          [Language('English', 'en_MZ'), Language('English (French)', 'en_FR', )],
        ),
      ],
      supportedLocales: const [
        Locale('en', 'MZ'),
      ],
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
      body: Inspector(
        child: Storybook(
          plugins: initializePlugins(
            enableCodeView: false,
            enableDirectionality: false,
            enableTimeDilation: false,
            enableTextSizer: true,
            localizationData: LocalizationData(
                currentLocale: Locale("en", "MZ"), // Set the initial locale correctly
                supportedLocales: {
                  "English": Locale.fromSubtags(languageCode: 'en', countryCode: 'MZ'),
                },
                delegates: [
                  DefaultMaterialLocalizations.delegate,
                  DefaultWidgetsLocalizations.delegate,
                  ComponentLocalizationDelegate(
                    _localizationFuture,
                    [Language('English', 'en_MZ'), Language('English (French)', 'en_FR', )],
                  ),
                ]
            )
        
          ),
          canvasColor: Theme.of(context).colorTheme.paper.primary,
          logoWidget: Container(
            padding: EdgeInsets.only(left: 0, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Group 1079.png',
                  //  color: Theme.of(context).colorTheme.primary.primary1,
                    height: 40,
                  ),
                ],
              )),
          initialStory: 'Introduction/doc',
          stories: [
            ...introStories(),
            ...animationStories(),
            ...colorStories(),
            ...illustrationStories(),
            ...materialIconStories(),
            ...spacerStories(),
            ...typographyStories(),
            ...accordionStories(),
            ...actionStories(),
            ...infoCardStories(),
            ...digitBackButtonStories(),
            ...DigitBreadCrumbStories(),
            ...buttonStories(),
            ...digitButtonListStories(),
            ...checkboxStories(),
            ...chipStories(),
            ...dividerStories(),
            ...dropdownStories(),
            ...fileUploaderStories(),
            ...inputFieldStories(),
            ...listViewStories(),
            ...loaderStories(),
            ...matrixCardStories(),
            ...menuCardStories(),
            ...otpInputStories(),
            ...groupMenuCardStories(),
            ...panelStories(),
            // ...popUpStories(),
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
            ...accordionListStories(),
            ...bottomSheetStories(),
            ...cardStories(),
            ...listViewSummaryStories(),
            ...filterCardStories(),
            ...formCardStories(),
            ...footerMoleculeStories(),
            ...headerMoleculeStories(),
            ...hamBurgerStories(),
            ...landingPageCardStories(),
            ...languageSelectionCardStories(),
            ...panelCardStories(),
            ...showPopUPStories(),
            ...sideNavStories(),
            ...sliderStories(),
            ...tableStories(),
            ...timelineMoleculeStories(),
           ...privacyComponentStories()
          ],
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
