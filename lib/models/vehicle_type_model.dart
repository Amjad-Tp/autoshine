class VehicleTypeModel {
  final String vehicleType;
  final String category;
  final String brandName;
  final String modelName;
  final String vehicleImagePath;

  VehicleTypeModel({
    required this.vehicleType,
    required this.category,
    required this.brandName,
    required this.modelName,
    required this.vehicleImagePath,
  });

  factory VehicleTypeModel.fromMap(Map<String, dynamic> map) {
    return VehicleTypeModel(
      vehicleType: map['vehicleType'] ?? '',
      category: map['category'] ?? '',
      brandName: map['brandName'] ?? '',
      modelName: map['modelName'] ?? '',
      vehicleImagePath: map['vehicleImagePath'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'vehicleType': vehicleType,
      'category': category,
      'brandName': brandName,
      'modelName': modelName,
      'vehicleImagePath': vehicleImagePath,
    };
  }
}
