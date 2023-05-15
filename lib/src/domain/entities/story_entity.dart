// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Story extends Equatable {
  final String id;
  final String author;
  final String title;
  final String description;
  final String contentText;
  final String contentHtml;
  final bool approved;
  final List<String> imageUrls;
  final String creatorId;
  final String editorId;
  final int approvedAtUnixTimestamp;
  final String modificationLogs;
  final int updatedAtUnixTimestamp;
  final int createdAtUnixTimestamp;

  const Story({
    required this.id,
    required this.author,
    required this.title,
    required this.description,
    required this.contentText,
    required this.contentHtml,
    required this.approved,
    required this.imageUrls,
    required this.creatorId,
    required this.editorId,
    required this.approvedAtUnixTimestamp,
    required this.modificationLogs,
    required this.updatedAtUnixTimestamp,
    required this.createdAtUnixTimestamp,
  });

  @override
  List<Object> get props {
    return [
      id,
      author,
      title,
      description,
      contentText,
      contentHtml,
      approved,
      imageUrls,
      creatorId,
      editorId,
      approvedAtUnixTimestamp,
      modificationLogs,
      updatedAtUnixTimestamp,
      createdAtUnixTimestamp,
    ];
  }

  @override
  bool get stringify => true;
}
