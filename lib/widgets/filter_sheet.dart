import 'package:flutter/material.dart';
import 'package:book_store_plus/models/filter.dart';
import 'package:book_store_plus/models/genre.dart';

class FilterSheet extends StatefulWidget {
  final Filter? current;

  const FilterSheet({super.key, this.current});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  List<Genre> selectedGenres = [];
  double minPrice = 0;
  double maxPrice = 10000;
  int? ageLimit;

  @override
  void initState() {
    super.initState();

    if (widget.current != null) {
      selectedGenres = [...?widget.current!.genres];
      minPrice = widget.current!.minPrice ?? 0;
      maxPrice = widget.current!.maxPrice ?? 10000;
      ageLimit = widget.current!.ageLimit;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: DraggableScrollableSheet(
        expand: false,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        builder: (context, controller) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: ListView(
              controller: controller,
              padding: const EdgeInsets.all(16),
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                Text(
                  "Фильтры",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),

                const SizedBox(height: 20),

                Text("Жанры", style: Theme.of(context).textTheme.titleMedium),
                Wrap(
                  spacing: 8,
                  children:
                      Genre.values.map((genre) {
                        final isSelected = selectedGenres.contains(genre);
                        return ChoiceChip(
                          label: Text(genre.name),
                          selected: isSelected,
                          onSelected: (_) {
                            setState(() {
                              isSelected
                                  ? selectedGenres.remove(genre)
                                  : selectedGenres.add(genre);
                            });
                          },
                        );
                      }).toList(),
                ),

                const SizedBox(height: 30),

                Text("Цена", style: Theme.of(context).textTheme.titleMedium),
                RangeSlider(
                  values: RangeValues(minPrice, maxPrice),
                  min: 0,
                  max: 10000,
                  divisions: 100,
                  labels: RangeLabels(
                    "${minPrice.toInt()} ₽",
                    "${maxPrice.toInt()} ₽",
                  ),
                  onChanged: (values) {
                    setState(() {
                      minPrice = values.start;
                      maxPrice = values.end;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("От: ${minPrice.toInt()} ₽"),
                    Text("До: ${maxPrice.toInt()} ₽"),
                  ],
                ),

                const SizedBox(height: 30),

                Text(
                  "Возрастное ограничение",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                DropdownButton<int>(
                  isExpanded: true,
                  value: ageLimit,
                  hint: const Text("Не выбрано"),
                  items:
                      [6, 12, 16, 18].map((e) {
                        return DropdownMenuItem(value: e, child: Text("$e+"));
                      }).toList(),
                  onChanged: (value) {
                    setState(() => ageLimit = value);
                  },
                ),

                const SizedBox(height: 40),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context, Filter.none());
                        },
                        child: const Text("Сбросить"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                            Filter(
                              genres:
                                  selectedGenres.isEmpty
                                      ? null
                                      : selectedGenres,
                              minPrice: minPrice,
                              maxPrice: maxPrice,
                              ageLimit: ageLimit,
                            ),
                          );
                        },
                        child: const Text("Применить"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
