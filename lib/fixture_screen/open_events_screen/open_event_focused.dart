import 'package:flutter/material.dart';
import 'package:agalarla_mac/event/event_class.dart';
import 'package:intl/intl.dart';

class OpenEventFocused extends StatefulWidget {
  const OpenEventFocused({
    required this.event,
    Key? key,
  }) : super(key: key);

  final Event event;

  @override
  State<OpenEventFocused> createState() => _OpenEventFocusedState();
}

class _OpenEventFocusedState extends State<OpenEventFocused> {

  final DateFormat dateFormatter = DateFormat('dd.MM.yyyy');
  final DateFormat timeFormatter = DateFormat('HH:mm');
  final now = DateTime.now();
  late int timePast;
  String dateFormatted = '';
  String timeFormatted = '';

  @override
  void initState() {
    super.initState();
    dateFormatted = dateFormatter.format(widget.event.acildigiTarih);
    timeFormatted = timeFormatter.format(widget.event.acildigiTarih);
    timePast = now.difference(widget.event.acildigiTarih).inHours;
  }

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
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: (timePast < 24)
                    ? timeFormatted
                    : dateFormatted
                ),
                const TextSpan(text: ' tarihinde ', style: TextStyle(color: Colors.grey,),),
                TextSpan(text: (widget.event.acanKisi)),
                const TextSpan(text: ' tarafından açıldı.', style: TextStyle(color: Colors.grey,),)
              ],
            ),
          ),
          const SizedBox(height: 5,),
          RichText(
            text: TextSpan(
                children: <TextSpan>[
                  TextSpan(text: (widget.event.arkadasGrubu)),
                  const TextSpan(text: ' ile paylaşıldı.', style: TextStyle(color: Colors.grey,),),
                ]
            ),
          ),
          const SizedBox(height: 5,),
          RichText(
            text: TextSpan(
                children: <TextSpan>[
                  TextSpan(text: (widget.event.lokasyon)),
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
          const SizedBox(height: 8,),
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
                    Text('Ayrıntılar'),
                    SizedBox(height: 5,),
                    RulesTile(icon: Icon(Icons.no_drinks, color: Colors.grey, size: 20), content: 'İçkini kendin getir'),
                    RulesTile(icon: Icon(Icons.sports_football, color: Colors.grey, size: 20), content: 'Guys night',)
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

class RulesTile extends StatelessWidget {
  const RulesTile({
    required this.icon,
    required this.content,
    Key? key,
  }) : super(key: key);

  final Icon icon;
  final String content;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(content, style: TextStyle(color: Colors.grey),),
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: -10,
      visualDensity: const VisualDensity(vertical: -1.5),
      dense: true,
    );
  }
}