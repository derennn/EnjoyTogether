import 'package:flutter/material.dart';
import 'package:agalarla_mac/event/event_class.dart';

class OpenEventFocused extends StatelessWidget {
  const OpenEventFocused({
    required this.event,
    Key? key,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          const Text('Event Detayları',
              style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500)),
          const SizedBox(height: 12,),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              children: <TextSpan>[
                TextSpan(text: ('[tarih]')),
                TextSpan(text: ' tarihinde ', style: TextStyle(color: Colors.grey,),),
                TextSpan(text: ('[Açan Kişi]')),
                TextSpan(text: ' tarafından açıldı.', style: TextStyle(color: Colors.grey,),)
              ],
            ),
          ),
          const SizedBox(height: 5,),
          RichText(
            text: TextSpan(
                children: <TextSpan>[
                  TextSpan(text: (event.arkadasGrubu)),
                  const TextSpan(text: ' ile paylaşıldı.', style: TextStyle(color: Colors.grey,),),
                ]
            ),
          ),
          const SizedBox(height: 5,),
          RichText(
            text: TextSpan(
                children: <TextSpan>[
                  TextSpan(text: (event.lokasyon)),
                  const TextSpan(text: ' lokasyonunda olacak.', style: TextStyle(color: Colors.grey,),),
                ]
            ),
          ),
          const SizedBox(height: 25,),
          CircleAvatar(
            radius: 18,
            child: ClipOval(
              child: Image.asset(
                "assets/gutter.png",
              ),
            ),
          ),
          const SizedBox(height: 8,),
          const Text('"Gelmeyen orospu çocuğudur"', style: TextStyle(color: Colors.grey, fontSize: 16,)),
          const SizedBox(height: 15,),
          const Divider(
            color: Colors.grey,
          ),
          const SizedBox(height: 8,),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: const [
                    Text('Ayrıntılar')
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text('Katılanlar', style: Theme.of(context).textTheme.bodyMedium,),
                    const SizedBox(height: 5,),
                    SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              childCount: 4,
                              (context, index) {
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  horizontalTitleGap: 0,
                                  visualDensity: const VisualDensity(vertical: -1.5),
                                  dense: true,
                                  leading: CircleAvatar(
                                    radius: 14,
                                    child: ClipOval(
                                      child: Image.asset(
                                        "assets/gutter.png",
                                      ),
                                    ),
                                  ),
                                  title:  const Text('[Name]', style: TextStyle(color: Colors.grey),),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}