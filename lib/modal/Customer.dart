class Customer {
  final int id;
  final String nom;
  final String prenom;
  final String pseudo;
  final String mail;
  final int deevee;

  Customer({required this.id, required this.nom, required this.prenom, required this.pseudo, required this.mail, required this.deevee});

  Customer.fromJson(Map<String, dynamic> json):
        id = json['id_joueur'],
        nom = json['nom'],
        prenom = json['prenom'],
        pseudo = json['pseudo'],
        mail = json['mail'],
        deevee = json['deevee'];
}