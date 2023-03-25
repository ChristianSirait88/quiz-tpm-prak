import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'pokemon_data.dart';

import 'main.dart';
final Uri _url = Uri.parse('https://flutter.dev');

class PokemeonDetail extends StatefulWidget {

  final PokemonData data;
  const PokemeonDetail({Key? key, required this.data}) : super(key: key);
  @override
  _PokemeonDetailState createState() => _PokemeonDetailState();

}

class _PokemeonDetailState extends State<PokemeonDetail> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.name),
        actions: [
          IconButton(
              onPressed: () async {
                final snackBar = SnackBar(
                  content:Text(
                    '${widget.data.isFavorite ?  "Bukan Favorit lagi":"Berhasil Ditambahkan Ke Favorit"}',
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                setState(() {
                  widget.data.isFavorite = !widget.data.isFavorite ;
                });
              },
              icon: Icon(
                widget.data.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
              ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Center(

              child: AspectRatio(
                aspectRatio: 16/9,
                child: Image.network(widget.data.image),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Type: ',
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            Text('${widget.data.type}'),
            SizedBox(height: 8),
            Text(
              'Weakness: ',
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            Text('${widget.data.weakness}'),
            SizedBox(height: 8),
            Text(
              'Previous Evolution:',
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            Text('${widget.data.prevEvolution}'),
            SizedBox(height: 8),
            Text(
              'Next Evolution: ',
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            Text('${widget.data.nextEvolution}'),
            SizedBox(height: 8),
          ],
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _launchUrl('${widget.data.wikiUrl}');
        },
        tooltip: 'Search Wiki',
        child: const Icon(Icons.search),
      ),
    );
  }
  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
