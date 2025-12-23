import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wine_provider.dart';
import '../providers/cellar_provider.dart';
import '../widgets/wine_card.dart';
import '../widgets/help_icon.dart';
import 'wine_detail_screen.dart';

/// Wine List Screen - Display and manage wines
class WineListScreen extends StatefulWidget {
  const WineListScreen({Key? key}) : super(key: key);

  @override
  State<WineListScreen> createState() => _WineListScreenState();
}

class _WineListScreenState extends State<WineListScreen> {
  late TextEditingController _searchController;
  String _selectedType = '';
  String _selectedRegion = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('🍾 Ma Collection'),
            SizedBox(width: 8),
            HelpIcon(
              title: 'Ma Collection',
              description:
                  'Consultez toutes vos bouteilles, recherchez, et filtrez par type. Cliquez sur une bouteille pour voir les détails.',
              fontSize: 20.0,
              color: Colors.white,
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: colorScheme.primary,
      ),
      floatingActionButton: Consumer<CellarProvider>(
        builder: (context, cellarProvider, _) {
          return FloatingActionButton(
            onPressed: cellarProvider.hasCellar
                ? () {
                    _showCreateWineDialog(context);
                  }
                : null,
            backgroundColor: cellarProvider.hasCellar
                ? colorScheme.primary
                : colorScheme.surfaceContainerHighest,
            child: const Icon(Icons.add),
          );
        },
      ),
      body: Consumer2<WineProvider, CellarProvider>(
        builder: (context, wineProvider, cellarProvider, _) {
          // Check if user has created at least one cellar
          if (!cellarProvider.hasCellar) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.wine_bar_outlined,
                      size: 80,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Créez une cave pour commencer',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Vous devez d\'abord créer au moins une cave avant d\'ajouter des bouteilles à votre collection.',
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
                      label: const Text('Créer une cave'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (wineProvider.loading) {
            return Center(
              child: CircularProgressIndicator(color: colorScheme.primary),
            );
          }

          final wines = wineProvider.wines;

          // Apply filters
          var filteredWines = wines;
          if (_searchController.text.isNotEmpty) {
            final query = _searchController.text.toLowerCase();
            filteredWines = wines
                .where(
                  (w) =>
                      w['name'].toString().toLowerCase().contains(query) ||
                      w['producer'].toString().toLowerCase().contains(query) ||
                      w['region'].toString().toLowerCase().contains(query),
                )
                .toList();
          }

          if (_selectedType.isNotEmpty) {
            filteredWines =
                filteredWines.where((w) => w['type'] == _selectedType).toList();
          }

          if (_selectedRegion.isNotEmpty) {
            filteredWines = filteredWines
                .where((w) => w['region'] == _selectedRegion)
                .toList();
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Chercher...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: colorScheme.surfaceContainer,
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                      const SizedBox(width: 8),
                      HelpIcon(
                        title: 'Recherche',
                        description:
                            'Entrez le nom de la bouteille, du producteur ou de la région pour filtrer votre collection.',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Filter Chips
                  Row(
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: 8,
                          children: [
                            Tooltip(
                              message: 'Filtrer par type: Rouge',
                              child: FilterChip(
                                label: const Text('Red'),
                                selected: _selectedType == 'Red',
                                onSelected: (selected) {
                                  setState(() {
                                    _selectedType = selected ? 'Red' : '';
                                  });
                                },
                              ),
                            ),
                            Tooltip(
                              message: 'Filtrer par type: Blanc',
                              child: FilterChip(
                                label: const Text('White'),
                                selected: _selectedType == 'White',
                                onSelected: (selected) {
                                  setState(() {
                                    _selectedType = selected ? 'White' : '';
                                  });
                                },
                              ),
                            ),
                            Tooltip(
                              message: 'Filtrer par type: Rosé',
                              child: FilterChip(
                                label: const Text('Rosé'),
                                selected: _selectedType == 'Rosé',
                                onSelected: (selected) {
                                  setState(() {
                                    _selectedType = selected ? 'Rosé' : '';
                                  });
                                },
                              ),
                            ),
                            Tooltip(
                              message: 'Filtrer par type: Pétillant',
                              child: FilterChip(
                                label: const Text('Sparkling'),
                                selected: _selectedType == 'Sparkling',
                                onSelected: (selected) {
                                  setState(() {
                                    _selectedType = selected ? 'Sparkling' : '';
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      HelpIcon(
                        title: 'Filtres',
                        description:
                            'Sélectionnez les types de boisson à afficher. Vous pouvez combiner plusieurs filtres.',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Wines Count
                  Text(
                    '${filteredWines.length} bouteille${filteredWines.length != 1 ? 's' : ''}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Wine Grid
                  if (filteredWines.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32.0),
                        child: Column(
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
                          ],
                        ),
                      ),
                    )
                  else
                    WineGrid(
                      wines: filteredWines,
                      onView: (id) {
                        final wine = filteredWines.firstWhere(
                          (w) => w['id'] == id,
                        );
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => WineDetailScreen(wine: wine),
                          ),
                        );
                      },
                      onEdit: (id) {
                        final wine = filteredWines.firstWhere(
                          (w) => w['id'] == id,
                        );
                        _showEditWineDialog(context, wine);
                      },
                      onDelete: (id) async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Supprimer'),
                            content: const Text(
                              'Êtes-vous sûr de vouloir supprimer cette bouteille?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Annuler'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Supprimer'),
                              ),
                            ],
                          ),
                        );

                        if (confirmed == true) {
                          try {
                            await wineProvider.deleteWine(id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Bouteille supprimée'),
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Erreur: $e'),
                                backgroundColor: colorScheme.error,
                              ),
                            );
                          }
                        }
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
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

  void _showCreateWineDialog(BuildContext context) {
    final wineProvider = context.read<WineProvider>();
    final nameController = TextEditingController();
    final vintageController = TextEditingController();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          'Ajouter une bouteille',
          style: theme.textTheme.titleLarge?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Nom du vin',
                  hintText: 'Château Margaux',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: vintageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Millésime',
                  hintText: '2015',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
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
                    content: Text('Veuillez entrer un nom pour le vin'),
                  ),
                );
                return;
              }

              final wineData = {
                'name': name,
                'vintage': int.tryParse(vintageController.text.trim()),
              };

              try {
                await wineProvider.createWine(wineData);
                if (dialogContext.mounted) {
                  Navigator.of(dialogContext).pop();
                }
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Vin "$name" ajouté avec succès'),
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
            child: const Text('Ajouter'),
          ),
        ],
      ),
    );
  }

  void _showEditWineDialog(BuildContext context, Map<String, dynamic> wine) {
    final wineProvider = context.read<WineProvider>();
    final nameController = TextEditingController(text: wine['name']);
    final vintageController = TextEditingController(
      text: wine['vintage']?.toString() ?? '',
    );
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          'Modifier la bouteille',
          style: theme.textTheme.titleLarge?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Nom du vin',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: vintageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Millésime',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
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
                    content: Text('Veuillez entrer un nom pour le vin'),
                  ),
                );
                return;
              }

              final updatedWine = {
                ...wine,
                'name': name,
                'vintage': int.tryParse(vintageController.text.trim()),
              };

              try {
                await wineProvider.updateWine(wine['id'], updatedWine);
                if (dialogContext.mounted) {
                  Navigator.of(dialogContext).pop();
                }
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Vin "$name" modifié avec succès'),
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
            child: const Text('Modifier'),
          ),
        ],
      ),
    );
  }
}
