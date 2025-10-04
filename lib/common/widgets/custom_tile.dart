import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  const CustomTile({
    required this.icon,
    required this.color,
    required this.title,
    this.subTitle,
    this.trailing,
    this.onTap,
    super.key,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String? subTitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Container(
        height: 32,
        width: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: HSLColor.fromColor(color).withLightness(0.87).toColor(),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: color),
      ),
      title: Text(title),
      subtitle: subTitle != null
          ? Text(
              subTitle!,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            )
          : null,
      onTap: onTap,
      trailing: trailing,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
