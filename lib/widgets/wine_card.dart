import 'package:flutter/material.dart';

/// Wine Card - Summary view of wine for list display
/// Shows key information: Name, Type, Vintage, Stock, Rating, Apogee Status
class WineCard extends StatefulWidget {
  final Map<String, dynamic> wine;
  final VoidCallback? onView;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const WineCard({
    required this.wine,
    this.onView,
    this.onEdit,
    this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  State<WineCard> createState() => _WineCardState();
}

class _WineCardState extends State<WineCard> {
  Map<String, dynamic> get wine => widget.wine;

  // Determine apogee status
  String getApogeeStatus() {
    final minDate = wine['min_apogee_date'];
    final maxDate = wine['max_apogee_date'];

    if (minDate == null || maxDate == null) return 'unknown';

    final today = DateTime.now();
    final min = DateTime.parse(minDate);
    final max = DateTime.parse(maxDate);

    if (today.isBefore(min)) return 'pending';
    if (today.isAfter(max)) return 'expired';
    return 'ready';
  }

  Widget _buildApogeeChip(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final status = getApogeeStatus();

    switch (status) {
      case 'ready':
        return Chip(
          label: const Text('À boire'),
          backgroundColor: colorScheme.tertiaryContainer,
          labelStyle: TextStyle(
            color: colorScheme.onTertiaryContainer,
            fontSize: 12,
          ),
        );
      case 'pending':
        return Chip(
          label: const Text('Pas encore'),
          backgroundColor: colorScheme.surfaceContainerHighest,
          labelStyle: TextStyle(
            color: colorScheme.onSurfaceVariant,
            fontSize: 12,
          ),
        );
      case 'expired':
        return Chip(
          label: const Text('Passé'),
          backgroundColor: colorScheme.errorContainer,
          labelStyle: TextStyle(
            color: colorScheme.onErrorContainer,
            fontSize: 12,
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      color: colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 4, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        wine['name'] ?? 'Produit inconnu',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        wine['producer'] ?? '-',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: const Text('Détails'),
                      onTap: widget.onView,
                    ),
                    PopupMenuItem(
                      child: const Text('Modifier'),
                      onTap: widget.onEdit,
                    ),
                    PopupMenuItem(
                      child: Text(
                        'Supprimer',
                        style: TextStyle(color: colorScheme.error),
                      ),
                      onTap: widget.onDelete,
                    ),
                  ],
                  icon: Icon(
                    Icons.more_vert,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Vintage & Type Chips
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(
                      label: Text('${wine['vintage']}'),
                      side: BorderSide(color: colorScheme.primary),
                      labelStyle: TextStyle(
                        color: colorScheme.primary,
                        fontSize: 12,
                      ),
                      backgroundColor: colorScheme.primary.withOpacity(0.1),
                    ),
                    Chip(
                      label: Text(wine['type'] ?? 'Type'),
                      backgroundColor: colorScheme.primaryContainer,
                      labelStyle: TextStyle(
                        color: colorScheme.onPrimaryContainer,
                        fontSize: 12,
                      ),
                    ),
                    if (wine['region'] != null)
                      Chip(
                        label: Text(wine['region']),
                        side: BorderSide(color: colorScheme.outline),
                        labelStyle: TextStyle(
                          color: colorScheme.onSurface,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),

                // Stock Information Box
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'STOCK',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${wine['quantity'] ?? 0}',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (wine['consumed'] != null && wine['consumed'] > 0)
                        Text(
                          '${wine['consumed']} consommées',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Rating & Price Row
                Row(
                  children: [
                    if (wine['rating'] != null)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'NOTE',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(
                                5,
                                (index) => Icon(
                                  index < (wine['rating'] as num).toInt()
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: colorScheme.tertiary,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (wine['price'] != null)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PRIX',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${wine['price']}€',
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: colorScheme.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),

                // Apogee Status
                _buildApogeeChip(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Wine Grid - Display collection of wines as cards
class WineGrid extends StatelessWidget {
  final List<Map<String, dynamic>> wines;
  final bool loading;
  final Function(int wineId) onView;
  final Function(int wineId) onEdit;
  final Function(int wineId) onDelete;

  const WineGrid({
    this.wines = const [],
    this.loading = false,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (loading) {
      return Center(
        child: CircularProgressIndicator(color: colorScheme.primary),
      );
    }

    if (wines.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wine_bar_outlined,
              size: 64,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'Aucune bouteille',
              style: theme.textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Commencez par ajouter une bouteille à votre cave',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        childAspectRatio: 0.8,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: wines.length,
      itemBuilder: (context, index) {
        return WineCard(
          wine: wines[index],
          onView: () => onView(wines[index]['id']),
          onEdit: () => onEdit(wines[index]['id']),
          onDelete: () => onDelete(wines[index]['id']),
        );
      },
    );
  }
}
