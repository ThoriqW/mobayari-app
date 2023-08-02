import 'package:flutter/material.dart';
import 'package:mobayari_app_dev/utils/global.colors.dart';

class ButtonGlobal extends StatelessWidget {
  const ButtonGlobal({Key? key, required this.text, required this.onTap})
      : super(key: key);
  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {onTap()},
      child: Ink(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: GlobalColors.mainColor,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
