import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/header_main.dart';
import '../widgets/footer_main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String apiKey = "43b293104d588c0b1ebaf65d26e701df"; // TMDb API Key
  final String baseUrl = "https://api.themoviedb.org/3";
  String youtubeTrailerKey = ""; // Store fetched trailer key
  int movieId = 634649; // Movie ID for "Spider-Man: No Way Home"
  bool isLoading = true; // Loading state for trailer

  final List<Map<String, String>> continueWatchingMovies = [
    {
      "title": "Avatar",
      "image": "https://image.tmdb.org/t/p/w500/jRXYjXNq0Cs2TcJjLkki24MLp7u.jpg"
    },
    {
      "title": "The Lion King",
      "image": "https://image.tmdb.org/t/p/w500/2bXbqYdUdNVa8VIWXVfclP2ICtT.jpg"
    },
    {
      "title": "Titanic",
      "image": "https://image.tmdb.org/t/p/w500/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg"
    },
    {
      "title": "Interstellar",
      "image": "https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg"
    },
    {
      "title": "The Dark Knight",
      "image": "https://image.tmdb.org/t/p/w500/1hRoyzDtpgMU7Dz4JF22RANzQO7.jpg"
    },
  ];

  final List<Map<String, String>> latestMovies = [
    {
      "title": "Black Panther",
      "image": "https://image.tmdb.org/t/p/w500/uxzzxijgPIY7slzFvMotPv8wjKA.jpg"
    },
    {
      "title": "The Avengers",
      "image": "https://image.tmdb.org/t/p/w500/RYMX2wcKCBAr24UyPD7xwmjaTn.jpg"
    },
    {
      "title": "Thor: Ragnarok",
      "image": "https://image.tmdb.org/t/p/w500/rzRwTcFvttcN1ZpX2xv4j3tSdJu.jpg"
    },
    {
      "title": "Iron Man",
      "image": "https://image.tmdb.org/t/p/w500/78lPtwv72eTNqFW9COBYI0dWDJa.jpg"
    },
    {
      "title": "Doctor Strange",
      "image": "https://image.tmdb.org/t/p/w500/uGBVj3bEbCoZbDjjl9wTxcygko1.jpg"
    },
    {
      "title": "Joker",
      "image": "https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg"
    },
  ];

  @override
  void initState() {
    super.initState();
    fetchTrailer();
  }

  Future<void> fetchTrailer() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/movie/$movieId/videos?api_key=$apiKey"),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'];

        if (results.isNotEmpty) {
          final trailer = results.firstWhere(
            (video) => video['type'] == 'Trailer' && video['site'] == 'YouTube',
            orElse: () => null,
          );

          if (trailer != null) {
            setState(() {
              youtubeTrailerKey = trailer['key'];
              isLoading = false;
            });
          } else {
            setState(() {
              isLoading = false;
            });
            print("No trailer found.");
          }
        } else {
          setState(() {
            isLoading = false;
          });
          print("No trailer results found.");
        }
      } else {
        setState(() {
          isLoading = false;
        });
        print("Failed to fetch trailer: ${response.statusCode}");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching trailer: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: Header(), // Custom header
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video Section
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              color: Colors.black,
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  : youtubeTrailerKey.isNotEmpty
                      ? YoutubePlayerWidget(videoId: youtubeTrailerKey)
                      : Center(
                          child: Text(
                            "No trailer available",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
            ),

            // Continue Watching Section
            SectionTitle(title: "Continue Watching"),
            MovieList(movies: continueWatchingMovies),

            // Latest Movies Section
            SectionTitle(title: "Latest Movies"),
            MovieGrid(movies: latestMovies),

            // Footer Section
            Footer(), // Custom footer
          ],
        ),
      ),
    );
  }
}

class YoutubePlayerWidget extends StatelessWidget {
  final String videoId;

  const YoutubePlayerWidget({required this.videoId});

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: YoutubePlayerController(
        initialVideoId: videoId,
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      ),
      showVideoProgressIndicator: true,
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Map<String, String>> movies;

  const MovieList({required this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: movie['image']!,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                  width: 120,
                  height: 150,
                ),
                SizedBox(height: 8),
                Text(
                  movie['title']!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MovieGrid extends StatelessWidget {
  final List<Map<String, String>> movies;

  const MovieGrid({required this.movies});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2 / 3,
      ),
      itemCount: movies.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final movie = movies[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(movie['image']!),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
