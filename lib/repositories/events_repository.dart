import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agalarla_mac/services/data_services.dart';
import 'package:agalarla_mac/basic_classes/event_class.dart';

class EventsRepository extends ChangeNotifier{
  final DataService dataService;

  EventsRepository(this.dataService);

  List<Event> events = [];

  Future<void> getOneEvent(int input) async {
    var event = await dataService.getEvent(input);

    events.add(event);
    notifyListeners();
  }

  Future<List<Event>> getAllEvents() async{
   events = await dataService.getAllEvents();
   return events;
  }
}

final eventsRepositoryProvider = ChangeNotifierProvider((ref) {
  return EventsRepository(ref.watch(dataServiceProvider));
});

final eventsListProvider = FutureProvider((ref) {
  return ref.watch(eventsRepositoryProvider).getAllEvents();
});