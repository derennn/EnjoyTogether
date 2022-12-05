class Event {
  String lokasyon;
  String arkadasGrubu;
  bool arkadasGetirmekSerbestMi;

  Event(this.lokasyon, this.arkadasGrubu, this.arkadasGetirmekSerbestMi);

  Event.fromMap(Map<String, dynamic> m)
      : lokasyon = m['lokasyon'],
        arkadasGrubu = m['arkadasGrubu'],
        arkadasGetirmekSerbestMi = m['arkadasGetirmekSerbestMi'];


  Map toMap() {
    return {
      'lokasyon' : lokasyon,
      'arkadasGrubu' : arkadasGrubu,
      'arkadasGetirmekSerbestMi' : arkadasGetirmekSerbestMi,
    };
  }

}