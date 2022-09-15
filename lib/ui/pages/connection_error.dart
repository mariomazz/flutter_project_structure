import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../widgets/size_config.dart';

class ConnectionError extends StatelessWidget {
  const ConnectionError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/connection-error.png',
              height: Sizer.getProportionateScreenHeight(context, 200),
              width: Sizer.getProportionateScreenWidth(context, 200),
              fit: BoxFit.fitWidth,
            ),
          ),
          const Text(
            'Ooops',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: Sizer.getProportionateScreenWidth(context, 270),
            child: const Text(
              'Sembra che ci sia qualcosa che non va nella tua connessione internet. Controlla la tua connessione ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 19,
              ),
            ),
          ),
          SizedBox(
            height: Sizer.getProportionateScreenHeight(context, 50),
          ),
          GestureDetector(
            onTap: () async {
              await AppSettings.openWIFISettings();
            },
            child: Container(
              height: Sizer.getProportionateScreenHeight(context, 45),
              width: Sizer.getProportionateScreenWidth(context, 200),
              decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(
                      Sizer.getProportionateScreenHeight(context, 10))),
              child: const Center(
                child: Text(
                  'Wifi Setting',
                  style: TextStyle(
                      fontSize: 18,
                      color: AppTheme.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
