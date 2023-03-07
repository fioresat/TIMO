// import 'package:firebase_database/firebase_database.dart';
// import 'package:todo_app_main_screen/models/quote_model.dart';
//
// class QuoteRepository {
//   static late QuoteModel quote;
//
//   static void getQuotesStream() async {
//     DatabaseReference ref =
//         FirebaseDatabase.instance.ref('quotes/');
//     ref.onValue.listen((DatabaseEvent event) {
//       final data = event.snapshot.value as Map<String, dynamic>;
//       quote = QuoteModel.fromJson(data);
//     });
//   }
//
//   static QuoteModel get getQuote => quote;
// }
