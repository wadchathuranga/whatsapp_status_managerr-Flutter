import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class ViewImageScreen extends StatefulWidget {
  const ViewImageScreen({Key? key, required this.image}) : super(key: key);

  final String image;

  @override
  State<ViewImageScreen> createState() => _ViewImageScreenState();
}

class _ViewImageScreenState extends State<ViewImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Image View'),
      ),
      body: Container(
        child: Image(
          image: NetworkImage(widget.image),
        ),
      ),
    );
  }
}
