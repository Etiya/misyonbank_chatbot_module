import 'package:flutter/material.dart';

class FileData {
  FileData({
    required this.url,
    required this.mime,
    required this.type,
    required this.subText,
    this.imageUrl,
  });
  final String url;
  final ImageProvider? imageUrl;
  final String mime;
  final String type;
  final String subText;
}
