class Meme {
  final String id;
  final String name;
  final String url;
  final int width;
  final int height;
  final int boxCount;
  final int captions;

  Meme({
    required this.id,
    required this.name,
    required this.url,
    required this.width,
    required this.height,
    required this.boxCount,
    required this.captions,
  });

  factory Meme.fromJson(Map<String, dynamic> json) {
    return Meme(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      width: json['width'],
      height: json['height'],
      boxCount: json['box_count'],
      captions: json['captions'],
    );
  }
}
