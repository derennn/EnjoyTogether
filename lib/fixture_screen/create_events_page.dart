import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agalarla_mac/themecolors.dart';

class FixtureEventButtonHero extends StatelessWidget {
  const FixtureEventButtonHero({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: index.toString(),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              backgroundColor: Color(0xff1be2c7)),
          onPressed: () {
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: CreateEventPage(index: index),
              withNavBar: false, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          },
          child: Text(
            'Event Aç >',
            style: TextStyle(color: Palette.appSwatch.shade300),
          )),
    );
  }
}

class CreateEventPage extends ConsumerStatefulWidget {
  const CreateEventPage({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends ConsumerState<CreateEventPage> {

  final Map<String, dynamic> girilen = {};
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.appSwatch.shade500,
      body: SafeArea(
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
                    child: Text('Event Aç',
                        style: TextStyle(
                            fontSize: 26,
                            color: neonGreen,
                            fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Form(
                key: _formKey,
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Galatasaray - Fenerbahçe'),
                      Text('19 Kasım'),
                      Text('21.45'),
                      TextFormField(
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: const InputDecoration(
                          hintText: 'Event Nerede Olacak?'
                        ),
                        validator: (value) {
                          if (value?.isNotEmpty == true) {
                            return 'Lokasyon neresi?';
                          }
                        },
                        onSaved: (newValue) {
                          girilen['lokasyon'] = newValue;
                        },
                      ),
                      const SizedBox(height: 20,),
                      DropdownButtonFormField(
                        hint: Text('Hangi Arkadaş Grubu ile Paylaşılsın?',
                        style: const TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        decoration: InputDecoration(
                          border: Theme.of(context).inputDecorationTheme.border,
                          enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
                          focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
                          hintText: 'Event nerede olacak?',
                        ),
                        dropdownColor: Palette.appSwatch.shade300,
                        items: [
                          DropdownMenuItem(
                            value: 'Arkadaş grubu 1',
                              child: Text('Arkadaş grubu 1', style: Theme.of(context).textTheme.bodySmall),
                          ),
                          DropdownMenuItem(
                            value: 'Arkadaş grubu 2',
                              child: Text('Arkadaş grubu 2', style: Theme.of(context).textTheme.bodySmall),
                          ),
                        ],
                        value: girilen['arkadasgrubu'],
                        onChanged: (value) {

                        },
                        validator: (value) {
                          return 'Hangi arkadaş grubuyla paylaşılsın?';
                        },
                        onSaved: (newValue) {
                          setState(() {
                            girilen['arkadasgrubu'] = newValue;
                          });
                        },
                      ),
                      FormField(
                          builder: (field) {
                            return Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Deneme 1 2 3'),
                                  field.hasError
                                  ? Text(
                                    field.errorText!,
                                    style: TextStyle(color: Colors.red)
                                  )
                                  : Container(),
                                  RadioListTile(
                                      value: 'value',
                                      groupValue: 'group value',
                                      onChanged: (value) {
                                        value = value;
                                      },
                                  ),

                                ],
                              ),
                            );
                          },
                        validator: (value) {
                          if (value != true ) {
                            return 'please choose sth';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Material(
              color: Palette.appSwatch.shade500,
              child: Hero(
                tag: widget.index.toString(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12))),
                        backgroundColor: Color(0xff1be2c7)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Arkadaşlarınla Paylaş',
                        style: TextStyle(
                            color: Palette.appSwatch.shade300, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
