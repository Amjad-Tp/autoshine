class AddressModel {
  final String id;
  final String addressType;
  final String firstName;
  final String? lastName;
  final String phone;
  final String? alternativePhone;
  final String house;
  final String pinCode;
  final String city;
  final String? landmark;
  final bool isDefault;

  AddressModel({
    required this.id,
    required this.addressType,
    required this.firstName,
    this.lastName,
    required this.phone,
    this.alternativePhone,
    required this.house,
    required this.pinCode,
    required this.city,
    this.landmark,
    this.isDefault = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'addressType': addressType,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'alternativePhone': alternativePhone,
      'house': house,
      'pinCode': pinCode,
      'city': city,
      'landmark': landmark,
      'isDefault': isDefault,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] ?? '',
      addressType: map['addressType'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'],
      phone: map['phone'] ?? '',
      alternativePhone: map['alternativePhone'],
      house: map['house'] ?? '',
      pinCode: map['pinCode'] ?? '',
      city: map['city'] ?? '',
      landmark: map['landmark'],
      isDefault: map['isDefault'] ?? false,
    );
  }
}
