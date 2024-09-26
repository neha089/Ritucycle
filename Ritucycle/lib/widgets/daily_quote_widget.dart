// import 'package:flutter/material.dart';
// import '../services/quote_service.dart';
// import '../models/quote.dart';
//
// class DailyQuoteWidget extends StatefulWidget {
//   @override
//   _DailyQuoteWidgetState createState() => _DailyQuoteWidgetState();
// }
//
// class _DailyQuoteWidgetState extends State<DailyQuoteWidget> {
//   late Future<Quote> _dailyQuote;
//
//   @override
//   void initState() {
//     super.initState();
//     _dailyQuote = QuoteService().getDailyQuote();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Quote>(
//       future: _dailyQuote,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text('Error fetching quote');
//         } else if (snapshot.hasData) {
//           final quote = snapshot.data!;
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 '"${quote.text}"',
//                 style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 '- ${quote.author}',
//                 style: TextStyle(fontSize: 16),
//               ),
//               IconButton(
//                 icon: Icon(Icons.favorite),
//                 onPressed: () {
//                   FavoriteQuotesService().saveFavoriteQuote(quote);
//                 },
//               ),
//             ],
//           );
//         } else {
//           return Text('No quote available');
//         }
//       },
//     );
//   }
// }
