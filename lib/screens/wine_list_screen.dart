import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wine_provider.dart';
import '../widgets/wine_card.dart';
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
        title: const Text('🍾 Mes Vins'),
        elevation: 0,
        backgroundColor: colorScheme.primary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to create wine screen
        },
        backgroundColor: colorScheme.primary,
        child: const Icon(Icons.add),
      ),
      body: Consumer<WineProvider>(
        builder: (context, provider, _) {
          if (provider.loading) {
            return Center(
              child: CircularProgressIndicator(
                color: colorScheme.primary,
              ),
            );
          }

          final wines = provider.wines;

          // Apply filters
          var filteredWines = wines;
          if (_searchController.text.isNotEmpty) {
            final query = _searchController.text.toLowerCase();
            filteredWines = wines
                .where((w) =>
                    w['name'].toString().toLowerCase().contains(query) ||
                    w['producer'].toString().toLowerCase().contains(query) ||
                    w['region'].toString().toLowerCase().contains(query))
                .toList();
          }

          if (_selectedType.isNotEmpty) {
            filteredWines =
                filteredWines.where((w) => w['type'] == _selectedType).toList();
          }

          if (_selectedRegion.isNotEmpty) {
            filteredWines =
                filteredWines.where((w) => w['region'] == _selectedRegion).toList();
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar
                  TextField(
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
                  const SizedBox(height: 16),

                  // Filter Chips
                  Wrap(
                    spacing: 8,
                    children: [
                      FilterChip(
                        label: const Text('Red'),
                        selected: _selectedType == 'Red',
                        onSelected: (selected) {
                          setState(() {
                            _selectedType = selected ? 'Red' : '';
                          });
                        },
                      ),
                      FilterChip(
                        label: const Text('White'),
                        selected: _selectedType == 'White',
                        onSelected: (selected) {
                          setState(() {
                            _selectedType = selected ? 'White' : '';
                          });
                        },
                      ),
                      FilterChip(
                        label: const Text('Rosé'),
                        selected: _selectedType == 'Rosé',
                        onSelected: (selected) {
                          setState(() {
                            _selectedType = selected ? 'Rosé' : '';
                          });
                        },
                      ),
                      FilterChip(
                        label: const Text('Sparkling'),
                        selected: _selectedType == 'Sparkling',
                        onSelected: (selected) {
                          setState(() {
                            _selectedType = selected ? 'Sparkling' : '';
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Wines Count
                  Text(
                    '${filteredWines.length} vin${filteredWines.length != 1 ? 's' : ''}',
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
                        final wine = filteredWines
                            .firstWhere((w) => w['id'] == id);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                WineDetailScreen(wine: wine),
                          ),
                        );
                      },
                      onEdit: (id) {
                        // TODO: Implement edit
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
                                onPressed: () =>
                                    Navigator.pop(context, false),
                                child: const Text('Annuler'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, true),
                                child: const Text('Supprimer'),
                              ),
                            ],
                          ),
                        );

                        if (confirmed == true) {
                          try {
                            await provider.deleteWine(id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Bouteille supprimée',
                                ),
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
}
