import 'package:flutter/material.dart';

class PickerBottomSheet<T> extends StatelessWidget {
  const PickerBottomSheet({
    super.key,
    required this.title,
    required this.items,
    required this.itemBuilder,
    this.crossAxisCount = 4,
  });

  final String title;
  final List<T> items;
  final Widget Function(T item) itemBuilder;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(4),
            ),
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) => itemBuilder(items[index]),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
