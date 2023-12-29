import 'package:flutter/material.dart';
import 'package:shop_app/constants/constants_colors.dart';

class PrimaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;

  const PrimaryButton({super.key, this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
            title,
            style: TextStyle(
              fontSize: 18
            ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: kprimaryColor,
        ),
      ),
    );
  }
}
