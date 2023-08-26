import 'package:flutter/material.dart';

import '../../utils/global.colors.dart';

class FilterModalGlobal extends StatefulWidget {
  const FilterModalGlobal(
      {super.key,
      required this.categories,
      required this.onApplyFilter,
      required this.onResetFilter,
      required this.selectedCategories});

  final List<String> categories;
  final List<String> selectedCategories;
  final Function() onApplyFilter;
  final Function() onResetFilter;

  @override
  State<FilterModalGlobal> createState() => _FilterModalGlobalState();
}

class _FilterModalGlobalState extends State<FilterModalGlobal> {
  void toggleCategory(String category) {
    setState(() {
      if (widget.selectedCategories.contains(category)) {
        widget.selectedCategories.remove(category);
      } else {
        widget.selectedCategories.add(category);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Pilih RT'),
          content: SizedBox(
            width: 500,
            child: Wrap(
              spacing: 8.0,
              children: widget.categories.map((category) {
                final bool isSelected =
                    widget.selectedCategories.contains(category);
                return FilterChipItem(
                  category: category,
                  isSelected: isSelected,
                  onChanged: (selected) => toggleCategory(category),
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                widget.onResetFilter();
                Navigator.pop(context);
              },
              child: Text(
                'Batal',
                style: TextStyle(color: GlobalColors.textColor),
              ),
            ),
            TextButton(
              onPressed: () {
                widget.onApplyFilter();
                Navigator.pop(context);
              },
              child: Text('Terapkan',
                  style: TextStyle(color: GlobalColors.textColor)),
            ),
          ],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: GlobalColors.mainColor,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.sort,
            size: 16,
            color: GlobalColors.whiteColor,
          ),
        ),
      ),
    );
  }
}

class FilterChipItem extends StatefulWidget {
  const FilterChipItem(
      {super.key,
      required this.category,
      required this.isSelected,
      required this.onChanged});

  final String category;
  final bool isSelected;
  final Function(bool selected) onChanged;

  @override
  State<FilterChipItem> createState() => _FilterChipItemState();
}

class _FilterChipItemState extends State<FilterChipItem> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.category),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          isSelected = selected;
        });
        widget.onChanged(selected);
      },
      selectedColor: GlobalColors.mainColor,
      checkmarkColor: GlobalColors.whiteColor,
      labelStyle: TextStyle(
        color: isSelected ? GlobalColors.whiteColor : GlobalColors.textColor,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
