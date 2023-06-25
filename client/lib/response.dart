import 'package:flutter/material.dart';

class Response extends StatelessWidget {
  final List<Map<String, Object>> names;
  final void Function() onRestartQuiz;

  const Response({
    super.key,
    required this.names,
    required this.onRestartQuiz,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: names.length,
            itemBuilder: (BuildContext context, int index) {
              final nameMap = names[index];
              final nameList = nameMap['names'] as List<dynamic>;
              final nameStrings =
                  nameList.map((name) => name.toString()).toList();

              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: nameStrings.map((name) => Text(name)).toList(),
                ),
              );
            },
          ),
        ),
        TextButton(
          onPressed: onRestartQuiz,
          style: TextButton.styleFrom(
            minimumSize: const Size(300, 10),
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.all(20),
            foregroundColor: Colors.white,
          ),
          child: const Text(
            'Restart?',
            style: TextStyle(fontSize: 22),
          ),
        )
      ],
    );
  }
}
