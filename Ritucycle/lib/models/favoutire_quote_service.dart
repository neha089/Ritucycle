// import 'package:shared_preferences/shared_preferences.dart';
// import '../models/quote.dart';
//
// class FavoriteQuotesService {
//   static const String favoritesKey = 'favorite_quotes';
//
//   Future<void> saveFavoriteQuote(Quote quote) async {
//     final prefs = await SharedPreferences.getInstance();
//     final favorites = prefs.getStringList(favoritesKey) ?? [];
//     favorites.add(quote.text);
//     prefs.setStringList(favoritesKey, favorites);
//   }
//
//   Future<List<Quote>> getFavoriteQuotes() async {
//     final prefs = await SharedPreferences.getInstance();
//     final favoriteTexts = prefs.getStringList(favoritesKey) ?? [];
//     final quotes = [
//       // Add the same list of quotes here
//     ];
//     return quotes.where((quote) => favoriteTexts.contains(quote.text)).toList();
//   }
// }
