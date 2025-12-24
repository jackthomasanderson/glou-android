import 'package:flutter/material.dart';
import 'alpha_banner.dart';

/// Adaptive Navigation Shell for MD3 SaaS
/// - Mobile: Bottom Navigation Bar
/// - Tablet: Navigation Rail (side)
/// - Desktop: Permanent Navigation Drawer
class AdaptiveNavigationShell extends StatefulWidget {
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onNavigationIndexChange;
  final List<NavigationItem> items;

  const AdaptiveNavigationShell({
    required this.body,
    required this.selectedIndex,
    required this.onNavigationIndexChange,
    required this.items,
    Key? key,
  }) : super(key: key);

  @override
  State<AdaptiveNavigationShell> createState() =>
      _AdaptiveNavigationShellState();
}

class _AdaptiveNavigationShellState extends State<AdaptiveNavigationShell> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;
    final isCompact = size.width < 600;
    final isMedium = size.width >= 600 && size.width < 900;
    final isLarge = size.width >= 900;

    // Mobile: Bottom Navigation Bar
    if (isCompact) {
      return Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 96), // 56 (nav) + 40 (banner)
              child: widget.body,
            ),
            const Positioned(
              bottom: 56,
              left: 0,
              right: 0,
              child: AlphaBanner(),
            ),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          // Design Token: surface with elevation via surfaceTintColor
          backgroundColor: colorScheme.surface,
          elevation: 8,
          selectedIndex: widget.selectedIndex,
          onDestinationSelected: widget.onNavigationIndexChange,
          destinations: widget.items
              .map(
                (item) => NavigationDestination(
                  icon: Icon(item.icon),
                  selectedIcon: Icon(item.selectedIcon),
                  label: item.label,
                ),
              )
              .toList(),
        ),
      );
    }

    // Tablet: Navigation Rail (side navigation)
    if (isMedium) {
      return Scaffold(
        body: Stack(
          children: [
            Row(
              children: [
                NavigationRail(
                  // Design Token: surfaceVariant for subtle distinction
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  selectedIndex: widget.selectedIndex,
                  onDestinationSelected: widget.onNavigationIndexChange,
                  labelType: NavigationRailLabelType.all,
                  elevation: 0,
                  destinations: widget.items
                      .map(
                        (item) => NavigationRailDestination(
                          icon: Icon(item.icon),
                          selectedIcon: Icon(item.selectedIcon),
                          label: Text(item.label),
                        ),
                      )
                      .toList(),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: widget.body,
                  ),
                ),
              ],
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AlphaBanner(),
            ),
          ],
        ),
      );
    }

    // Desktop: Permanent Navigation Drawer
    if (isLarge) {
      return Scaffold(
        body: Stack(
          children: [
            Row(
              children: [
                NavigationDrawer(
                  // Design Token: surface for drawer background
                  backgroundColor: colorScheme.surface,
                  selectedIndex: widget.selectedIndex,
                  onDestinationSelected: widget.onNavigationIndexChange,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Glou Analytics',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                    const Divider(),
                    ...widget.items.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      final isSelected = widget.selectedIndex == index;

                      return NavigationDrawerDestination(
                        icon: Icon(
                          isSelected ? item.selectedIcon : item.icon,
                          // Design Token: primary for selected, onSurfaceVariant for unselected
                          color: isSelected
                              ? colorScheme.primary
                              : colorScheme.onSurfaceVariant,
                        ),
                        label: Text(
                          item.label,
                          style: TextStyle(
                            color: isSelected
                                ? colorScheme.primary
                                : colorScheme.onSurfaceVariant,
                            fontWeight: isSelected
                                ? FontWeight.w500
                                : FontWeight.w400,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: widget.body,
                  ),
                ),
              ],
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AlphaBanner(),
            ),
          ],
        ),
      );
    }

    return widget.body;
  }
}

/// Navigation Item Model
class NavigationItem {
  final String label;
  final IconData icon;
  final IconData selectedIcon;

  const NavigationItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });
}

/// Main App Scaffold with Medium TopAppBar that collapses on scroll
class SaasScaffold extends StatefulWidget {
  final String title;
  final List<Widget> actions;
  final Widget body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final VoidCallback? onSearchTap;

  const SaasScaffold({
    required this.title,
    required this.body,
    this.actions = const [],
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.onSearchTap,
    Key? key,
  }) : super(key: key);

  @override
  State<SaasScaffold> createState() => _SaasScaffoldState();
}

class _SaasScaffoldState extends State<SaasScaffold> {
  late ScrollController _scrollController;
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 0 && !_isScrolled) {
      setState(() => _isScrolled = true);
    } else if (_scrollController.offset <= 0 && _isScrolled) {
      setState(() => _isScrolled = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: theme.textTheme.headlineSmall),
        // Design Token: scrolledUnderElevation for visual feedback
        elevation: _isScrolled ? 4 : 0,
        scrolledUnderElevation: _isScrolled ? 4 : 0,
        // Design Token: surface with surfaceTintColor for elevation
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        surfaceTintColor: colorScheme.primary,
        actions: [
          if (widget.onSearchTap != null)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: widget.onSearchTap,
              tooltip: 'Search',
            ),
          ...widget.actions,
          const SizedBox(width: 8),
        ],
      ),
      body: widget.body,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
    );
  }
}
