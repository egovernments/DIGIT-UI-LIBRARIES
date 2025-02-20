import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../models/privacy_notice/privacy_notice_model.dart';
import '../../theme/spacers.dart';
import '../localized.dart';
import 'privacy_notice_dialog.dart';
import 'package:reactive_forms/reactive_forms.dart';

class PrivacyComponent extends LocalizedStatefulWidget {
  final String formControlName;
  final String text;
  final String linkText;
  final PrivacyNoticeModel? privacyPolicy;
  final String? trailingText;
  final String validationMessage;

  const PrivacyComponent({
    super.key,
    super.appLocalizations,
    required this.formControlName,
    required this.text,
    required this.linkText,
    this.trailingText,
    this.privacyPolicy,
    required this.validationMessage,
  });

  @override
  State<PrivacyComponent> createState() => _PrivacyComponentState();
}

class _PrivacyComponentState extends LocalizedState<PrivacyComponent> {
  late ValueNotifier<bool> checkboxStateNotifier;

  @override
  void initState() {
    super.initState();
    checkboxStateNotifier = ValueNotifier(false);
  }

  @override
  void dispose() {
    checkboxStateNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ReactiveFormField<bool, bool>(
      formControlName: widget.formControlName,
      builder: (field) {
        return ValueListenableBuilder<bool>(
          valueListenable: checkboxStateNotifier,
          builder: (context, value, child) {

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        checkboxStateNotifier.value =
                        !checkboxStateNotifier.value;
                        field.didChange(checkboxStateNotifier.value);
                      },
                      child: value
                          ? Container(
                        width: spacer6,
                        height: spacer6,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: theme.colorTheme.primary.primary1,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.zero,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.check,
                            size: spacer4,
                            color: theme.colorTheme.primary.primary1,
                          ),
                        ),
                      )
                          : Container(
                        width: spacer6,
                        height: spacer6,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: theme.colorTheme.text.primary,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                    ),
                    const SizedBox(width: spacer2),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: widget.text,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorTheme.text.primary,
                          ),
                          children: [
                            TextSpan(
                              text: widget.linkText,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.colorTheme.primary.primary1,
                                decoration: TextDecoration.underline,
                                decorationColor: theme.colorTheme.primary.primary1,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {

                                      return FullPageDialog(
                                        privacyPolicy: widget.privacyPolicy ?? const PrivacyNoticeModel(header: '', module: ''),
                                        onAccept: () {
                                          checkboxStateNotifier.value = true;
                                          field.didChange(true);
                                        },
                                        onDecline: () {
                                          checkboxStateNotifier.value = false;
                                          field.didChange(false);
                                        },
                                      );
                                    },
                                  );
                                },
                            ),
                            if (widget.trailingText != null)
                              TextSpan(
                                text: widget.trailingText,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: theme.colorTheme.text.primary,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (field.errorText != null) ...[
                  const SizedBox(height: spacer1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: spacer1 / 2,
                          ),
                          Icon(
                            Icons.info,
                            color: theme.colorTheme.alert.error,
                            size: BaseConstants.errorIconSize,
                          ),
                        ],
                      ),
                      const SizedBox(width: spacer1),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Text(
                          widget.validationMessage,
                          style: Theme.of(context).digitTextTheme(context).bodyS.copyWith(
                            color: theme.colorTheme.alert.error,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ],
            );
          },
        );
      },
      validationMessages: {
        ValidationMessage.required: (error) => widget.validationMessage,
      },
    );
  }
}