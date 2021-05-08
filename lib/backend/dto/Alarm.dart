class Alarm {
  final int id;
  final int length;
  final DateTime dateTime;
  final String owner;
  final String destination;
  final String message;

  Alarm(this.id, this.length, this.dateTime, this.owner, this.destination,
      this.message);

  Alarm.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        dateTime = DateTime.parse(json['dateTime']),
        owner = json['owner'],
        destination = json['destination'],
        message = json['message'],
        length = json['length'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'dateTime': dateTime.toIso8601String(),
        'owner': owner,
        'destination': destination,
        'message': message,
        'length': length
      };
}
