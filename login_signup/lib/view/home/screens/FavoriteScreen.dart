import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Map<String, String>> _favoriteQuotes;

  FavoriteScreen({required List<Map<String, String>> favorites}) : _favoriteQuotes = favorites;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Quotes', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xffE57373),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _favoriteQuotes.isEmpty
          ? Center(child: Text("No favorites added yet!"))
          : ListView.builder(
        itemCount: _favoriteQuotes.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.format_quote),
            title: Text(_favoriteQuotes[index]['quote']!),
            subtitle: Text('- ${_favoriteQuotes[index]['name']}'),
          );
        },
      ),
    );
  }
}
