class Kafe {
  final int id;
  final String nom;
  final int cout;
  final int production;
  final int tps_pousse;

  Kafe({required this.cout,  required this.production, required this.tps_pousse, required this.id, required this.nom});

  Kafe.fromJson(Map<String, dynamic> json):
        id = json['id_kafe'],
        nom = json['nom'],
        cout = json['cout'],
        production = json['production'],
        tps_pousse = json['tps_pousse'];
}