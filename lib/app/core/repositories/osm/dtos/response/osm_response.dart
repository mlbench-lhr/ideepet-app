// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:convert'; // Necessário para jsonDecode

/// Representa um único resultado de geocodificação da API Nominatim/OSM.
class OsmResponse {
  final String? lat; // Latitude
  final String? lon; // Longitude

  OsmResponse({
    this.lat,
    this.lon,
  });

  factory OsmResponse.fromMap(Map<String, dynamic> map) {
    return OsmResponse(
      lat: map['lat'],
      lon: map['lon'],
    );
  }

  factory OsmResponse.fromJson(String source) =>
      OsmResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
