import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/privacy_policy/privacy_notice_expand_component.dart';
import 'package:flutter/material.dart';
import '../../models/privacy_notice/privacy_notice_model.dart';
import '../localized.dart';
import '../../utils/i18_key_constants.dart' as i18;
import '../molecules/digit_card.dart';


class FullPageDialog extends StatefulWidget {
  final PrivacyNoticeModel privacyPolicy;
  final VoidCallback onAccept;
  final VoidCallback onDecline;
  final String acceptText;
  final String declineText;

  const FullPageDialog({
    super.key,
    required this.privacyPolicy,
    required this.onAccept,
    required this.onDecline,
    required this.acceptText,
    required this.declineText,
  });

  @override
  FullPageDialogState createState() => FullPageDialogState();
}

class FullPageDialogState extends State<FullPageDialog> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog.fullscreen(
      backgroundColor: theme.colorTheme.paper.primary,
      child: Container(
        color: theme.colorTheme.paper.primary,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: spacer4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: spacer6, left: 0),
                            child: Text(
                              widget.privacyPolicy.header ?? 'Header',
                              maxLines: 3,
                              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                color: theme.colorTheme.text.primary,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.zero,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.close,
                                size: spacer8,
                                color: theme.colorTheme.text.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: spacer4),
                      if(widget.privacyPolicy.contents != null)
                        Column(
                          children: widget.privacyPolicy.contents!.map((section) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: spacer4),
                              child: ExpandableSection(content: section),
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF000000).withOpacity(.16),
                    offset: const Offset(0, -1),
                    spreadRadius: 0,
                    blurRadius: 2,
                  ),
                ],
              ),
              child: DigitCard(
                margin: const EdgeInsets.symmetric(horizontal: 0),
                padding: const EdgeInsets.all(spacer2),
                children: [
                  Button(label: widget.acceptText,  onPressed: () {
                    widget.onAccept();
                    Navigator.of(context).pop();
                  }, type: ButtonType.primary, size: ButtonSize.large, mainAxisSize: MainAxisSize.max,),
                  Button(label: widget.declineText,  onPressed: () {
                    widget.onDecline();
                    Navigator.of(context).pop();
                  }, type: ButtonType.secondary, size: ButtonSize.large, mainAxisSize: MainAxisSize.max,),
                  // DigitElevatedButton(
                  //   onPressed: () {
                  //     widget.onAccept();
                  //     Navigator.of(context).pop();
                  //   },
                  //   child: Text(localizations.translate(i18.privacyPolicy.acceptText)),
                  // ),
                  // DigitOutLineButton(
                  //   onPressed: () {
                  //     widget.onDecline();
                  //     Navigator.of(context).pop();
                  //   },
                  //   label: localizations.translate(i18.privacyPolicy.declineText),
                  //   buttonStyle: OutlinedButton.styleFrom(
                  //     backgroundColor: Colors.white,
                  //     side: BorderSide(
                  //       width: 1.0,
                  //       color: Theme.of(context).colorScheme.secondary,
                  //     ),
                  //     minimumSize: Size(
                  //       MediaQuery.of(context).size.width,
                  //       50,
                  //     ),
                  //     shape: const RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.zero,
                  //     ),
                  //   ),
                  // ),
                ],

              ),
            ),
          ],
        ),
      ),
    );
  }
}