import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';

class PredictiveSearch extends StatelessWidget {
  const PredictiveSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(border: Border.all(color: white)),
        child: TypeAheadField(
          // textFieldConfiguration: TextFieldConfiguration(
          //   decoration: InputDecoration(
          //     hintText: 'Search...',
          //     border: OutlineInputBorder(),
          //   ),
          // ),
          suggestionsCallback: (pattern) async {
            // Return your search results
            var artists = [
              SearchItem(type: 'artist', name: 'Arijit Singh', code: 'ART001'),
              SearchItem(
                  type: 'artist', name: 'Shreya Ghoshal', code: 'ART002'),
            ];

            var codes = [
              SearchItem(
                  type: 'code', name: 'TONE123', additionalInfo: 'Popular'),
              SearchItem(
                  type: 'code', name: 'TONE456', additionalInfo: 'Trending'),
            ];

            // Build grouped list
            List<SearchItem> grouped = [];

            if (artists.isNotEmpty) {
              grouped.add(SearchItem(type: 'header', name: 'Artists'));
              grouped.addAll(artists);
            }

            if (codes.isNotEmpty) {
              grouped.add(SearchItem(type: 'header', name: 'Codes'));
              grouped.addAll(codes);
            }

            return grouped;
          },
          itemBuilder: (context, suggestion) {
            if (suggestion.type == 'header') {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Colors.grey.shade200,
                child: Text(
                  suggestion.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                ),
              );
            }

            // Artist row
            if (suggestion.type == 'artist') {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        suggestion.name,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Text(
                      suggestion.code ?? '',
                      style:
                          TextStyle(fontSize: 13, color: Colors.grey.shade600),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.person, size: 18, color: Colors.blue),
                  ],
                ),
              );
            }

            // Code row
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      suggestion.name,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    suggestion.additionalInfo ?? '',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.music_note, size: 18, color: Colors.green),
                ],
              ),
            );
          },
          onSelected: (t) {},
        ));
  }
}

class SearchItem {
  final String type; // 'header', 'artist', or 'code'
  final String name;
  final String? code;
  final String? additionalInfo;

  SearchItem({
    required this.type,
    required this.name,
    this.code,
    this.additionalInfo,
  });
}
