import 'package:flutter/material.dart';

import '../../general_methods/TextStyles.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.onTap,
    required this.title,
    required this.subTitle,
    required this.icon,
    this.trailing,
  }) : super(key: key);
  final VoidCallback onTap;
  final String title;
  final String subTitle;
  final IconData icon;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: Icon(icon),
      onTap: onTap,
      title: Text(
        title,
        style: TextStyles.listTileTitleStyle,
      ),
      subtitle: Text(
        subTitle,
        style: TextStyles.listTileSubTitleStyle,
      ),
      trailing: trailing == null
          ? null
          : Text(
              trailing!,
              textAlign: TextAlign.center,
              style: TextStyles.listTileSubTitleStyle,
            ),
    );
  }
}
