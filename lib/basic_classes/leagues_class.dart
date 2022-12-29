import 'package:flutter/cupertino.dart';

class SportsLeague {
  String sports;
  String league;
  AssetImage image;

  SportsLeague(this.sports, this.league, this.image);

  SportsLeague.fromMap(Map<String, dynamic> m)
  : sports = m['sports'],
    league = m['league'],
    image = m['image']
  ;

  Map toMap() {
    return {
      'sports' : sports,
      'league' : league,
      'image' : image,
    };
  }

}