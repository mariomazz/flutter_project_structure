import 'package:flutter/material.dart';
import '../widgets/progress.dart';

class LoadPage extends StatelessWidget {
  const LoadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ProgressWidget(center: true),
      ),
    );
  }
}
