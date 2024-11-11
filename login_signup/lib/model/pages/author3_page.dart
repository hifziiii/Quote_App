import 'package:flutter/material.dart';
import 'package:login_signup/view/home/screens/FavoriteScreen.dart';
import 'package:login_signup/view/home/screens/QuotesScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Author3Page extends StatefulWidget {
  @override
  _Author3PageState createState() => _Author3PageState();
}

class _Author3PageState extends State<Author3Page> {
  PageController _pageController = PageController();
  int _currentPage = 0;
  List<Map<String, String>> _favoriteQuotes = [];
  final List<Map<String, String>> _authors = [
    {'name': 'Maya Angelou', 'quote': 'You will face many defeats in life, but never let yourself be defeated.'},
    {'name': 'Maya Angelou', 'quote': 'I’ve learned that people will forget what you said, people will forget what you did, but people will never forget how you made them feel.'},
    {'name': 'Maya Angelou', 'quote': 'Nothing will work unless you do.'},
    {'name': 'Maya Angelou', 'quote': 'Life is not measured by the number of breaths we take, but by the moments that take our breath away.'},
    {'name': 'Maya Angelou', 'quote': 'If you don’t like something, change it. If you can’t change it, change your attitude.'},
    {'name': 'Maya Angelou', 'quote': 'We may encounter many defeats but we must not be defeated.'},
    {'name': 'Maya Angelou', 'quote': 'I can be changed by what happens to me, but I refuse to be reduced by it.'},
    {'name': 'Maya Angelou', 'quote': 'You may not control all the events that happen to you, but you can control your attitude toward them.'},
    {'name': 'Maya Angelou', 'quote': 'Try to be a rainbow in someone’s cloud.'},
    {'name': 'Maya Angelou', 'quote': 'I am my best work—a series of road maps, reports, recipes, doodles, and prayers from the front lines.'},
    {'name': 'Maya Angelou', 'quote': 'It’s one of the greatest gifts you can give yourself, to forgive.'},
    {'name': 'Maya Angelou', 'quote': 'You alone are enough. You have nothing to prove to anybody.'},
    {'name': 'Maya Angelou', 'quote': 'The horizon leans forward, offering you space to place new steps of change.'},
    {'name': 'Maya Angelou', 'quote': 'I’ve learned that even when I have pains, I don’t have to be one.'},
    {'name': 'Maya Angelou', 'quote': 'Life loves the liver of it.'},
    {'name': 'Maya Angelou', 'quote': 'You may encounter many defeats, but you must not be defeated.'},
    {'name': 'Maya Angelou', 'quote': 'A wise woman wishes to be no one’s enemy; a wise woman refuses to be anyone’s victim.'},
    {'name': 'Maya Angelou', 'quote': 'There is no greater agony than bearing an untold story inside you.'},
    {'name': 'Maya Angelou', 'quote': 'I can’t control how I feel, but I can control how I act.'},
    {'name': 'Maya Angelou', 'quote': 'We need much less than we think we need.'},
    {'name': 'Maya Angelou', 'quote': 'To describe my mother would be to write about a hurricane in its perfect power.'},
    {'name': 'Maya Angelou', 'quote': 'The only thing that’s really yours is your own mind.'},
    {'name': 'Maya Angelou', 'quote': 'I’ve learned that whenever I decide something with an open heart, I usually make the right decision.'},
    {'name': 'Maya Angelou', 'quote': 'You don’t make mistakes, mistakes make you.'},
    {'name': 'Maya Angelou', 'quote': 'There is nothing so pitiful as a young cynic because he has gone from knowing nothing to believing nothing.'},
    {'name': 'Maya Angelou', 'quote': 'In all the world, there is no heart for me like yours.'},
    {'name': 'Maya Angelou', 'quote': 'I’ve learned that if I don’t ask, I won’t get.'},
    {'name': 'Maya Angelou', 'quote': 'I am grateful to be a woman. I must have done something great in another life.'},
    {'name': 'Maya Angelou', 'quote': 'You may not get what you want, but you will get what you need.'},
    {'name': 'Maya Angelou', 'quote': 'I believe that every person is born with a gift.'},
    {'name': 'Maya Angelou', 'quote': 'The more you know of your history, the more liberated you are.'},
    {'name': 'Maya Angelou', 'quote': 'You can’t use up creativity. The more you use, the more you have.'},
    {'name': 'Maya Angelou', 'quote': 'Love recognizes no barriers.'},
    {'name': 'Maya Angelou', 'quote': 'I’ve learned that the only way to get through the hard times is to keep going.'},
    {'name': 'Maya Angelou', 'quote': 'When you learn, teach. When you get, give.'},
    {'name': 'Maya Angelou', 'quote': 'I am a woman phenomenally. Phenomenal woman, that’s me.'},
    {'name': 'Maya Angelou', 'quote': 'The desire to reach for the stars is ambitious. The desire to reach hearts is wise.'},
    {'name': 'Maya Angelou', 'quote': 'We are only as blind as we want to be.'},
    {'name': 'Maya Angelou', 'quote': 'Life is not a crystal stair.'},
    {'name': 'Maya Angelou', 'quote': 'The cage bird sings for freedom.'},
    {'name': 'Maya Angelou', 'quote': 'I want to be a rainbow in someone’s cloud.'},
    {'name': 'Maya Angelou', 'quote': 'I am a dreamer. I am a doer.'},
    {'name': 'Maya Angelou', 'quote': 'The world is not a pleasant place to be without someone to hold and be held by.'},
    {'name': 'Maya Angelou', 'quote': 'You are the sum total of everything you’ve ever seen, heard, eaten, smelled, been told, forgot—it’s all there.'},
    {'name': 'Maya Angelou', 'quote': 'I’ve learned that I still have a lot to learn.'},
    {'name': 'Maya Angelou', 'quote': 'You are your best thing.'},
    {'name': 'Maya Angelou', 'quote': 'Do the best you can until you know better. Then when you know better, do better.'},
    {'name': 'Maya Angelou', 'quote': 'Nothing can dim the light which shines from within.'},
    {'name': 'Maya Angelou', 'quote': 'People will not remember what you did for a living. They will remember how you made them feel.'},
    {'name': 'Maya Angelou', 'quote': 'I’ve learned that when you’re in a dark place, you think you’ve been buried, but you’ve actually been planted.'},
    {'name': 'Maya Angelou', 'quote': 'I believe in the power of the spoken word.'},
    {'name': 'Maya Angelou', 'quote': 'As long as you’re breathing, it’s never too late to do some good.'},
    {'name': 'Maya Angelou', 'quote': 'One isn’t necessarily born with courage. One is born with potential. Without courage, we cannot practice any other virtue.'}
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maya Angelou',
          style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xffE57373),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  QuotesScreen()),);
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
                IconButton(
                  icon: Icon(
                    _isFavorite(_currentPage) ? Icons.favorite : Icons.favorite_border,
                    color: _isFavorite(_currentPage) ? Colors.red : Colors.grey,
                  ),
                  onPressed: () => _toggleFavorite(_currentPage),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
