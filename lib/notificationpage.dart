import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'themecolors.dart';
import 'package:agalarla_mac/repositories/notifications_repository.dart';

class NotificationPage extends ConsumerStatefulWidget {
  NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
  String? imagePath;

  Future<String> getImagePath() async{
    return "https://picsum.photos/200";
  }

  void path() async {
    imagePath = await Future.delayed(Duration(seconds: 1)).then((value) => getImagePath());
    setState(() {});
    //print('gorsel geldi');
  }

  @override
  void initState() {
    getImagePath();
    path();
    super.initState();
  }

  @override
  void dispose() {
    ref.read(notificationsProvider.notifier).sifirla();
    print('${ref.read(notificationsProvider)}'); //widget dispose olmuyor, o problemi çöz
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.appSwatch.shade400,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Text('Bildirimler',
              style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: 28),
              ),
              const Divider(
                color: Colors.white,
                height: 25,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: 7,
                    itemBuilder: (context, index) {
                      return ListTile(
                        trailing: ref.watch(notificationsProvider)
                        ? DecoratedBox(
                          decoration: BoxDecoration(shape: BoxShape.circle, color: neonGreen),
                          child: SizedBox(
                            height: 8,
                            width: 8,
                          ),
                        )
                        : null,
                        leading: ClipOval(
                          child: Container(
                            height: 40,
                            width: 40,
                            child: imagePath == null
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : Image.network(imagePath!),
                            decoration: BoxDecoration(shape: BoxShape.circle),
                          ),
                        ),
                        title: Text('Alp 19 Aralık Galatasaray Fenerbahçe maçı için event açtı.',
                        style: Theme.of(context).textTheme.bodySmall,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      );
                    },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.white,
                      indent: 8,
                      endIndent: 8,
                      height: 4,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}