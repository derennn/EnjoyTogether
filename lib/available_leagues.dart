import 'package:flutter_riverpod/flutter_riverpod.dart';

final Set<String> availableSports =  {'Futbol', 'Basketbol', 'Voleybol'};
final Set<String> availableFootballLeagues = {'Süper Lig', 'Premier League', 'Bundesliga', 'Ligue1'};

final availableSportsProvider = Provider<Set<String>>((ref) {
  return availableSports;
});

final availableFootballLeaguesProvider = Provider<Set<String>>((ref) {
  return availableFootballLeagues;
});
