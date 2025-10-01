import 'package:flutter/material.dart';
import 'package:konta_app/feature/accounts/ui/widgets/account_tile.dart';

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

    return AccountTile(
      icon: icon,
      color: color,
      name: name,
      balance: balance,
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
