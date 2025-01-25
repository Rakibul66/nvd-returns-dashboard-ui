class Address {
  String zip;
  String city;
  String name;
  String phone;
  String state;
  String country;
  String street1;
  String street2;

  Address({
    required this.zip,
    required this.city,
    required this.name,
    required this.phone,
    required this.state,
    required this.country,
    required this.street1,
    this.street2 = '',
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      zip: json['zip'],
      city: json['city'],
      name: json['name'],
      phone: json['phone'],
      state: json['state'],
      country: json['country'],
      street1: json['street1'],
      street2: json['street2'] ?? '',
    );
  }
}
