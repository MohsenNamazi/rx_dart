import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rxdart/rxdart.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Create the behavior subject everytime the widget is re-build
    final subject = useMemoized(
      () => BehaviorSubject<String>(),
      [key],
    );

    // dispose of the old subject everytime that the widget re-build
    useEffect(
      () => subject.close,
      [subject],
    );

    const initialText = 'Please start typing..';

    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<String>(
          stream: subject.stream
              .distinct()
              .debounceTime(const Duration(milliseconds: 500)),
          initialData: initialText,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            final data = snapshot.data;
            return Text(data != null && data != '' ? data : initialText);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          onChanged: subject.sink.add,
        ),
      ),
    );
  }
}
