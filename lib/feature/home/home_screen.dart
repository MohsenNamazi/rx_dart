import 'package:flutter/material.dart';
import 'package:rx_dart/data/network/api.dart';
import 'package:rx_dart/feature/search_result/rx/search_rx.dart';
import 'package:rx_dart/feature/search_result/search_result_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final SearchRx _searchRx;
  @override
  void initState() {
    super.initState();
    _searchRx = SearchRx(api: Api());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration:
                  const InputDecoration(hintText: 'Enter search term...'),
              onChanged: _searchRx.search.add,
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SearchResultView(
                searchState: _searchRx.state,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchRx.dispose();
    super.dispose();
  }
}
