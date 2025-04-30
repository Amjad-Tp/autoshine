class TimeSlotModel {
  final String time;
  final bool isBooked;

  TimeSlotModel({required this.time, required this.isBooked});

  factory TimeSlotModel.fromMap(Map<String, dynamic> map, String time) {
    return TimeSlotModel(time: time, isBooked: map['isBooked'] ?? false);
  }

  Map<String, dynamic> toMap() {
    return {'isBooked': isBooked};
  }
}
