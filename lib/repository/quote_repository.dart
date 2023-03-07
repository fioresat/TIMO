import 'package:firebase_database/firebase_database.dart';
import 'package:todo_app_main_screen/models/quote_model.dart';

class QuoteRepository {
  static final List<QuoteModel> quotes = [];

  static void getQuotesStream() async {
    final ref = FirebaseDatabase.instance.ref("quotes/");
    await for (final event in ref.onValue) {
      final map = event.snapshot.value as Map<dynamic, dynamic>?;
      if (map != null) {
        map.values.forEach((e) {
          quotes.add(QuoteModel(author: e['author'], content: e['content']));
        });
      }
    }
  }

  static List<QuoteModel> get getQuotes => quotes;
}
