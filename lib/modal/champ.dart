class Champ {
  final int id;
  final String nom;
  final String spe;

  Champ({required this.id, required this.nom, required this.spe});

  Champ.fromJson(Map<String, dynamic> json):
        id = json['id_champ'],
        nom = json['nom'],
        spe = json['spe'];

  @override
  String toString() {
    return 'Champ{id: $id, nom: $nom, spe: $spe}';
  }
}