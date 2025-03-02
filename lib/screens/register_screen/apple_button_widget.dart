import 'package:flutter/material.dart';
import 'package:guess_the_toilet/l10n/s.dart';

class AppleBtn extends StatelessWidget {
  final Function() onPressed;
  const AppleBtn({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: TextButton(
          style: ButtonStyle(
              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)))),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/socials%2Fapple-black-logo.png?alt=media&token=c44581fa-6fd2-4ae2-bd85-18bfbe6386d2",
                width: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(S.of(context).continue_with_apple,
                  style: TextStyle(color: Colors.black, fontSize: 16)),
            ],
          ),
        ));
  }
}
