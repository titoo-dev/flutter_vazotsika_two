import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtistTile extends StatelessWidget {
  final ArtistModel artistInfo;

  const ArtistTile({Key? key, required this.artistInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QueryArtworkWidget(
              id: artistInfo.id,
              type: ArtworkType.ARTIST,
              artworkFit: BoxFit.cover,
              nullArtworkWidget: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.black87,
                child: Center(
                  child: Text(
                    artistInfo.artist[0].toUpperCase(),
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              artistInfo.artist,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      ),
    );
  }
}
