class AddressModel {
  final String addressType;
  final String firstName;
  final String? lastName;
  final String phone;
  final String? alternativePhone;
  final String house;
  final String pinCode;
  final String city;
  final String? landmark;

  AddressModel({
    required this.addressType,
    required this.firstName,
    this.lastName,
    required this.phone,
    this.alternativePhone,
    required this.house,
    required this.pinCode,
    required this.city,
    this.landmark,
  });

  Map<String, dynamic> toMap() {
    return {
      'addressType': addressType,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'alternativePhone': alternativePhone,
      'house': house,
      'pinCode': pinCode,
      'city': city,
      'landmark': landmark,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      addressType: map['addressType'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'],
      phone: map['phone'] ?? '',
      alternativePhone: map['alternativePhone'],
      house: map['house'] ?? '',
      pinCode: map['pinCode'] ?? '',
      city: map['city'] ?? '',
      landmark: map['landmark'],
    );
  }
}
