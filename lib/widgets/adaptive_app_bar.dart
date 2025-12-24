import 'package:flutter/material.dart';
import 'help_icon.dart';

/// Adaptive AppBar widget that adjusts layout based on screen size
/// Mobile: Compact layout with title on left, help icon on right
/// Tablet+: Standard layout with title and help icon
class AdaptiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String helpTitle;
  final String helpDescription;
  final List<Widget>? actions;
  final VoidCallback? onMenuPressed;
  final bool showHelpIcon;

  const AdaptiveAppBar({
    required this.title,
    this.helpTitle = '',
    this.helpDescription = '',
    this.actions,
    this.onMenuPressed,
    this.showHelpIcon = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;
    final isCompact = size.width < 600;

    // Mobile: Compact layout
    if (isCompact) {
      return AppBar(
        elevation: 0,
        backgroundColor: colorScheme.primary,
        leadingWidth: null,
        leading: null,
        title: Row(
          children: [
            Expanded(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        actions: [
          if (showHelpIcon && helpTitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: HelpIcon(
                title: helpTitle,
                description: helpDescription,
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ...?actions,
        ],
      );
    }

    // Tablet+: Standard layout with title and help icon row
    return AppBar(
      elevation: 0,
      backgroundColor: colorScheme.primary,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              color: Colors.white,
            ),
          ),
          if (showHelpIcon && helpTitle.isNotEmpty) ...[
            const SizedBox(width: 12),
            HelpIcon(
              title: helpTitle,
              description: helpDescription,
              fontSize: 20.0,
              color: Colors.white,
            ),
          ],
        ],
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
