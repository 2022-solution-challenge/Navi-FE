
class ChatInfoObject {
  final List<AccidentMarker> chatInfo;

  ChatInfoObject({
    required this.chatInfo,
  });

  factory ChatInfoObject.fromJson(List<dynamic> parsedJson) {
    List<AccidentMarker> accidents = [];
    accidents = parsedJson.map((i) => AccidentMarker.fromJson(i)).toList();

    return ChatInfoObject(chatInfo: accidents);
  }
}

class AccidentMarker {
  final String? roomId;
  final String? message;
  final String writer;

  AccidentMarker(
      {this.roomId,
      this.message,
      required this.writer});

  factory AccidentMarker.fromJson(Map<String, dynamic> json) {
    return AccidentMarker(
      roomId: json['roomId'],
      message: json['message'],
      writer: json['writer'],
    );
  }
}