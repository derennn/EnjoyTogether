class Event {
  String lokasyon;
  String arkadasGrubu;
  bool arkadasGetirmekSerbestMi;
  String acanKisi;
  DateTime acildigiTarih;

  Event(this.lokasyon, this.arkadasGrubu, this.arkadasGetirmekSerbestMi, this.acanKisi, this.acildigiTarih);

  Event.fromMap(Map<String, dynamic> m)
      : lokasyon = m['lokasyon'],
        arkadasGrubu = m['arkadasGrubu'],
        arkadasGetirmekSerbestMi = m['arkadasGetirmekSerbestMi'],
        acanKisi = m['acanKisi'],
        acildigiTarih = DateTime.parse(m['acildigiTarih'])
  ;


  Map toMap() {
    return {
      'lokasyon' : lokasyon,
      'arkadasGrubu' : arkadasGrubu,
      'arkadasGetirmekSerbestMi' : arkadasGetirmekSerbestMi,
      'acanKisi' : acanKisi,
      'acildigiTarih' : acildigiTarih.toIso8601String(),
    };
  }

}