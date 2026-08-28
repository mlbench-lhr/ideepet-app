// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OsmRequest {
  final String address;
  final String number;
  final String city;
  final String state;
  final String country;
  final String postalCode;

  OsmRequest(
      {required this.address,
      required this.number,
      required this.city,
      required this.state,
      this.country = 'Brasil',
      required this.postalCode});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      'number': number,
      'city': city,
      'state': state,
      'country': country,
      'postalCode': postalCode,
    };
  }

  String toJson() => json.encode(toMap());

  String toString() =>
      '$address, $number, $city, $state, $country, $postalCode';
}
