class Room{
  final String name;
  final String url;

  const Room({
    required this.name,
    required this.url
  });

  factory Room.fromMap(String url, String name){
    return Room(
      name: name,
      url : url
    );
  }
}