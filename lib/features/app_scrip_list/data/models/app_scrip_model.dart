class AppScripModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  final String company;
  final String companyCatchPhrase;
  final String companyBs;
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final double? lat;
  final double? lng;

  AppScripModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.company,
    required this.companyCatchPhrase,
    required this.companyBs,
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    this.lat,
    this.lng,
  });

  factory AppScripModel.fromJson(Map<String, dynamic> json) {
    final geo = json['address']?['geo'];
    return AppScripModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      website: json['website'] ?? '',
      company: json['company']?['name'] ?? '',
      companyCatchPhrase: json['company']?['catchPhrase'] ?? '',
      companyBs: json['company']?['bs'] ?? '',
      street: json['address']?['street'] ?? '',
      suite: json['address']?['suite'] ?? '',
      city: json['address']?['city'] ?? '',
      zipcode: json['address']?['zipcode'] ?? '',
      lat: geo != null ? double.tryParse(geo['lat'] ?? '') : null,
      lng: geo != null ? double.tryParse(geo['lng'] ?? '') : null,
    );
  }
}
