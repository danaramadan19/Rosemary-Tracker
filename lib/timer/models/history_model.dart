class History {
  DateTime dateTime;
  int focusedSecs;

  History({
    this.dateTime,
    this.focusedSecs,
  });

  Map<String, dynamic> toJson() => {
        "dateTime": dateTime.millisecondsSinceEpoch,
        "focusedSecs": focusedSecs,
      };

  History.fromJson(Map<String, dynamic> json)
      : dateTime = DateTime.fromMillisecondsSinceEpoch(json['dateTime']),
        focusedSecs = json['focusedSecs'];

  @override
  String toString() {
    return "\n{\n    dateTime: " +
        dateTime.toIso8601String() +
        ",\n    " +
        "focusedSecs: " +
        focusedSecs.toString() +
        "\n},\n";
  }
}
