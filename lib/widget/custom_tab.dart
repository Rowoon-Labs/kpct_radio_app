import 'package:flutter/material.dart';

class CustomTab extends StatelessWidget {
  final String title;
  final bool selected;

  const CustomTab({
    required this.title,
    this.selected = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container();
}
