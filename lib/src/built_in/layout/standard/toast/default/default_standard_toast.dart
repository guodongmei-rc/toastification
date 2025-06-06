import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toastification/src/built_in/layout/standard/toast/base_standard.dart';
import 'package:toastification/src/built_in/theme/toastification_theme_data.dart';
import 'package:toastification/src/built_in/widget/common/close_button.dart';
import 'package:toastification/src/built_in/widget/common/toast_content.dart';
import 'package:toastification/src/utils/toast_theme_utils.dart';

class DefaultStandardToastWidget extends StatelessWidget
    implements StandardToastWidget {
  const DefaultStandardToastWidget({
    super.key,
    this.title,
    this.description,
    this.icon,
    required this.onCloseTap,
    this.showCloseButton = true,
    this.closeButton = const ToastCloseButton(),
    this.progressBarValue,
    this.progressBarWidget,
  });

  final Widget? title;
  final Widget? description;
  final Widget? icon;

  final VoidCallback onCloseTap;
  final bool showCloseButton;
  final ToastCloseButton closeButton;

  final double? progressBarValue;
  final Widget? progressBarWidget;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: context.toastTheme.direction,
      child: IconTheme(
        data: Theme.of(context)
            .primaryIconTheme
            .copyWith(color: context.toastTheme.toastStyle!.iconColor),
        child: buildBody(context.toastTheme),
      ),
    );
  }

  @override
  Widget buildBody(ToastificationThemeData toastTheme) {
    final toastStyle = toastTheme.toastStyle!;

    Widget body = Container(
      constraints: BoxConstraints(minHeight: toastStyle.minHeight),
      decoration: BoxDecoration(
        color: toastStyle.blurredBackgroundColor(
          toastTheme.applyBlurEffect,
          toastStyle.backgroundColor,
        ),
        borderRadius: toastStyle.borderRadius,
        border: Border.fromBorderSide(toastStyle.borderSide),
        boxShadow: toastStyle.boxShadow,
      ),
      padding: toastStyle.padding,
      child: Row(
        children: [
          Offstage(
            offstage: !toastTheme.showIcon,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 12),
              child: icon ??
                  Icon(
                    toastStyle.icon,
                    size: 24,
                    color: toastStyle.iconColor,
                  ),
            ),
          ),
          Expanded(
            child: ToastContent(
              title: title,
              description: description,
              progressBarValue: progressBarValue,
              progressBarWidget: progressBarWidget,
            ),
          ),
          const SizedBox(width: 8),
          ToastCloseButtonHolder(
            onCloseTap: onCloseTap,
            showCloseButton: showCloseButton,
            toastCloseButton: closeButton,
          ),
        ],
      ),
    );

    if (toastTheme.applyBlurEffect) {
      body = ClipRRect(
        borderRadius: toastStyle.borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: body,
        ),
      );
    }

    return body;
  }
}
