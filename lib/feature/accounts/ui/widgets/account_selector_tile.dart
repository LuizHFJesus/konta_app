import 'package:flutter/material.dart';

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

    return ListTile(
      leading: Container(
        height: 32,
        width: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: theme.colorScheme.surfaceContainerHighest,
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: color),
      ),
      title: Text(name),
      subtitle: Text(
        'Saldo: R\$ ${balance.toStringAsFixed(2)}',
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      onTap: onTap,
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: theme.colorScheme.primary,
            )
          : null,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: theme.colorScheme.outline),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
