import 'package:flutter/material.dart';

class DrawerItem extends StatefulWidget {
  const DrawerItem({
    Key? key,
    required this.name,
    required this.icon,
    required this.onTap, // Rename 'onPressed' to 'onTap'
  }) : super(key: key);

  final String name;
  final IconData icon;
  final Function() onTap; // Rename 'onPressed' to 'onTap'

  @override
  _DrawerItemState createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isTapped = !_isTapped;
        });
        widget.onTap(); // Change 'onPressed' to 'onTap'
      },
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            Icon(
              widget.icon,
              size: 20,
              color: _isTapped ? Colors.orange : Colors.black,
            ),
            const SizedBox(
              width: 40,
            ),
            Text(
              widget.name,
              style: TextStyle(
                fontSize: 20,
                color: _isTapped ? Colors.orange : Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
