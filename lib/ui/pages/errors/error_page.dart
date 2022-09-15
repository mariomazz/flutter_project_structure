import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.safeArea,
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'error',
              style: TextStyle(color: AppTheme.black),
            ),
            elevation: 0,
          ),
          body: const Center(
            child: Text('Errore imprevisto'),
          ),
        ),
      ),
    );
  }
}
