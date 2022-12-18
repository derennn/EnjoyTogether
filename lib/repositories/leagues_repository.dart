import 'package:agalarla_mac/basic_classes/leagues_class.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userSubscribedLeaguesRepository = StateProvider<List<League>>((ref) {
  return [];
});