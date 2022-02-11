import 'dart:convert';

class MovieWallpaper {
  int id;
  String title;
  String src;
  int movie;
  MovieWallpaper({
    required this.id,
    required this.title,
    required this.src,
    required this.movie,
  });

  MovieWallpaper copyWith({
    int? id,
    String? title,
    String? src,
    int? movie,
  }) {
    return MovieWallpaper(
      id: id ?? this.id,
      title: title ?? this.title,
      src: src ?? this.src,
      movie: movie ?? this.movie,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'src': src,
      'movie': movie,
    };
  }

  factory MovieWallpaper.fromMap(Map<String, dynamic> map) {
    return MovieWallpaper(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      src: map['src'] ?? '',
      movie: map['movie']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieWallpaper.fromJson(String source) =>
      MovieWallpaper.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MovieWallpaper(id: $id, title: $title, src: $src, movie: $movie)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MovieWallpaper &&
        other.id == id &&
        other.title == title &&
        other.src == src &&
        other.movie == movie;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ src.hashCode ^ movie.hashCode;
  }
}
