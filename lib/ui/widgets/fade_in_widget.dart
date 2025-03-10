import 'package:flutter/material.dart';

class FadeInWidget extends StatefulWidget {
  final Widget widgetToFadeIn;
  const FadeInWidget({super.key, required this.widgetToFadeIn});

  @override
  State<FadeInWidget> createState() => _FadeInWidgetState();
}

class _FadeInWidgetState extends State<FadeInWidget> {
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    // Simulate image loading
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isLoaded ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      child: widget.widgetToFadeIn,
    );
  }
}
