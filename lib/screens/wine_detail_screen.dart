import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../widgets/help_icon.dart';
import '../providers/wine_provider.dart';

/// Wine Detail Screen - Comprehensive Wine Bottle View
/// Displays all wine information organized in MD3-compliant sections
class WineDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? wine;
  final int? wineId;
  final VoidCallback? onUpdate;
  final VoidCallback? onDelete;

  const WineDetailScreen({
    this.wine,
    this.wineId,
    this.onUpdate,
    this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  State<WineDetailScreen> createState() => _WineDetailScreenState();
}

class _WineDetailScreenState extends State<WineDetailScreen> {
  late Map<String, dynamic> wine;
  late Future<Map<String, dynamic>?> _wineFuture;

  @override
  void initState() {
    super.initState();
    if (widget.wine != null) {
      wine = widget.wine!;
      _wineFuture = Future.value(wine);
    } else if (widget.wineId != null) {
      // Fetch wine from provider by ID
      _wineFuture = _fetchWine(widget.wineId!);
    } else {
      wine = {};
      _wineFuture = Future.value(wine);
    }
  }

  Future<Map<String, dynamic>?> _fetchWine(int wineId) async {
    try {
      final wineProvider = context.read<WineProvider>();
      final wines = wineProvider.wines;
      final found = wines.firstWhere(
        (w) => w['id'] == wineId,
        orElse: () => {},
      );
      setState(() {
        wine = found;
      });
      return found;
    } catch (e) {
      return null;
    }
  }

  // Format date for display
  String formatDate(DateTime? date) {
    if (date == null) return '-';
    return DateFormat('d MMMM yyyy', 'fr_FR').format(date);
  }

  // Check if wine is in apogee window
  bool? isInApogee() {
    final minDate = wine['min_apogee_date'];
    final maxDate = wine['max_apogee_date'];

    if (minDate == null || maxDate == null) return null;

    final now = DateTime.now();
    final min = DateTime.parse(minDate);
    final max = DateTime.parse(maxDate);

    return now.isAfter(min) && now.isBefore(max);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          wine.isNotEmpty ? (wine['name'] ?? 'Détails') : 'Chargement...',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: widget.onUpdate,
            tooltip: 'Modifier cette bouteille',
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: widget.onDelete,
            tooltip: 'Supprimer cette bouteille',
          ),
        ],
      ),
      body: wine.isEmpty
          ? Center(child: CircularProgressIndicator(color: colorScheme.primary))
          : _buildContent(context, colorScheme),
    );
  }

  Widget _buildContent(BuildContext context, ColorScheme colorScheme) {
    final apogeeStatus = isInApogee();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            _buildHeader(context, colorScheme),
            const SizedBox(height: 24),

            // Identification Section
            _buildIdentificationCard(context, colorScheme),
            const SizedBox(height: 16),

            // Stock Section
            _buildStockCard(context, colorScheme),
            const SizedBox(height: 16),

            // Apogee Window Section
            _buildApogeeCard(context, colorScheme, apogeeStatus),
            const SizedBox(height: 16),

            // Evaluation Section
            _buildEvaluationCard(context, colorScheme),
            const SizedBox(height: 16),

            // Comments Section
            _buildCommentsCard(context, colorScheme),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          wine['name'] ?? 'Produit inconnu',
          style: Theme.of(
            context,
          ).textTheme.headlineLarge?.copyWith(color: colorScheme.onSurface),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: [
            Chip(
              label: Text(wine['type'] ?? 'Type inconnu'),
              backgroundColor: colorScheme.primaryContainer,
              labelStyle: TextStyle(color: colorScheme.onPrimaryContainer),
            ),
            Chip(
              label: Text('Millésime ${wine['vintage']}'),
              backgroundColor: colorScheme.primary.withOpacity(0.2),
              labelStyle: TextStyle(color: colorScheme.primary),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIdentificationCard(
    BuildContext context,
    ColorScheme colorScheme,
  ) {
    final theme = Theme.of(context);

    return Card(
      color: colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // 2x8 = 16dp
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '📋 Identification',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(width: 8),
                HelpIcon(
                  title: 'Identification',
                  description:
                      'Les informations de base qui identifient ce vin: producteur, région, degré alcoolique.',
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              icon: Icons.person,
              label: 'Producteur',
              value: wine['producer'] ?? '-',
              helpText: 'Nom du domaine ou de la maison de production',
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              icon: Icons.location_on,
              label: 'Région / Appellation',
              value: wine['region'] ?? '-',
              helpText: 'Zone géographique d\'origine du produit',
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              icon: Icons.local_fire_department,
              label: 'Degré Alcoolique',
              value: wine['alcohol_level'] != null
                  ? '${wine['alcohol_level']}°'
                  : '-',
              helpText: 'Pourcentage d\'alcool par volume',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStockCard(BuildContext context, ColorScheme colorScheme) {
    final theme = Theme.of(context);

    return Card(
      color: colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '🍾 Stock',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(width: 8),
                HelpIcon(
                  title: 'Stock',
                  description:
                      'Nombre de bouteilles disponibles dans votre cave.',
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 12),
            // Quantity with display style
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '${wine['quantity'] ?? 0}',
                  style: theme.textTheme.displaySmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'bouteilles en cave',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            if (wine['consumed'] != null && wine['consumed'] > 0) ...[
              const SizedBox(height: 12),
              Text(
                '${wine['consumed']} consommées',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            if (wine['cell_id'] != null) ...[
              const SizedBox(height: 16),
              _buildInfoRow(
                context,
                icon: Icons.grid_3x3,
                label: 'Emplacement',
                value: 'Cellule #${wine['cell_id']}',
              ),
            ],
            if (wine['consumption_date'] != null) ...[
              const SizedBox(height: 16),
              _buildInfoRow(
                context,
                icon: Icons.calendar_today,
                label: 'Dernière dégustation',
                value: formatDate(DateTime.parse(wine['consumption_date'])),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildApogeeCard(
    BuildContext context,
    ColorScheme colorScheme,
    bool? apogeeStatus,
  ) {
    final theme = Theme.of(context);

    return Card(
      color: colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '⏰ Fenêtre d\'Apogée',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(width: 8),
                    HelpIcon(
                      title: 'Fenêtre d\'apogée',
                      description:
                          'Période optimale pour déguster ce vin. L\'application indique si le vin est actuellement à son meilleur.',
                    ),
                  ],
                ),
                if (apogeeStatus == true)
                  Chip(
                    label: const Text('À boire maintenant!'),
                    backgroundColor: colorScheme.tertiaryContainer,
                    labelStyle: TextStyle(
                      color: colorScheme.onTertiaryContainer,
                    ),
                  ),
                if (apogeeStatus == false)
                  Chip(
                    label: const Text('Hors apogée'),
                    backgroundColor: colorScheme.errorContainer,
                    labelStyle: TextStyle(color: colorScheme.onErrorContainer),
                  ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              icon: Icons.calendar_today,
              label: 'À boire à partir du',
              value: formatDate(
                wine['min_apogee_date'] != null
                    ? DateTime.parse(wine['min_apogee_date'])
                    : null,
              ),
              helpText: 'Date à partir de laquelle ce vin sera prêt à boire',
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              icon: Icons.calendar_today,
              label: 'À boire jusqu\'au',
              value: formatDate(
                wine['max_apogee_date'] != null
                    ? DateTime.parse(wine['max_apogee_date'])
                    : null,
              ),
              helpText: 'Date limite pour déguster ce vin à son meilleur',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEvaluationCard(BuildContext context, ColorScheme colorScheme) {
    final theme = Theme.of(context);

    return Card(
      color: colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '⭐ Évaluation',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(width: 8),
                HelpIcon(
                  title: 'Évaluation',
                  description:
                      'Votre note personnelle et les caractéristiques de la bouteille.',
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 12),
            // Rating
            if (wine['rating'] != null) ...[
              Text(
                'Note',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    index < (wine['rating'] as num).toInt()
                        ? Icons.star
                        : Icons.star_border,
                    color: colorScheme.tertiary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            // Price
            if (wine['price'] != null)
              _buildInfoRow(
                context,
                icon: Icons.attach_money,
                label: 'Prix d\'achat',
                value: '${wine['price']}€',
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentsCard(BuildContext context, ColorScheme colorScheme) {
    final theme = Theme.of(context);

    return Card(
      color: colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '💬 Commentaires & Notes',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(width: 8),
                HelpIcon(
                  title: 'Commentaires',
                  description:
                      'Vos notes personnelles de dégustation, impressions gustatives et recommandations.',
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                wine['comments'] ?? 'Aucun commentaire',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    String? helpText,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Icon(icon, size: 20, color: colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    label,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (helpText != null) ...[
                    const SizedBox(width: 4),
                    HelpIcon(
                      title: label,
                      description: helpText,
                      fontSize: 12.0,
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
