import 'package:flutter/material.dart';

class VerticalListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry contentPadding;
  final Color? backgroundColor;

  const VerticalListTile({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.onTap,
    this.contentPadding = const EdgeInsets.all(8.0),
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: contentPadding,
        color: backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (leading != null) Flexible(child: leading!),
            if (leading != null && (title != null || subtitle != null))
              SizedBox(height: 8),
            if (title != null)
              Flexible(
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.titleMedium!,
                  child: title!,
                ),
              ),
            if (title != null && subtitle != null) SizedBox(height: 4),
            if (subtitle != null)
              Flexible(
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.bodySmall!,
                  child: subtitle!,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
