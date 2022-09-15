import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/language/it.dart';
import '../../theme/theme.dart';

class Navigation extends StatefulWidget {
  const Navigation({
    Key? key,
    required this.routeName,
    required this.homeRouteName,
    required this.profileRouteName,
    required this.home,
    required this.profile,
    required this.favoritesRouteName,
    required this.defaultRouteName,
    required this.favorites,
  }) : super(key: key);

  final String routeName;
  final String homeRouteName;
  final String profileRouteName;
  final String favoritesRouteName;
  final String defaultRouteName;

  final Widget home;
  final Widget profile;
  final Widget favorites;

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  late int _index = current(widget.routeName);
  late final PageController _pageController =
      PageController(initialPage: _index);

  late final _pages = <Widget>[widget.home, widget.favorites, widget.profile];

  dynamic current(dynamic route, {bool returnWidget = false}) {
    if (route is int) {
      if (route == 0) {
        if (returnWidget) {
          return widget.home;
        }
        return widget.homeRouteName;
      }
      if (route == 1) {
        if (returnWidget) {
          return widget.favorites;
        }
        return widget.favoritesRouteName;
      }
      if (route == 2) {
        if (returnWidget) {
          return widget.profile;
        }
        return widget.profileRouteName;
      }
      if (returnWidget) {
        return widget.home;
      }
      return widget.defaultRouteName;
    }

    if (route is String) {
      if (route == widget.homeRouteName) {
        if (returnWidget) {
          return widget.home;
        }
        return 0;
      }
      if (route == widget.favoritesRouteName) {
        if (returnWidget) {
          return widget.favorites;
        }
        return 1;
      }
      if (route == widget.profileRouteName) {
        if (returnWidget) {
          return widget.profile;
        }
        return 2;
      }
      if (returnWidget) {
        return widget.home;
      }
      return 0;
    }
    throw Exception("Input Type Error");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppTheme.background,
        currentIndex: _index,
        unselectedItemColor: AppTheme.grey,
        selectedItemColor: AppTheme.primary,
        onTap: (index) {
          setState(() {
            _index = index;
            _pageController.jumpToPage(_index);
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.news_solid),
            label: ItL.labelNavigationBar[current(0)],
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.bookmark_solid),
            label: ItL.labelNavigationBar[current(1)],
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.person_circle_fill),
            label: ItL.labelNavigationBar[current(2)],
          )
        ],
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
    );
  }
}




 // FOR WEB

      /* appBar: (MediaQuery.of(context).size.width >= 640)
          ? AppBar(
              title: const Text('Mario Mazzarelli .com'),
            )
          : null, */ // FOR MOBILE MediaQuery.of(context).size.width < 640


            // FOR WEB

          /* if (MediaQuery.of(context).size.width >= 640)
            NavigationRail(
              selectedIndex: current(routeName),
              onDestinationSelected: (index) {
                final selectRouteName = current(index);
                context.goNamed(selectRouteName);
              },
              labelType: NavigationRailLabelType.all,
              selectedLabelTextStyle: const TextStyle(
                color: Colors.amber,
              ),
              leading: Column(
                children: const [
                  SizedBox(
                    height: 8,
                  ),
                  CircleAvatar(
                    radius: 20,
                    child: Icon(Icons.person),
                  ),
                ],
              ),
              unselectedLabelTextStyle: const TextStyle(),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Preferiti'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Profilo'),
                ),
              ],
            ), */