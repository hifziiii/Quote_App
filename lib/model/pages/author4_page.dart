import 'package:flutter/material.dart';
import 'package:login_signup/view/home/screens/FavoriteScreen.dart';
import 'package:login_signup/view/home/screens/QuotesScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class Author4Page extends StatefulWidget {
  @override
  _Author4PageState createState() => _Author4PageState();
}

class _Author4PageState extends State<Author4Page> {
  PageController _pageController = PageController();
  int _currentPage = 0;
  List<Map<String, String>> _favoriteQuotes = [];
  final List<Map<String, String>> _authors = [
    {'name': 'William Shakespeare', 'quote': 'To be, or not to be, that is the question.'},
    {'name': 'William Shakespeare', 'quote': 'All the world’s a stage, and all the men and women merely players.'},
    {'name': 'William Shakespeare', 'quote': 'The better part of Valour, is Discretion.'},
    {'name': 'William Shakespeare', 'quote': 'Life is not a bed of roses.'},
    {'name': 'William Shakespeare', 'quote': 'All that glitters is not gold.'},
    {'name': 'William Shakespeare', 'quote': 'Love all, trust a few, do wrong to none.'},
    {'name': 'William Shakespeare', 'quote': 'This above all: to thine own self be true.'},
    {'name': 'William Shakespeare', 'quote': 'There is nothing either good or bad, but thinking makes it so.'},
    {'name': 'William Shakespeare', 'quote': 'The course of true love never did run smooth.'},
    {'name': 'William Shakespeare', 'quote': 'Parting is such sweet sorrow.'},
    {'name': 'William Shakespeare', 'quote': 'Brevity is the soul of wit.'},
    {'name': 'William Shakespeare', 'quote': 'We are such stuff as dreams are made on.'},
    {'name': 'William Shakespeare', 'quote': 'What’s done is done.'},
    {'name': 'William Shakespeare', 'quote': 'The lady doth protest too much, methinks.'},
    {'name': 'William Shakespeare', 'quote': 'The fault, dear Brutus, is not in our stars, but in ourselves.'},
    {'name': 'William Shakespeare', 'quote': 'The more I give to thee, the more I have, for both are infinite.'},
    {'name': 'William Shakespeare', 'quote': 'Age is the fee of life.'},
    {'name': 'William Shakespeare', 'quote': 'There is a tide in the affairs of men.'},
    {'name': 'William Shakespeare', 'quote': 'Hope is the thing with feathers.'},
    {'name': 'William Shakespeare', 'quote': 'Be not afraid of life.'},
    {'name': 'William Shakespeare', 'quote': 'It is not in the stars to hold our destiny but in ourselves.'},
    {'name': 'William Shakespeare', 'quote': 'Things done well and with a care, exempt themselves from fear.'},
    {'name': 'William Shakespeare', 'quote': 'We know what we are, but know not what we may be.'},
    {'name': 'William Shakespeare', 'quote': 'Wisely and slow. They stumble that run fast.'},
    {'name': 'William Shakespeare', 'quote': 'Give me my own again.'},
    {'name': 'William Shakespeare', 'quote': 'Life is a journey, not a destination.'},
    {'name': 'William Shakespeare', 'quote': 'The web of our life is of a mingled yarn, good and ill together.'},
    {'name': 'William Shakespeare', 'quote': 'Time is the devourer of all things.'},
    {'name': 'William Shakespeare', 'quote': 'In time we hate that which we often fear.'},
    {'name': 'William Shakespeare', 'quote': 'The greatest gift is a portion of thyself.'},
    {'name': 'William Shakespeare', 'quote': 'The weak are victims of their own fears.'},
    {'name': 'William Shakespeare', 'quote': 'What can be more delightful than a heart that feels?'},
    {'name': 'William Shakespeare', 'quote': 'Life is a dream, and dreams are but shadows.'},
    {'name': 'William Shakespeare', 'quote': 'Be absolute for death; either death or life shall thereby be the sweeter.'},
    {'name': 'William Shakespeare', 'quote': 'The best is yet to come.'},
    {'name': 'William Shakespeare', 'quote': 'To do a great right do a little wrong.'},
    {'name': 'William Shakespeare', 'quote': 'When we are born, we cry that we are come to this great stage of fools.'},
    {'name': 'William Shakespeare', 'quote': 'The fool doth think he is wise, but the wise man knows himself to be a fool.'},
    {'name': 'William Shakespeare', 'quote': 'Life is full of uncertainties, but love remains constant.'},
    {'name': 'William Shakespeare', 'quote': 'There is no remedy for love but to love more.'},
    {'name': 'William Shakespeare', 'quote': 'Time shall unfold what plaited cunning hides.'},
    {'name': 'William Shakespeare', 'quote': 'Every man will be his own poet.'},
    {'name': 'William Shakespeare', 'quote': 'In peace, there’s nothing so becomes a man as modest stillness and humility.'},
    {'name': 'William Shakespeare', 'quote': 'Life’s but a walking shadow.'},
    {'name': 'William Shakespeare', 'quote': 'Our doubts are traitors and make us lose the good we oft might win.'},
    {'name': 'William Shakespeare', 'quote': 'Love is not love which alters when it alteration finds.'},
    {'name': 'William Shakespeare', 'quote': 'To thine own self be true.'},
    {'name': 'William Shakespeare', 'quote': 'What’s past is prologue.'},
    {'name': 'William Shakespeare', 'quote': 'He that hath a great soul hath a great desire.'}
  ];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedFavorites = prefs.getStringList('favoriteQuotes');
    if (storedFavorites != null) {
      setState(() {
        _favoriteQuotes = storedFavorites
            .map((quote) => Map<String, String>.from(jsonDecode(quote)))
            .toList();
      });
    }
  }

  void _toggleFavorite(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> quote = _authors[index];

    setState(() {
      if (_isFavorite(index)) {
        _favoriteQuotes.removeWhere((item) => item['quote'] == quote['quote']);
      } else {
        _favoriteQuotes.add(quote);
      }
    });

    List<String> encodedFavorites = _favoriteQuotes
        .map((quoteMap) => jsonEncode(quoteMap))
        .toList();
    await prefs.setStringList('favoriteQuotes', encodedFavorites);
  }

  bool _isFavorite(int index) {
    return _favoriteQuotes
        .any((item) => item['quote'] == _authors[index]['quote']);
  }

  // Function to copy the quote to the clipboard
  void _copyToClipboard(String quote) {
    Clipboard.setData(ClipboardData(text: quote));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Quote copied to clipboard!')),
    );
  }

  // Function to share the quote
  void _shareQuote(String quote, String author) {
    Share.share('"$quote" - $author');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'William Shakespeare',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xffE57373),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuotesScreen()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoriteScreen(favorites: _favoriteQuotes)),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _authors.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Container(
                    width: 400,
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.format_quote, size: 40, color: Colors.black),
                        SizedBox(height: 16),
                        Text(
                          _authors[index]['quote']!,
                          style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 16),
                        Text(
                          '- ${_authors[index]['name']}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Page ${_currentPage + 1} of ${_authors.length}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    // Favorite button
                    IconButton(
                      icon: Icon(
                        _isFavorite(_currentPage) ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorite(_currentPage) ? Colors.red : Colors.grey,
                      ),
                      onPressed: () => _toggleFavorite(_currentPage),
                    ),
                    // Copy button
                    IconButton(
                      icon: Icon(Icons.copy, color: Colors.grey),
                      onPressed: () => _copyToClipboard(_authors[_currentPage]['quote']!),
                    ),
                    // Share button
                    IconButton(
                      icon: Icon(Icons.share, color: Colors.grey),
                      onPressed: () => _shareQuote(
                        _authors[_currentPage]['quote']!,
                        _authors[_currentPage]['name']!,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}