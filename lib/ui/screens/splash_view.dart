import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.white,
        child: FlutterLogo(
          size: MediaQuery.of(context).size.height,
        ),
      ),
    );
  }
}
