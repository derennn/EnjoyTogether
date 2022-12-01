import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'dart:async';
import 'themecolors.dart';
import 'package:agalarla_mac/repositories/notifications_repository.dart';

class NotificationPage extends ConsumerStatefulWidget {
  NotificationPage({
    Key? key,
    required this.mainScreenContext,
    required this.onScreenHideButtonPressed,
    required this.hideStatus,
  }) : super(key: key);

  final BuildContext mainScreenContext;
  final VoidCallback onScreenHideButtonPressed;
  final bool hideStatus;

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
  String? imagePath;

  Future<String> getImagePath() async{
    return "https://picsum.photos/200";
  }

  void path() async {
    imagePath = await Future.delayed(const Duration(seconds: 1)).then((value) => getImagePath());
    setState(() {});
    //print('gorsel geldi');
  }


  @override
  void initState() {
    getImagePath();
    path();
    Future.delayed(const Duration(seconds: 3)).then((value) => ref.read(notificationProvider2.notifier).update((state) => !state));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.appSwatch.shade500,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Text('Bildirimler',
              style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: 28),
              ),
              const Divider(
                thickness: 1,
                color: Colors.grey,
                height: 25,
              ),
              ListView.separated(
                itemCount: 7,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      trailing: AnimatedContainer(
                        height: 8,
                        width: 8,
                        duration: const Duration(milliseconds: 400),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: ref.watch(notificationProvider2) ? neonGreen : Colors.transparent),
                      ),
                      leading: ClipOval(
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(shape: BoxShape.circle),
                          child: imagePath == null
                          ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                          : Image.network(imagePath!),
                        ),
                      ),
                      title: Text('Alp 19 Aralık GS - FB maçı için event açtı.',
                      style: Theme.of(context).textTheme.bodySmall,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    );
                  },
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                    indent: 8,
                    endIndent: 8,
                    height: 4,
                  );
                },
              ),
              FloatingActionButton(
                backgroundColor: neonGreen,
                  onPressed: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: Scaffold(
                        backgroundColor: Palette.appSwatch.shade500,
                        body: SafeArea(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Center(child: Text('Deneme')),
                             FloatingActionButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  },
                               child: const Text('Back',
                               textAlign: TextAlign.center,),
                              ),
                            ],
                          ),
                        ),
                      ),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.slideUp,
                    );
                  },
                child: const Text('new page',
                textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}