class Plan {
  final int id;
  final String nom;

  Plan({required this.id, required this.nom});

  Plan.fromJson(Map<String, dynamic> json):
        id = json['id_plan'],
        nom = json['nom'];
}