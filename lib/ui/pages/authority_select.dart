import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/authorities/authority_provider.dart';
import '../../core/language/it.dart';
import '../theme/theme.dart';
import '../widgets/app_bar.dart';
import '../widgets/authority_card.dart';
import '../widgets/progress.dart';
import '../widgets/toast/toast.dart';
import '../widgets/vertical_list.dart';

class AuthoritySelect extends StatelessWidget {
  const AuthoritySelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthorityProvider>(
      builder: (context, provider, _) {
        final authorities = provider.authorities ?? [];
        final isLoadingAuthorities = provider.isLoadingAuthorities;

        if (isLoadingAuthorities) {
          return const ProgressWidget(center: true);
        }

        return Scaffold(
          appBar: MainAppBar(
            text: ItL.authorityPageTitle,
            leadingAction: () {
              context.pop();
            },
          ),
          backgroundColor: AppTheme.background,
          body: Column(
            children: [
              Expanded(
                child: VerticalList(
                  noElements: const Text(ItL.noAuthorityMessage),
                  elements: authorities
                      .map<Widget>(
                        (e) => AuthorityCard(
                          authority: e,
                          onTap: () async {
                            if (!e.isDefault) {
                              await provider.select(e.authorityId);
                            }

                            ShowToast.showToast(ItL.selectAuthorityMessage);
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
