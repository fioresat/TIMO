class QuoteModel {
  String author;
  String content;

  QuoteModel({
    required this.author,
    required this.content,
  });

  QuoteModel.fromJson(Map<String, dynamic> json)
      : author = json['author'].toString(),
        content = json['content'].toString();

  Map<String, dynamic> toJson() => {
        'author': author,
        'content': content,
      };
}
