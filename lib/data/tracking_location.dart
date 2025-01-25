class TrackingLocation {
  String? zip;
  String? city;
  String? state;
  String? country;
  String object;

  TrackingLocation({
    this.zip,
    this.city,
    this.state,
    this.country,
    required this.object,
  });

  factory TrackingLocation.fromJson(Map<String, dynamic> json) {
    return TrackingLocation(
      zip: json['zip'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      object: json['object'],
    );
  }
}
