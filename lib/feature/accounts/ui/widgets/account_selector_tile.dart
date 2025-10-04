import 'package:flutter/material.dart';
import 'package:konta_app/common/widgets/custom_tile.dart';

class AccountSelectorTile extends StatelessWidget {
  const AccountSelectorTile({
    required this.icon,
    required this.color,
    required this.name,
    required this.balance,
    required this.onTap,
    required this.isSelected,
    super.key,
  });

  final IconData icon;
  final Color color;
  final String name;
  final double balance;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomTile(
      icon: icon,
      color: color,
      title: name,
      subTitle: 'Saldo: R\$ ${balance.toStringAsFixed(2)}',
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: theme.colorScheme.primary,
            )
          : null,
      onTap: onTap,
    );
  }
}
