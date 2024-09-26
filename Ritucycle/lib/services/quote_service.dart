// import 'package:shared_preferences/shared_preferences.dart';
// import '../models/quote.dart';
//
// class QuoteService {
//   static const String lastQuoteDateKey = 'last_quote_date';
//   static const String currentQuoteKey = 'current_quote';
//
//   List<Quote> quotes = [
//     Quote(text: "Believe in yourself and all that you are.", author: "Unknown", theme: "positivity"),
//     Quote(text: "The only limit to our realization of tomorrow is our doubts of today.", author: "Franklin D. Roosevelt", theme: "resilience"),
//     // Add more quotes
//   ];
//
//   Future<Quote> getDailyQuote() async {
//     final prefs = await SharedPreferences.getInstance();
//     final today = DateTime.now().toIso8601String().split('T').first;
//
//     if (prefs.getString(lastQuoteDateKey) != today) {
//       final quote = _getRandomQuote();
//       prefs.setString(lastQuoteDateKey, today);
//       prefs.setString(currentQuoteKey, quote.text);
//       return quote;
//     }
//
//     final currentQuoteText = prefs.getString(currentQuoteKey) ?? '';
//     return quotes.firstWhere((quote) => quote.text == currentQuoteText);
//   }
//
//   Quote _getRandomQuote() {
//     return quotes[DateTime.now().millisecondsSinceEpoch % quotes.length];
//   }
// }
