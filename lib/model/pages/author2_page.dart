import 'package:flutter/material.dart';
import 'package:login_signup/view/home/screens/FavoriteScreen.dart';
import 'package:login_signup/view/home/screens/QuotesScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class Author2Page extends StatefulWidget {
  @override
  _Author2PageState createState() => _Author2PageState();
}

class _Author2PageState extends State<Author2Page> {
  PageController _pageController = PageController();
  int _currentPage = 0;
  List<Map<String, String>> _favoriteQuotes = [];
  final List<Map<String, String>> _authors =[
    {'name': 'Albert Einstein', 'quote': 'Life is like riding a bicycle. To keep your balance, you must keep moving.'},
    {'name': 'Albert Einstein', 'quote': 'A person who never made a mistake never tried anything new.'},
    {'name': 'Albert Einstein', 'quote': 'The important thing is not to stop questioning. Curiosity has its own reason for existence.'},
    {'name': 'Albert Einstein', 'quote': 'Strive not to be a success, but rather to be of value.'},
    {'name': 'Albert Einstein', 'quote': 'In the middle of difficulty lies opportunity.'},
    {'name': 'Albert Einstein', 'quote': 'Imagination is more important than knowledge. For knowledge is limited, whereas imagination embraces the entire world.'},
    {'name': 'Albert Einstein', 'quote': 'We cannot solve our problems with the same thinking we used when we created them.'},
    {'name': 'Albert Einstein', 'quote': 'Peace cannot be kept by force; it can only be achieved by understanding.'},
    {'name': 'Albert Einstein', 'quote': 'I have no special talent. I am only passionately curious.'},
    {'name': 'Albert Einstein', 'quote': 'Life is a preparation for the future; and the best preparation for the future is to live as if there were none.'},
    {'name': 'Albert Einstein', 'quote': 'The most beautiful experience we can have is the mysterious.'},
    {'name': 'Albert Einstein', 'quote': 'A calm and modest life brings more happiness than the pursuit of success combined with constant restlessness.'},
    {'name': 'Albert Einstein', 'quote': 'The greatest scientists are artists as well.'},
    {'name': 'Albert Einstein', 'quote': 'Try not to become a man of success, but rather try to become a man of value.'},
    {'name': 'Albert Einstein', 'quote': 'The true sign of intelligence is not knowledge but imagination.'},
    {'name': 'Albert Einstein', 'quote': 'You can’t blame gravity for falling in love.'},
    {'name': 'Albert Einstein', 'quote': 'Life is short, and it is up to you to make it sweet.'},
    {'name': 'Albert Einstein', 'quote': 'Everything should be made as simple as possible, but not simpler.'},
    {'name': 'Albert Einstein', 'quote': 'A human being is a part of the whole called by us universe.'},
    {'name': 'Albert Einstein', 'quote': 'Anyone who stops learning is old, whether at twenty or eighty.'},
    {'name': 'Albert Einstein', 'quote': 'No problem can be solved from the same level of consciousness that created it.'},
    {'name': 'Albert Einstein', 'quote': 'Everything has changed but the way we think.'},
    {'name': 'Albert Einstein', 'quote': 'Time is an illusion.'},
    {'name': 'Albert Einstein', 'quote': 'We are all very ignorant. What happens is that not all ignorance is the same.'},
    {'name': 'Albert Einstein', 'quote': 'It is the supreme art of the teacher to awaken joy in creative expression and knowledge.'},
    {'name': 'Albert Einstein', 'quote': 'Look deep into nature, and then you will understand everything better.'},
    {'name': 'Albert Einstein', 'quote': 'The only source of knowledge is experience.'},
    {'name': 'Albert Einstein', 'quote': 'The measure of intelligence is the ability to change.'},
    {'name': 'Albert Einstein', 'quote': 'Everything that is really great and inspiring is created by the individual who can labor in freedom.'},
    {'name': 'Albert Einstein', 'quote': 'What is right is not always popular, and what is popular is not always right.'},
    {'name': 'Albert Einstein', 'quote': 'Life is made up of everlasting moments that are simply too beautiful to ignore.'},
    {'name': 'Albert Einstein', 'quote': 'Wisdom is not the product of schooling but of the lifelong attempt to acquire it.'},
    {'name': 'Albert Einstein', 'quote': 'You never fail until you stop trying.'},
    {'name': 'Albert Einstein', 'quote': 'The best way to cheer yourself is to try to cheer someone else up.'},
    {'name': 'Albert Einstein', 'quote': 'In the midst of winter, I found there was, within me, an invincible summer.'},
    {'name': 'Albert Einstein', 'quote': 'The most valuable thing you can make is a mistake—you can’t learn anything from being perfect.'},
    {'name': 'Albert Einstein', 'quote': 'Human beings must have action; and they will make it if they cannot find it.'},
    {'name': 'Albert Einstein', 'quote': 'Everything that can be counted does not necessarily count; everything that counts cannot necessarily be counted.'},
    {'name': 'Albert Einstein', 'quote': 'I never think of the future. It comes soon enough.'},
    {'name': 'Albert Einstein', 'quote': 'A question that sometimes drives me hazy: am I or are the others crazy?'},
    {'name': 'Albert Einstein', 'quote': 'Life is a mystery to be lived, not a problem to be solved.'},
    {'name': 'Albert Einstein', 'quote': 'Life without experience and sufferings is not life.'},
    {'name': 'Albert Einstein', 'quote': 'The mind that opens to a new idea never returns to its original size.'},
    {'name': 'Albert Einstein', 'quote': 'The universe does not have laws; it has habits.'},
    {'name': 'Albert Einstein', 'quote': 'Everything is determined, the beginning as well as the end, by forces over which we have no control.'},
    {'name': 'Albert Einstein', 'quote': 'I have no idea what I may appear to the world, but to myself I seem to have been like a boy playing on the seashore.'},
    {'name': 'Albert Einstein', 'quote': 'The best and most beautiful things in the world cannot be seen or even touched, but just felt in the heart.'}
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
          'Albert Einstein',
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