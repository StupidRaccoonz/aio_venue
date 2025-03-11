import 'package:aio_sport/themes/custom_theme.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(height: 70, width: 70, child: CircularProgressIndicator(color: CustomTheme.appColor)),
      ),
    );
  }
}
