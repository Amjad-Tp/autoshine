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

  // Convert JSON to VehicleTypeModel
  factory VehicleTypeModel.fromJson(Map<String, dynamic> json) {
    return VehicleTypeModel(
      vehicleType: json['vehicleType'] as String,
      category: json['category'] as String,
      brandName: json['brandName'] as String,
      modelName: json['modelName'] as String,
      vehicleImagePath: json['vehicleImagePath'] as String,
    );
  }

  // Convert VehicleTypeModel to JSON (for Firestore)
  Map<String, dynamic> toJson() {
    return {
      'vehicleType': vehicleType,
      'category': category,
      'brandName': brandName,
      'modelName': modelName,
      'vehicleImagePath': vehicleImagePath,
    };
  }
}
