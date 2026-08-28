import 'package:idee_pet/app/app.dart';

class SizeRequest {
  final String id;
  final PetSize petSize;

  SizeRequest({
    required this.id,
    required this.petSize,
  });

  Map<String, dynamic> toJson() {
    return {
      'size': petSize.json,
    };
  }
}
