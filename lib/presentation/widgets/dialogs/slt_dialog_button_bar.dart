import 'package:flutter/material.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';

class SlDialogButtonBar extends StatelessWidget {
  final Widget? confirmButton;
  final Widget? cancelButton;
  final Widget? neutralButton; // Optional third button (e.g., "Learn More")
  final MainAxisAlignment alignment;
  final double spacing;
  final List<Widget> buttons; // Added for compatibility with SlFullScreenDialog

  const SlDialogButtonBar({
    super.key,
    this.confirmButton,
    this.cancelButton,
    this.neutralButton,
    this.alignment = MainAxisAlignment.end,
    this.spacing = AppDimens.spaceS,
    this.buttons = const [],
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> actionButtons = [];

    if (buttons.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: AppDimens.paddingM),
        child: Row(
          mainAxisAlignment: alignment,
          children: buttons.asMap().entries.map((entry) {
            final index = entry.key;
            final button = entry.value;
            if (index > 0) {
              return Padding(
                padding: EdgeInsets.only(left: spacing),
                child: button,
              );
            }
            return button;
          }).toList(),
        ),
      );
    }

    if (neutralButton != null) {
      actionButtons.add(neutralButton!);
    }

    if (neutralButton != null &&
        (cancelButton != null || confirmButton != null)) {
      actionButtons.add(const Spacer());
    }

    if (cancelButton != null) {
      actionButtons.add(cancelButton!);
    }

    if (confirmButton != null) {
      if (cancelButton != null) {
        actionButtons.add(SizedBox(width: spacing));
      }
      actionButtons.add(confirmButton!);
    }

    if (actionButtons.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: AppDimens.paddingM),
      child: Row(mainAxisAlignment: alignment, children: actionButtons),
    );
  }
}
