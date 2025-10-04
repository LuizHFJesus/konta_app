import 'package:flutter/material.dart';

class TileSelectorBottomSheet<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final T? selectedItem;
  final Widget Function(BuildContext context, T item, bool isSelected) itemBuilder;
  final void Function(T item) onItemSelected;

  const TileSelectorBottomSheet({
    super.key,
    required this.title,
    required this.items,
    required this.itemBuilder,
    required this.onItemSelected,
    this.selectedItem,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: theme.textTheme.titleMedium),
          const SizedBox(height: 16),
          Flexible(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: items.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final item = items[index];
                final isSelected = item == selectedItem;

                return InkWell(
                  onTap: () => onItemSelected(item),
                  child: itemBuilder(context, item, isSelected),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
