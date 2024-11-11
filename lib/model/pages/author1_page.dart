import 'package:flutter/material.dart';
import 'package:login_signup/view/home/screens/FavoriteScreen.dart';
import 'package:login_signup/view/home/screens/QuotesScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class Author1Page extends StatefulWidget {
  @override
  _Author1PageState createState() => _Author1PageState();
}

class _Author1PageState extends State<Author1Page> {
  PageController _pageController = PageController();
  int _currentPage = 0;
  List<Map<String, String>> _favoriteQuotes = [];

  final List<Map<String, String>> _authors = [
  {'name': 'Jane Austen', 'quote': 'It is not what we say or think that defines us, but what we do.'},
{'name': 'Jane Austen', 'quote': 'There is no charm equal to tenderness of heart.'},
{'name': 'Jane Austen', 'quote': 'Life seems but a quick succession of busy nothings.'},
{'name': 'Jane Austen', 'quote': 'To be fond of dancing was a certain step towards falling in love.'},
{'name': 'Jane Austen', 'quote': 'The business of her life was to get her daughters married.'},
{'name': 'Jane Austen', 'quote': 'Happiness depends upon ourselves.'},
{'name': 'Jane Austen', 'quote': 'You must learn some of my philosophy. Think only of the past as its remembrance gives you pleasure.'},
{'name': 'Jane Austen', 'quote': 'It is always worth a man’s while to be in love.'},
{'name': 'Jane Austen', 'quote': 'A man is never so well dressed as when he is in love.'},
{'name': 'Jane Austen', 'quote': 'I can listen no longer in silence. I must speak to you by such means as are within my reach.'},
{'name': 'Jane Austen', 'quote': 'There is nothing like staying at home for real comfort.'},
{'name': 'Jane Austen', 'quote': 'We each have a country of our own, a private retreat.'},
{'name': 'Jane Austen', 'quote': 'Every day may not be good, but there is something good in every day.'},
{'name': 'Jane Austen', 'quote': 'The only thing better than a good friend is a good friend with chocolate.'},
{'name': 'Jane Austen', 'quote': 'A single woman with a property of her own is quite an advantage.'},
{'name': 'Jane Austen', 'quote': 'A lady can never have too many dresses.'},
{'name': 'Jane Austen', 'quote': 'Selfishness must always be forgiven you know, because there is no hope of a cure.'},
{'name': 'Jane Austen', 'quote': 'It is a truth universally acknowledged, that a single man in possession of a good fortune, must be in want of a wife.'},
{'name': 'Jane Austen', 'quote': 'Let us never underestimate the power of a well-timed compliment.'},
{'name': 'Jane Austen', 'quote': 'A great mind is always willing to be little.'},
{'name': 'Jane Austen', 'quote': 'What are young men to rocks and mountains?'},
{'name': 'Jane Austen', 'quote': 'Friendship is certainly the finest balm for the pangs of disappointed love.'},
{'name': 'Jane Austen', 'quote': 'There is nothing I would not do for those who are really my friends.'},
{'name': 'Jane Austen', 'quote': 'To love is to be vulnerable.'},
{'name': 'Jane Austen', 'quote': 'You must allow me to tell you how ardently I admire and love you.'},
{'name': 'Jane Austen', 'quote': 'We all know that the truth is rarely pure and never simple.'},
{'name': 'Jane Austen', 'quote': 'Indulge your imagination in every possible flight.'},
{'name': 'Jane Austen', 'quote': 'One half of the world cannot understand the pleasures of the other.'},
{'name': 'Jane Austen', 'quote': 'No one can be really esteemed accomplished who does not greatly surpass what is usually met with.'},
{'name': 'Jane Austen', 'quote': 'It is well to have as many holds upon happiness as possible.'},
{'name': 'Jane Austen', 'quote': 'If I loved you less, I might be able to talk about it more.'},
{'name': 'Jane Austen', 'quote': 'There is something very pleasing in the simplicity of a good heart.'},
{'name': 'Jane Austen', 'quote': 'I may not be the best, but I am a very good version of myself.'},
{'name': 'Jane Austen', 'quote': 'To be perfect is to change often.'},
{'name': 'Jane Austen', 'quote': 'Our scars make us who we are.'},
{'name': 'Jane Austen', 'quote': 'It is only through the patience of another that we may discover our own.'},
{'name': 'Jane Austen', 'quote': 'In the middle of difficulty lies opportunity.'},
{'name': 'Jane Austen', 'quote': 'To sit in the shade on a fine day and look upon verdure is the most perfect refreshment.'},
{'name': 'Jane Austen', 'quote': 'What is right to be done cannot be done too soon.'},
{'name': 'Jane Austen', 'quote': 'In the course of a few years, a man may transform his character.'},
{'name': 'Jane Austen', 'quote': 'We can only learn to love by loving.'},
{'name': 'Jane Austen', 'quote': 'It is not everyone who has your talent for being annoying.'},
{'name': 'Jane Austen', 'quote': 'Beware how you take away hope from another human being.'},
{'name': 'Jane Austen', 'quote': 'A woman’s mind is as changeable as her dress.'},
{'name': 'Jane Austen', 'quote': 'A person is never so happy as when they are busy.'},
{'name': 'Jane Austen', 'quote': 'The capacity for friendship is a gift of God.'},
{'name': 'Jane Austen', 'quote': 'A man may be thought to be very good without being married.'},
{'name': 'Jane Austen', 'quote': 'A great deal of talent is lost to the world for want of a little courage.'},
{'name': 'Jane Austen', 'quote': 'Your feelings may be very different from mine.'},
{'name': 'Jane Austen', 'quote': 'The happiest women, like the happiest nations, have no history.'},
{'name': 'Jane Austen', 'quote': 'True love cannot be found where it does not exist, nor can it be denied where it does.'},
{'name': 'Jane Austen', 'quote': 'Seldom do we see the consequences of our decisions.'},
{'name': 'Jane Austen', 'quote': 'A mind lively and at ease can do with seeing nothing, and can see nothing that does not answer.'},
{'name': 'Jane Austen', 'quote': 'The purest and most innocent happiness is that which comes from friendship.'}
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
          'Jane Austen',
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