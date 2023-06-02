class GATO {
  final String amertume;
  final String gout;
  final String odorat;
  final String teneur;


  GATO({required this.amertume, required this.gout, required this.odorat, required this.teneur});

  GATO.fromJson(Map<String, dynamic> json):
        amertume = json['amertume'],
        gout = json['gout'],
        odorat = json['odorat'],
        teneur = json['teneur'];
}