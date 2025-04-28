class ServiceModel {
  final String id;
  final String name;
  final double charge;
  final List<String> tasks;
  final String imageUrl;

  ServiceModel({
    required this.id,
    required this.name,
    required this.charge,
    required this.tasks,
    required this.imageUrl,
  });

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      charge: (map['charge'] ?? 0).toDouble(),
      tasks: List<String>.from(map['tasks'] ?? []),
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}
