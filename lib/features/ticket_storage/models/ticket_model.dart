import 'package:equatable/equatable.dart';

class Ticket extends Equatable {
  String title;
  String url;
  double downloadProgress;
  double downloadedSize;
  double totalSize;

  Ticket({
    required this.title,
    required this.url,
    this.downloadProgress = 0,
    this.downloadedSize = 0,
    this.totalSize = 0,
  });

  @override
  List<Object?> get props =>
      [title, url, downloadProgress, downloadedSize, totalSize];

  Ticket copyWith({
    String? title,
    String? url,
    double? downloadProgress,
    double? downloadedSize,
    double? totalSize,
  }) {
    return Ticket(
      title: title ?? this.title,
      url: url ?? this.url,
      downloadProgress: downloadProgress ?? this.downloadProgress,
      downloadedSize: downloadedSize ?? this.downloadedSize,
      totalSize: totalSize ?? this.totalSize,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'url': url,
      'downloadProgress': downloadProgress,
      'downloadedSize': downloadedSize,
      'totalSize': totalSize,
    };
  }

  static Ticket fromJson(Map<String, dynamic> json) {
    return Ticket(
      title: json['title'],
      url: json['url'],
      downloadProgress: json['downloadProgress'],
      downloadedSize: json['downloadedSize'],
      totalSize: json['totalSize'],
    );
  }
}
