import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:agalarla_mac/repositories/fixtureblocks_repository.dart';
import 'package:agalarla_mac/themecolors.dart';
import 'package:agalarla_mac/fixture_screen/create_events_page.dart';
import 'package:agalarla_mac/fixture_screen/open_events_screen/open_events_page.dart';

class FixturePage extends ConsumerWidget {
  const FixturePage({
    Key? key,
    required this.mainScreenContext,
    required this.onScreenHideButtonPressed,
    required this.hideStatus,
  }) : super(key: key);

  final BuildContext mainScreenContext;
  final VoidCallback onScreenHideButtonPressed;
  final bool hideStatus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Palette.appSwatch.shade500,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                  itemCount: ref.read(fixtureBlockProvider),
                  itemBuilder: (context, index) {
                    return FixtureBlock(index: index);
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FixtureBlock extends StatelessWidget {
  const FixtureBlock({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(18),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Palette.appSwatch.shade300,
            Palette.appSwatch.shade400,
          ],
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            'Super Lig',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Galatasaray',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                '-',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'Fenerbahçe',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '19.00',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                onPressed: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: OpenEventsPage(),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: const Text('Açık Eventler',
                    style: TextStyle(color: Color(0xff1be2c7))),
              ),
              const SizedBox(width: 20),
              FixtureEventButtonHero(index: index),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}