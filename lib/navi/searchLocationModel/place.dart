class Place {
  //https://developers.google.com/maps/documentation/places/web-service/search-text?hl=ko
  //JSON 객체 저장 위한 클래스

  final String? name;
  final String? placeID;
  final double? lat;
  final double? lng;

  Place({
    this.name,
    this.placeID,
    this.lat,
    this.lng
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json['userId'],
      placeID: json['id'],
      lat: json['title'],
      lng: json['body'],
    );
  }
}