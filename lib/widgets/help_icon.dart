import 'package:flutter/material.dart';

/// Help Icon Widget for Flutter
/// Displays a small (i) icon with a tooltip on hover/tap
class HelpIcon extends StatelessWidget {
  final String title;
  final String description;
  final double fontSize;
  final Color? color;

  const HelpIcon({
    Key? key,
    required this.title,
    required this.description,
    this.fontSize = 16.0,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = color ?? theme.colorScheme.onSurfaceVariant;

    return Tooltip(
      message: description,
      showDuration: const Duration(seconds: 5),
      padding: const EdgeInsets.all(8),
      textStyle: theme.textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.onInverseSurface,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.inverseSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: Icon(
          Icons.info_outlined,
          size: fontSize,
          color: iconColor,
        ),
      ),
    );
  }
}

/// Help Label Widget for Flutter
/// Displays a label with an inline help icon
class HelpLabel extends StatelessWidget {
  final String label;
  final String helpTitle;
  final String helpDescription;
  final TextStyle? labelStyle;

  const HelpLabel({
    Key? key,
    required this.label,
    required this.helpTitle,
    required this.helpDescription,
    this.labelStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: labelStyle ??
              theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        HelpIcon(
          title: helpTitle,
          description: helpDescription,
          fontSize: 14.0,
        ),
      ],
    );
  }
}

/// Help Card Header Widget for Flutter
/// Displays a title with an inline help icon for card headers
class HelpCardHeader extends StatelessWidget {
  final String title;
  final String helpDescription;
  final TextStyle? titleStyle;

  const HelpCardHeader({
    Key? key,
    required this.title,
    required this.helpDescription,
    this.titleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: titleStyle ??
              theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        HelpIcon(
          title: title,
          description: helpDescription,
          fontSize: 18.0,
        ),
      ],
    );
  }
}
