import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cellar_provider.dart';
import '../l10n/app_localizations.dart';

/// KPI Widget - Displays key performance indicator with MD3 styling
/// Design Tokens Used:
/// - surfaceContainer: Card background
/// - primary/secondary/tertiary: For data visualization
/// - onSurface/onSurfaceVariant: Text colors
class KPIWidget extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final String changePercentage;
  final bool isPositive;
  final IconData icon;
  final Color? accentColor;
  final String? comparisonText;

  const KPIWidget({
    required this.title,
    required this.value,
    this.unit = '',
    required this.changePercentage,
    required this.isPositive,
    required this.icon,
    this.accentColor,
    this.comparisonText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final color = accentColor ?? colorScheme.primary;

    return Card(
      // Design Token: surfaceVariant (standard card background)
      color: colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Medium corner radius
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0), // 8dp grid: 3x8 = 24dp
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Icon + Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                Container(
                  // Design Token: primaryContainer with proper contrast
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(icon, color: color, size: 24),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // KPI Value + Unit
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  // Design Token: displaySmall for KPI emphasis
                  style: theme.textTheme.displaySmall?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  unit,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Change Indicator
            Container(
              // Design Token: semantic color based on positive/negative
              decoration: BoxDecoration(
                color: isPositive
                    ? colorScheme.tertiaryContainer.withValues(alpha: 0.3)
                    : colorScheme.errorContainer.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isPositive ? Icons.trending_up : Icons.trending_down,
                    color:
                        isPositive ? colorScheme.tertiary : colorScheme.error,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$changePercentage%',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color:
                          isPositive ? colorScheme.tertiary : colorScheme.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    comparisonText ?? 'vs last month',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// MD3-compliant Data Table with horizontal dividers only
/// Design Tokens Used:
/// - outlineVariant: Divider color
/// - surfaceContainer: Hover state background
/// - labelLarge: Header text
class SaasDataTable extends StatefulWidget {
  final List<String> columns;
  final List<DataRow> rows;
  final String? title;
  final int? sortColumnIndex;
  final bool sortAscending;
  final Function(int, bool)? onSort;

  const SaasDataTable({
    required this.columns,
    required this.rows,
    this.title,
    this.sortColumnIndex,
    this.sortAscending = true,
    this.onSort,
    Key? key,
  }) : super(key: key);

  @override
  State<SaasDataTable> createState() => _SaasDataTableState();
}

class _SaasDataTableState extends State<SaasDataTable> {
  int? _sortColumnIndex;
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    _sortColumnIndex = widget.sortColumnIndex;
    _sortAscending = widget.sortAscending;
  }

  void _handleSort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
    widget.onSort?.call(columnIndex, ascending);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      // Design Token: surfaceVariant
      color: colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.title != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  widget.title!,
                  // Design Token: titleMedium for card headers
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            // Scrollable Table
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: MediaQuery.of(context).size.width > 1200
                    ? MediaQuery.of(context).size.width - 48
                    : null,
                child: DataTable(
                  // Design Token: No vertical borders, horizontal dividers only
                  dividerThickness: 1,
                  border: TableBorder(
                    horizontalInside: BorderSide(
                      // Design Token: outline for dividers
                      color: colorScheme.outline,
                      width: 1,
                    ),
                    bottom: BorderSide(color: colorScheme.outline, width: 1),
                  ),
                  headingRowColor: WidgetStatePropertyAll(
                    // Design Token: surfaceVariant for header emphasis
                    colorScheme.surfaceContainerHighest,
                  ),
                  dataRowColor: WidgetStateProperty.resolveWith<Color?>((
                    Set<WidgetState> states,
                  ) {
                    if (states.contains(WidgetState.hovered)) {
                      // Design Token: 8% opacity primary overlay on hover
                      return colorScheme.primary.withValues(alpha: 0.08);
                    }
                    return null;
                  }),
                  headingRowHeight: 56,
                  dataRowMinHeight: 56,
                  dataRowMaxHeight: 56,
                  columnSpacing: 16,
                  sortColumnIndex: _sortColumnIndex,
                  sortAscending: _sortAscending,
                  onSelectAll: (_) {},
                  columns: widget.columns
                      .asMap()
                      .entries
                      .map(
                        (entry) => DataColumn(
                          label: Text(
                            entry.value,
                            // Design Token: labelLarge for table headers
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: colorScheme.onSurface,
                            ),
                          ),
                          onSort: (columnIndex, ascending) =>
                              _handleSort(entry.key, ascending),
                        ),
                      )
                      .toList(),
                  rows: widget.rows
                      .asMap()
                      .entries
                      .map((entry) => DataRow(cells: entry.value.cells))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Dashboard Screen - Complete Example
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  // Sample data
  final List<Map<String, dynamic>> _tableData = [
    {
      'product': 'Wine A',
      'sales': '2,450',
      'revenue': '\$49,000',
      'trend': 12,
      'positive': true,
    },
    {
      'product': 'Wine B',
      'sales': '1,890',
      'revenue': '\$37,800',
      'trend': -5,
      'positive': false,
    },
    {
      'product': 'Wine C',
      'sales': '3,120',
      'revenue': '\$62,400',
      'trend': 28,
      'positive': true,
    },
    {
      'product': 'Wine D',
      'sales': '956',
      'revenue': '\$19,120',
      'trend': 8,
      'positive': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final localizations = AppLocalizations.of(context);

    return Consumer<CellarProvider>(
      builder: (context, cellarProvider, _) {
        // Check if user has created at least one cellar
        if (!cellarProvider.hasCellar) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.dashboard_customize_outlined,
                    size: 80,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    localizations.yourDashboard,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    localizations.mustCreateCellarDashboard,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: () {
                      _showCreateCellarDialog(context, cellarProvider);
                    },
                    icon: const Icon(Icons.add),
                    label: Text(localizations.createCellarButton),
                  ),
                ],
              ),
            ),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    final columnCount = constraints.maxWidth > 1200 ? 4 : 2;
                    return GridView.count(
                      crossAxisCount: columnCount,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        KPIWidget(
                          title: localizations.totalSales,
                          value: '8,416',
                          unit: localizations.bottles,
                          changePercentage: '15',
                          isPositive: true,
                          icon: Icons.shopping_cart,
                          accentColor: colorScheme.primary,
                          comparisonText: localizations.vsLastMonth,
                        ),
                        KPIWidget(
                          title: localizations.revenue,
                          value: '\$168.3K',
                          changePercentage: '22',
                          isPositive: true,
                          icon: Icons.trending_up,
                          accentColor: colorScheme.tertiary,
                          comparisonText: localizations.vsLastMonth,
                        ),
                        KPIWidget(
                          title: 'Avg Order Value',
                          value: '\$89.4',
                          changePercentage: '8',
                          isPositive: true,
                          icon: Icons.payments,
                          accentColor: colorScheme.secondary,
                          comparisonText: localizations.vsLastMonth,
                        ),
                        KPIWidget(
                          title: 'Conversion Rate',
                          value: '3.8',
                          unit: '%',
                          changePercentage: '12',
                          isPositive: true,
                          icon: Icons.percent,
                          accentColor: colorScheme.primary,
                          comparisonText: localizations.vsLastMonth,
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 32),
                SaasDataTable(
                  title: 'Product Performance',
                  columns: const ['Product', 'Sales', 'Revenue', 'Trend'],
                  sortColumnIndex: _sortColumnIndex,
                  sortAscending: _sortAscending,
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      _sortColumnIndex = columnIndex;
                      _sortAscending = ascending;
                    });
                  },
                  rows: _tableData
                      .map(
                        (item) => DataRow(
                          cells: [
                            DataCell(
                              Text(
                                item['product'],
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurface,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                item['sales'],
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurface,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                item['revenue'],
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            DataCell(
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    item['positive']
                                        ? Icons.trending_up
                                        : Icons.trending_down,
                                    color: item['positive']
                                        ? colorScheme.tertiary
                                        : colorScheme.error,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${item['trend']}%',
                                    style:
                                        theme.textTheme.labelMedium?.copyWith(
                                      color: item['positive']
                                          ? colorScheme.tertiary
                                          : colorScheme.error,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCreateCellarDialog(
    BuildContext context,
    CellarProvider cellarProvider,
  ) {
    final nameController = TextEditingController();
    final locationController = TextEditingController();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          'Créer une nouvelle cave',
          style: theme.textTheme.titleLarge?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nom de la cave',
                hintText: 'Ma cave à vin',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: 'Emplacement (optionnel)',
                hintText: 'Sous-sol, Garage...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () async {
              final name = nameController.text.trim();
              if (name.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Veuillez entrer un nom pour la cave'),
                  ),
                );
                return;
              }

              final cellarData = {
                'name': name,
                'location': locationController.text.trim(),
              };

              try {
                await cellarProvider.createCellar(cellarData);
                if (dialogContext.mounted) {
                  Navigator.of(dialogContext).pop();
                }
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Cave "$name" créée avec succès'),
                      backgroundColor: colorScheme.tertiary,
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Erreur: ${e.toString()}'),
                      backgroundColor: colorScheme.error,
                    ),
                  );
                }
              }
            },
            child: const Text('Créer'),
          ),
        ],
      ),
    );
  }
}
