import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double barHeight = 65;

class LastFmAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool backButton;
  final Widget? actionWidget;
  const LastFmAppBar(
      {Key? key,
      required this.title,
      this.backButton = true,
      this.actionWidget})
      : super(key: key);
  @override
  Widget build(BuildContext context) => AppBar(
      backgroundColor: Colors.black,
      automaticallyImplyLeading: backButton,
      actions: actionWidget == null ? null : [actionWidget!],
      leading: backButton
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      title: Container(
        alignment: backButton ? null : Alignment.center,
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ));

  @override
  Size get preferredSize => const Size.fromHeight(barHeight);
}
