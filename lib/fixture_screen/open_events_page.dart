import 'package:flutter/material.dart';
import 'package:agalarla_mac/themecolors.dart';

class OpenEventsPage extends StatelessWidget {
  const OpenEventsPage({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.appSwatch.shade500,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
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
                    const SizedBox(height: 40),
                    Center(
                      child: Text('Açık Eventler',
                          style: TextStyle(
                              fontSize: 26,
                              color: neonGreen,
                              fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const Divider(
                color: Colors.grey,
                height: 0,
              ),
              const SizedBox(height: 10),
              ListView.separated(
                itemCount: 3,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width - 20,
                    decoration: BoxDecoration(
                        color: Palette.appSwatch.shade700,
                        borderRadius: BorderRadius.all(Radius.circular(24))),
                    child: Center(child: Text('Placeholder')),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 5);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}