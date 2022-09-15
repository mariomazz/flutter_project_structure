import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/autentication/auth_provider.dart';
import '../../core/language/it.dart';
import '../theme/theme.dart';
import '../widgets/size_config.dart';

class UnauthorizedPage extends StatelessWidget {
  const UnauthorizedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Icon(
              FontAwesomeIcons.ban,
              size: 150,
             // color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            '403',
            style: TextStyle(fontSize: 18),
          ),
          const Text(
            'Ooops',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: Sizer.getProportionateScreenWidth(context, 270),
            child: const Text(
              ItL.accessDeniedResource,
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
              await AuthProvider().logout();
            },
            child: Container(
              height: Sizer.getProportionateScreenHeight(context, 45),
              width: Sizer.getProportionateScreenWidth(context, 200),
              decoration: BoxDecoration(
                color: AppTheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  ItL.goToLoginLage,
                  style: TextStyle(
                    fontSize: 17,
                    color: AppTheme.textLight,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
