class Address {
  String? name;
  String? phoneNumber;
  String? flatHouseNumber;
  String? streetNumber;
  String? city;
  String? stateCountry;
  String? completeAddress;
  Address({
    this.name,
    this.city,
    this.completeAddress,
    this.flatHouseNumber,
    this.phoneNumber,
    this.stateCountry,
    this.streetNumber,
  });
  Address.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    flatHouseNumber = json['flatHouseNumber'];
    streetNumber = json['streetNumber'];
    city = json['city'];
    stateCountry = json['stateCountry'];
    completeAddress = json['completeAddress'];
  }
}
