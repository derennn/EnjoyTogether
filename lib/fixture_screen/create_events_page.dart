import 'package:agalarla_mac/services/data_services.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agalarla_mac/themecolors.dart';
import 'package:agalarla_mac/basic_classes/event_class.dart';

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

  final Map<String, dynamic> values = {};
  final _formKey = GlobalKey<FormState>();
  bool? _radioSecilen;
  bool isSaving = false;


  Future<void> saveFunc (value) async {

      try {
        setState(() {
          isSaving = true;
        });
        await convertToEventMapAndSave();
        if (!mounted) return;
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Event açıldı! Lokasyon: ${values['lokasyon']}, Arkadaş grubu: ${values['arkadasGrubu']}, '
                  'Arkadaş getirmek serbest: ${values['arkadasGetirmekSerbestMi'] ? 'Evet' : 'Hayır'}, '
                  'Açıldığı tarih: ${values['acildigiTarih']}, Açan Kişi: ${values['acanKisi']}'
            ),
            backgroundColor: Palette.appSwatch.shade700,
          ),
        );
      } catch (e) {
        setState(() {
          isSaving = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Event açılırken bir sorun oluştu. Lütfen daha sonra tekrar deneyin ${e}',
            ),
            backgroundColor: Palette.appSwatch.shade700,
          ),
        );
      } finally {
        setState(() {
          isSaving = false;
        });
      }
  }

  Future<void> convertToEventMapAndSave() async {
    await ref.read(dataServiceProvider).addEvent(
        Event.fromMap(values)
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.appSwatch.shade500,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              constraints: const BoxConstraints(
                minHeight: 150,
              ),
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
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        height: 40,
                        child: BackButton(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: const <TextSpan>[
                          TextSpan(text: 'Galatasaray - Fenerbahçe'),
                          TextSpan(text: '\n21.45\n19 Kasım', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400)),
                        ],
                        style: TextStyle(
                              fontSize: 26,
                              color: neonGreen,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: const InputDecoration(
                              hintText: 'Event Nerede Olacak?'),
                          validator: (value) {
                            if (value?.isEmpty == true) {
                              return 'Lokasyon neresi?';
                            }
                          },
                          onSaved: (newValue) {
                            values['lokasyon'] = newValue;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField(
                          hint: const Text(
                            'Hangi Arkadaş Grubu ile Paylaşılsın?',
                            style:
                                const TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          decoration: InputDecoration(
                            border: Theme.of(context).inputDecorationTheme.border,
                            enabledBorder: Theme.of(context)
                                .inputDecorationTheme
                                .enabledBorder,
                            focusedBorder: Theme.of(context)
                                .inputDecorationTheme
                                .focusedBorder,
                            hintText: 'Event nerede olacak?',
                          ),
                          dropdownColor: Palette.appSwatch.shade300,
                          items: [
                            DropdownMenuItem(
                              value: 'Arkadaş grubu 1',
                              child: Text('Arkadaş grubu 1',
                                  style: Theme.of(context).textTheme.bodySmall),
                            ),
                            DropdownMenuItem(
                              value: 'Arkadaş grubu 2',
                              child: Text('Arkadaş grubu 2',
                                  style: Theme.of(context).textTheme.bodySmall),
                            ),
                          ],
                          value: values['arkadasGrubu'],
                          onChanged: (value) {},
                          validator: (value) {
                            if (value == null) {
                              return 'Bir arkadaş grubu seç';
                            }
                          },
                          onSaved: (newValue) {
                            setState(() {
                              values['arkadasGrubu'] = newValue;
                            });
                          },
                        ),
                        FormField(
                          initialValue: _radioSecilen,
                          builder: (field) {
                            return Padding(
                              padding: EdgeInsets.only(top: 14, left: 14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Arkadaş getirmek serbest mi?',
                                  style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                  AnimatedContainer(
                                    curve: Curves.ease,
                                        duration: Duration(milliseconds: 300),
                                        height: field.hasError ? 35 : 0,
                                        child: AnimatedCrossFade(
                                          firstChild: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text('${field.errorText}',
                                                style: TextStyle(color: Colors.red, fontSize: Theme.of(context).textTheme.bodySmall!.fontSize)),
                                          ),
                                          secondChild: const SizedBox(),
                                          crossFadeState: field.hasError ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                                          duration: Duration(milliseconds: 300),
                                        ),
                                      ),
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                    title: Text('Evet',
                                    style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                    leading: Radio<bool>(
                                      fillColor: MaterialStateColor.resolveWith((states) => neonGreen),
                                      value: true,
                                      groupValue: _radioSecilen,
                                      onChanged: (value) {
                                        setState(() {
                                          _radioSecilen = value;
                                        });
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                    title: Text('Hayır',
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                    leading: Radio<bool>(
                                      fillColor: MaterialStateColor.resolveWith((states) => neonGreen),
                                      value: false,
                                      groupValue: _radioSecilen,
                                      onChanged: (value) {
                                        setState(() {
                                          _radioSecilen = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Lütfen birini seçin';
                            }
                          },
                          onSaved: (newValue) {
                            setState(() {
                              values['arkadasGetirmekSerbestMi'] = newValue;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        isSaving
                        ?  const Center(child: CircularProgressIndicator())
                        :  Material(
                            color: Palette.appSwatch.shade500,
                            child: Hero(
                              tag: widget.index.toString(),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                    backgroundColor: Color(0xff1be2c7)),
                                onPressed: () {
                                  final formState = _formKey.currentState;
                                  if (formState == null) return print('formState == null');
                                  if (formState.validate() == true) {
                                    String now = DateTime.now().toIso8601String();
                                    values['acildigiTarih'] = now;
                                    values['acanKisi'] = 'Deren';
                                    formState.save();
                                    saveFunc(values);
                                  }
                                },
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    'Event Aç',
                                    style: TextStyle(
                                        color: Palette.appSwatch.shade300, fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
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