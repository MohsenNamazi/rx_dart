import 'package:flutter/material.dart';
import 'package:rx_dart/data/models/animal.dart';
import 'package:rx_dart/data/models/person.dart';
import 'package:rx_dart/feature/search_result/rx/search_state.dart';

class SearchResultView extends StatelessWidget {
  const SearchResultView({required this.searchState, super.key});

  final Stream<SearchState?> searchState;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SearchState?>(
      stream: searchState,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final result = snapshot.data;

          if (result is SearchStatesHasError) {
            return const Text('Error');
          } else if (result is SearchStatesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (result is SearchStatesNoResult) {
            return const Text('No result found');
          } else if (result is SearchStatesWithResults) {
            final things = result.things;
            return ListView.builder(
              itemCount: things.length,
              itemBuilder: (context, index) {
                final item = things[index];
                late String title;
                if (item is Animal) {
                  title = 'Animal';
                } else if (item is Person) {
                  title = 'Person';
                } else {
                  title = 'Unknown';
                }
                return ListTile(
                  title: Text(title),
                  subtitle: Text(item.toString()),
                );
              },
            );
          } else {
            return const Text('Unknown state!');
          }
        } else {
          return const Text('Waiting...');
        }
      },
    );
  }
}
