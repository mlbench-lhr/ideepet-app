import 'dart:io';

import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';

class UpdateUserRequest {
  String? name;
  String? email;
  String? phone;
  String? addressStreet;
  String? addressCity;
  String? addressState;
  String? addressZipCode;
  String? addressComplement;
  String? addressNumber;
  String? neightbourhood;
  String? addressLat;
  String? addressLong;
  File? image;

  UpdateUserRequest({
    this.name,
    this.email,
    this.phone,
    this.addressStreet,
    this.addressCity,
    this.addressState,
    this.addressZipCode,
    this.addressNumber,
    this.addressComplement,
    this.neightbourhood,
    this.addressLat,
    this.addressLong,
    this.image,
  });

  FormData toFormData() {
    final Map<String, dynamic> data = {};

    void add(String key, String? value) {
      if (value != null && value.trim().isNotEmpty) {
        data[key] = value;
      }
    }

    add('email', email);
    add('name', name);
    add('phone', phone != null ? '+55$phone' : null);
    add('address_street', addressStreet);
    add('address_city', addressCity);
    add('address_state', addressState);
    add('address_cep', addressZipCode);
    add('address_complement', addressComplement);
    add('address_neighborhood', neightbourhood);
    add('address_number', addressNumber);
    add('address_lat', addressLat);
    add('address_long', addressLong);

    /// ?? avatar só se existir
    if (image != null) {
      data['avatar'] = MultipartFile(
        image!,
        filename: image!.path.split('/').last,
      );
    }

    return FormData(data);
  }
}
