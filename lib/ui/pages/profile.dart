import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/language/it.dart';
import '../../core/providers/profile_provider.dart';
import '../theme/theme.dart';
import '../widgets/pop_up/pop_up.dart';
import '../widgets/progress.dart';
import '../widgets/show_dialog/show_dialog.dart';
import '../widgets/size_config.dart';
import '../widgets/sliver_appbar_image.dart';
import '../widgets/toast/toast.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile>
    with AutomaticKeepAliveClientMixin<Profile> {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    Provider.of<ProfileProvider>(context, listen: false).loadUserLogged();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<ProfileProvider>(builder: (context, userData, _) {
      return PopUp(
        builder: const ProgressWidget(),
        controller: userData.loadingController,
        child: Scaffold(
          backgroundColor: AppTheme.background,
          body: SafeArea(
            top: false,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: AppTheme.background,
                  expandedHeight:
                      Sizer.getProportionateScreenHeight(context, 250.0),
                  floating: false,
                  stretch: true,
                  pinned: true,
                  flexibleSpace: Stack(
                    children: <Widget>[
                      SliverAppBarImage(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    if (userData.user?.avatarUrl != null) {
                                      ShowDialog.image(
                                          context, userData.user!.avatarUrl!);
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(20),
                                    height: Sizer.getProportionateScreenHeight(
                                        context, 100),
                                    width: Sizer.getProportionateScreenWidth(
                                        context, 100),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(Sizer
                                                .getProportionateScreenWidth(
                                                    context, 100)))),
                                    child: CachedNetworkImage(
                                      imageUrl: userData.user?.avatarUrl ?? '',
                                      placeholder: (context, url) =>
                                          const ProgressWidget(),
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width:
                                            Sizer.getProportionateScreenWidth(
                                                context, 80),
                                        height:
                                            Sizer.getProportionateScreenHeight(
                                                context, 80),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(
                                        Icons.account_circle,
                                        size: 120,
                                        color: AppTheme.iconPrimary
                                            .withOpacity(0.5),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: Container(
                                    /* height: 25,
                                        width: 25, */
                                    decoration: const BoxDecoration(
                                      color: AppTheme.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: IconButton(
                                      onPressed: () async {
                                        try {
                                          userData.loadingController.show();
                                          final result = await userData
                                              .changeAvatarAndUpdateProfile();

                                          userData.loadingController.close();

                                          if (result) {
                                            ShowToast.showToast(
                                                ItL.doneSavingProfilePicture);
                                          }
                                        } catch (e) {
                                          userData.loadingController.close();
                                          ShowToast.showToast(
                                              ItL.errorSavingProfilePicture);
                                        }
                                      },
                                      icon: const SizedBox.expand(
                                        child: Icon(
                                          Icons.create,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                left: 4,
                                right: 4,
                                top: 4,
                                bottom: 2,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: AppTheme.card,
                              ),
                              child: Text(
                                userData.userBaseInfo,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppTheme.textPrimaryLight,
                                  fontFamily: 'lato',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: -1,
                        left: 0,
                        right: 0,
                        child: Container(
                          height:
                              Sizer.getProportionateScreenHeight(context, 30),
                          decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(
                                Sizer.getProportionateScreenWidth(
                                  context,
                                  50,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverFixedExtentList(
                  itemExtent: 60,
                  delegate: SliverChildListDelegate([
                    ..._getTiles(context),
                  ]),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  /* Map<String, dynamic Function()?> _getTilesActions(BuildContext context) {
    return {
      "email": null,
      "privacy": () async {
        await OpenBrowser.open(EnvManager().privacyUrl);
      },
      "authoritySelection": () async {
        context.goNamed(Routes.authoritySelectN,
            params: {"navigation": Routes.profileN});
      },
      "logout": () async {
        await _logoutAlert();
      },
    };
  } */

  List<Widget> _getTiles(BuildContext context) {
    /* final actions = _getTilesActions(context);
    const data = ItL.profileTiles; */
    final widgets = <Widget>[];
    /* data.forEach((key, value) {
      final enableAction = value["action"] as bool;
      final action = actions[key];
      final title = value["title"] as String;
      final subtitle = value["subtitle"] as String?;
      final icon = value["icon"] as IconData?;
      widgets.add(ProfileTile(
        title: title,
        onTap: enableAction ? action : null,
        subtitle: subtitle,
        icon: icon,
      ));
    }); */

    return widgets;
  }
}
