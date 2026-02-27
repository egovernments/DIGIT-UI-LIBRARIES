import 'package:digit_ui_components/widgets/molecules/bottom_sheet.dart';
import 'package:flutter/material.dart';

class DigitBottomSheetService {
  static final DigitBottomSheetService _instance = DigitBottomSheetService._internal();
  factory DigitBottomSheetService() => _instance;
  DigitBottomSheetService._internal();

  OverlayEntry? _overlayEntry;

  void show({
    required BuildContext context,
    required Widget content,
    double? initialHeightPercentage,
    double? fixedHeight,
    String? primaryActionLabel,
    String? secondaryActionLabel,
    void Function(BuildContext context)? onPrimaryAction,
    void Function(BuildContext context)? onSecondaryAction,
    bool disableDrag = false,
    bool allowInteractionWithUnderlyingContent = false, // 👈 New
    bool barrierDismissible = false, // 👈 Optional
  }) {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          if (!allowInteractionWithUnderlyingContent)
            ModalBarrier(
              color: Colors.black.withOpacity(0.3),
              dismissible: barrierDismissible,
              onDismiss: () => hide(),
            )
          else
            IgnorePointer(
              ignoring: true,
              child: Container(color: Colors.transparent),
            ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Material(
              color: Colors.transparent,
              child: DigitBottomSheet(
                content: content,
                initialHeightPercentage: initialHeightPercentage,
                fixedHeight: fixedHeight,
                primaryActionLabel: primaryActionLabel,
                secondaryActionLabel: secondaryActionLabel,
                onPrimaryAction: (ctx) {
                  onPrimaryAction?.call(ctx);
                  hide();
                },
                onSecondaryAction: (ctx) {
                  onSecondaryAction?.call(ctx);
                  hide();
                },
                disableDrag: disableDrag,
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context, rootOverlay: true)?.insert(_overlayEntry!);
  }

  void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

