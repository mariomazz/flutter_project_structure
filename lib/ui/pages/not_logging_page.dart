import 'package:flutter/material.dart';
import '../../core/autentication/auth_provider.dart';
import '../../core/env/env.manager.dart';
import '../../core/language/it.dart';
import '../../core/open_browser/open_browser.dart';
import '../theme/theme.dart';
import '../widgets/progress.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool contLoaded = true;
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/images/smartpa-239.png',
              ),
              const Text(
                "${ItL.appTitle}\n\n",
                maxLines: 3,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'lato',
                  fontSize: 25,
                  letterSpacing: 0,
                  color: AppTheme.primary,
                ),
              ),
              /* const Text(
                'Comunicazioni',
                maxLines: 2,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'lato',
                  fontSize: 18,
                  letterSpacing: 0,
                  color: AppTheme.primary,
                ),
              ), */
              Center(
                child: AspectRatio(
                  aspectRatio: 317 / 58,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(58),
                    ),
                    child: contLoaded
                        ? TextButton(
                            onPressed: () async {
                              setState(() {
                                contLoaded = false;
                              });
                              try {
                                await AuthProvider()
                                    .login()
                                    .then((value) async {
                                  setState(() {
                                    contLoaded = true;
                                  });
                                });
                              } catch (e) {
                                setState(() {
                                  contLoaded = true;
                                });
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(AppTheme.primary),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.white,
                              ),
                            ),
                          )
                        : const ProgressWidget(
                            center: true,
                            color: AppTheme.primary,
                          ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await OpenBrowser.open(EnvManager().privacyUrl);
                },
                child: const Text(
                  "Privacy Policy",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
