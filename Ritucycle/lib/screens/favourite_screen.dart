// import 'package:flutter/material.dart';
// import '../services/favorite_quotes_service.dart';
//
// class FavoritesScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Quote>>(
//       future: FavoriteQuotesService().getFavoriteQuotes(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text('Error fetching favorites');
//         } else if (snapshot.hasData) {
//           final favorites = snapshot.data!;
//           return ListView.builder(
//             itemCount: favorites.length,
//             itemBuilder: (context, index) {
//               final quote = favorites[index];
//               return ListTile(
//                 title: Text(quote.text),
//                 subtitle: Text('- ${quote.author}'),
//               );
//             },
//           );
//         } else {
//           return Text('No favorites yet');
//         }
//       },
//     );
//   }
// }
