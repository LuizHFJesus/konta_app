import 'package:flutter/material.dart';

class AccountTile extends StatelessWidget {
  const AccountTile({
    required this.icon,
    required this.color,
    required this.name,
    required this.balance,
    required this.trailing,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final Color color;
  final String name;
  final double balance;
  final Widget? trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Container(
        height: 32,
        width: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
            color: HSLColor.fromColor(color).withLightness(0.85).toColor(),
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
      trailing: trailing,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: theme.colorScheme.outline),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
