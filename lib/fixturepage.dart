import 'package:flutter/material.dart';
import 'themecolors.dart';

class FixturePage extends StatelessWidget {
  const FixturePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.appSwatch.shade200,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ListView.separated(
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return const FixtureBlock();
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 8,
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
  }) : super(key: key);

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
            Palette.appSwatch.shade500,
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
                onPressed: () {},
                child: const Text('Açık Eventler',
                    style: TextStyle(color: Color(0xff1be2c7))),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      backgroundColor: Color(0xff1be2c7)),
                  onPressed: () {},
                  child: Text(
                    'Event Aç >',
                    style: TextStyle(color: Palette.appSwatch.shade300),
                  )),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
