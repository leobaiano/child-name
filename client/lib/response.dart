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

    print('Names: $names');

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: Text(
            'Response',
            style: TextStyle(fontSize: 20),
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
